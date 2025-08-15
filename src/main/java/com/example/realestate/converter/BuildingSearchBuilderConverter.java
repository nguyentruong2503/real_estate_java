package com.example.realestate.converter;

import com.example.realestate.builder.BuildingSearchBuilder;
import com.example.realestate.model.request.BuildingSearchRequest;
import com.example.realestate.utils.MapUtils;
import org.springframework.stereotype.Component;


import java.util.List;
import java.util.Map;
@Component
public class BuildingSearchBuilderConverter {
    public BuildingSearchBuilder toBuildingSearchBuilder (BuildingSearchRequest buildingSearchRequest, List<String> typeCode){
        BuildingSearchBuilder buildingSearchBuilder = new BuildingSearchBuilder.Builder()
                .setName(MapUtils.getObject(buildingSearchRequest.getName(),String.class))
                .setCity(MapUtils.getObject(buildingSearchRequest.getCity(),String.class))
                .setFloorArea(MapUtils.getObject(buildingSearchRequest.getFloorArea(), Long.class))
                .setWard(MapUtils.getObject(buildingSearchRequest.getWard(), String.class))
                .setStreet(MapUtils.getObject(buildingSearchRequest.getStreet(), String.class))
                .setDistrict(MapUtils.getObject(buildingSearchRequest.getDistrict(), String.class))
                .setDirection(MapUtils.getObject(buildingSearchRequest.getDirection(), String.class))
                .setLevel(MapUtils.getObject(buildingSearchRequest.getLevel(), String .class))
                .setNumberOfBasement(MapUtils.getObject(buildingSearchRequest.getNumberOfBasement(), Long.class))
                .setTypeCode(typeCode)
                .setManagerName(MapUtils.getObject(buildingSearchRequest.getManagerName(), String.class))
                .setManagerPhone(MapUtils.getObject(buildingSearchRequest.getManagerPhone(), String.class))
                .setRentPriceTo(MapUtils.getObject(buildingSearchRequest.getRentPriceTo(), Long.class))
                .setRentPriceFrom(MapUtils.getObject(buildingSearchRequest.getRentPriceFrom(), Long.class))
                .setAreaFrom(MapUtils.getObject(buildingSearchRequest.getAreaFrom(), Long.class))
                .setAreaTo(MapUtils.getObject(buildingSearchRequest.getAreaTo(), Long.class))
                .setStaffId(MapUtils.getObject(buildingSearchRequest.getStaffId(), Long.class))
                .build();
        return buildingSearchBuilder;
    }
}
