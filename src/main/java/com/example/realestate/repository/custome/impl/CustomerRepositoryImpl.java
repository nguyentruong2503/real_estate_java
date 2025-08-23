package com.example.realestate.repository.custome.impl;

import com.example.realestate.builder.CustomerSearchBuilder;
import com.example.realestate.entity.CustomerEntity;
import com.example.realestate.repository.custome.CustomerRepositoryCustome;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
@Primary
public class CustomerRepositoryImpl implements CustomerRepositoryCustome {
    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(CustomerSearchBuilder customerSearchBuilder, StringBuilder sql){
        Long staffid = customerSearchBuilder.getStaffId();
        if(staffid != null) {
            sql.append("JOIN assignmentcustomer ON c.id = assignmentcustomer.customerid ");
        }
    }

    public static void queryNormal(CustomerSearchBuilder customerSearchBuilder, StringBuilder where){
        try{
            Field[] fields = CustomerSearchBuilder.class.getDeclaredFields();
            for(Field item : fields){
                item.setAccessible(true);
                String fieldName = item.getName();
                if(!fieldName.equals("staffId") ) {
                    Object value = item.get(customerSearchBuilder);
                    if (value != null) {
                        if (item.getType().getName().equals("java.lang.String")) {
                            String stringValue = value.toString().trim();
                            if (!stringValue.isEmpty()) {
                                where.append(" AND c.").append(fieldName).append(" LIKE '%").append(stringValue).append("%' ");
                            }
                        } else if (item.getType().getName().equals("java.lang.Long") || item.getType().getName().equals("java.lang.Integer")) {
                            where.append(" AND c.").append(fieldName).append(" = ").append(value);
                        }
                    }

                }
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public static void querySpecial(CustomerSearchBuilder customerSearchBuilder, StringBuilder where){
        Long staffid = customerSearchBuilder.getStaffId();
        if(staffid != null) {
            where.append(" AND assignmentcustomer.staffid = " + staffid);
        }
    }

    @Override
    public List<CustomerEntity> findAll(CustomerSearchBuilder customerSearchBuilder, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT distinct c.* FROM customer c ");
        joinTable(customerSearchBuilder, sql);
        StringBuilder where = new StringBuilder(" WHERE 1=1 AND c.is_active = 1 ");
        queryNormal(customerSearchBuilder, where);
        querySpecial(customerSearchBuilder, where);
        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);

        return query.getResultList();
    }

    @Override
    public int countTotalItems(CustomerSearchBuilder builder) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT c.id) FROM customer c ");
        joinTable(builder, sql);

        StringBuilder where = new StringBuilder(" WHERE 1=1 AND c.is_active = 1 ");
        queryNormal(builder, where);
        querySpecial(builder, where);

        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString());
        Number result = (Number) query.getSingleResult();
        return result.intValue();
    }
}
