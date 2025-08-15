package com.example.realestate.repository.custome.impl;

import com.example.realestate.builder.BuildingSearchBuilder;
import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.repository.custome.BuildingRepositoryCustom;
import org.springframework.data.domain.Pageable;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

public class BuildingRepositoryImpl implements BuildingRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(BuildingSearchBuilder buildingSearchBuilder, StringBuilder sql){
        Long staffid = buildingSearchBuilder.getStaffId();
        if(staffid != null) {
            sql.append("JOIN assignmentbuilding ON b.id = assignmentbuilding.buildingid ");
        }
    }

    public static void queryNormal(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where){
        try{
            Field[] fields = BuildingSearchBuilder.class.getDeclaredFields();
            for(Field item : fields){
                item.setAccessible(true);
                String fieldName = item.getName();
                if(!fieldName.equals("staffId") && !fieldName.equals("typeCode")
                        && !fieldName.startsWith("area")
                        && !fieldName.startsWith("rentPrice")) {
                    Object value = item.get(buildingSearchBuilder);
                    if (value != null) {
                        if (item.getType().getName().equals("java.lang.String")) {
                            String stringValue = value.toString().trim();
                            if (!stringValue.isEmpty()) {
                                where.append(" AND b.").append(fieldName).append(" LIKE '%").append(stringValue).append("%' ");
                            }
                        } else if (item.getType().getName().equals("java.lang.Long") || item.getType().getName().equals("java.lang.Integer")) {
                            where.append(" AND b.").append(fieldName).append(" = ").append(value);
                        }
                    }

                }
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public static void querySpecial(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where){
        Long staffid = buildingSearchBuilder.getStaffId();
        if(staffid != null) {
            where.append(" AND assignmentbuilding.staffid = " + staffid);
        }

        Long rentAreaFrom = buildingSearchBuilder.getAreaFrom();
        Long rentAreaTo = buildingSearchBuilder.getAreaTo();
        if(rentAreaTo != null || rentAreaFrom != null){
            where.append(" AND EXISTS (SELECT * FROM `rentarea` WHERE b.id = rentarea.buildingid ");
            if(rentAreaFrom != null) {
                where.append(" AND rentarea.value >= " + rentAreaFrom);
            }
            if(rentAreaTo != null) {
                where.append(" AND rentarea.value <= " + rentAreaTo);
            }
            where.append(") ");
        }

        Long rentPriceFrom = buildingSearchBuilder.getRentPriceFrom();
        Long rentPriceTo = buildingSearchBuilder.getRentPriceTo();
        if(rentPriceTo != null || rentPriceFrom != null) {
            if(rentPriceFrom != null) {
                where.append(" AND b.rentprice >= " + rentPriceFrom);
            }
            if(rentPriceTo != null) {
                where.append(" AND b.rentprice <= " + rentPriceTo);
            }
        }

        List<String> typeCode = buildingSearchBuilder.getTypeCode();
        if (typeCode != null && !typeCode.isEmpty()) {
            where.append(" AND (");
            String sql = typeCode.stream().map(item -> "b.type like " + "'%" + item + "%'").collect(Collectors.joining(" OR "));
            where.append(sql);
            where.append(") ");
        }
    }

    @Override
    public List<BuildingEntity> findAll(BuildingSearchBuilder builder, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT distinct b.* FROM building b ");
        joinTable(builder, sql);
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        queryNormal(builder, where);
        querySpecial(builder, where);
        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(BuildingSearchBuilder builder) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT b.id) FROM building b ");
        joinTable(builder, sql);

        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        queryNormal(builder, where);
        querySpecial(builder, where);

        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString());
        Number result = (Number) query.getSingleResult();
        return result.intValue();
    }
}
