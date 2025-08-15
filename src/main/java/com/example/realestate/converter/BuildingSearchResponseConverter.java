package com.example.realestate.converter;

import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.entity.BuildingImageEntity;
import com.example.realestate.entity.RentAreaEntity;
import com.example.realestate.enums.districtCode;
import com.example.realestate.model.response.BuildingSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
@Component
public class BuildingSearchResponseConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BuildingSearchResponse toBuildingSearchResponse(BuildingEntity buildingEntity){
        BuildingSearchResponse buildingSearchResponse = modelMapper.map(buildingEntity, BuildingSearchResponse.class);
        List<RentAreaEntity> rentAreas = buildingEntity.getRentAreaEntities();
        String areaResult = rentAreas.stream().map(i -> i.getValue().toString()).collect(Collectors.joining(","));
        buildingSearchResponse.setRentArea(areaResult);

        Map<String , String> districts = districtCode.type();

        String districtName = "";
        if(buildingEntity.getDistrict() != null && buildingEntity.getDistrict() != ""){
            districtName = districts.get(buildingEntity.getDistrict());
        }

        if(districtName != null && districtName != ""){
            buildingSearchResponse.setAddress(buildingEntity.getHouse_number() + ", " + buildingEntity.getStreet() + ", " + buildingEntity.getWard() + ", " + districtName + ", " + buildingEntity.getCity());
        }

        if (buildingEntity.getImages() != null) {
            List<String> imageUrls = buildingEntity.getImages()
                    .stream()
                    .map(BuildingImageEntity::getImageUrl)
                    .collect(Collectors.toList());
            buildingSearchResponse.setImageUrls(imageUrls);
        }
        if (buildingEntity.getType() !=null){
            List<String > typeList = Arrays.asList(buildingEntity.getType().split(","));
            buildingSearchResponse.setTypeCode(typeList);
        }

        return buildingSearchResponse;
    }
}
