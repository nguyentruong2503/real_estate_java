package com.example.realestate.converter;

import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.entity.RentAreaEntity;
import com.example.realestate.model.dto.BuildingDTO;
import com.example.realestate.repository.BuildingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class RentAreaConverter {
    @Autowired
    private BuildingRepository buildingRepository;

    public RentAreaEntity toRentAreaEntity(BuildingEntity buildingEntity, Long value){
        RentAreaEntity rentAreaEntity = new RentAreaEntity();
        rentAreaEntity.setValue(value.toString());
        rentAreaEntity.setBuilding(buildingEntity);
        return rentAreaEntity;
    }

    public List<RentAreaEntity> toRentAreaEntityList(BuildingDTO buildingDTO, BuildingEntity buildingEntity){
        List<RentAreaEntity> rentAreaEntityList = new ArrayList<>();
        String[] rentAreas = buildingDTO.getRentArea().split(",");

        for (String val : rentAreas) {
            val = val.trim();
            if (!val.isEmpty()) {
                RentAreaEntity rentAreaEntity = toRentAreaEntity(buildingEntity, Long.valueOf(val));
                rentAreaEntityList.add(rentAreaEntity);
            }
        }

        return rentAreaEntityList;
    }
}
