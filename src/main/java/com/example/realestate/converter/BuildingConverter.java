package com.example.realestate.converter;

import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.entity.BuildingImageEntity;
import com.example.realestate.entity.RentAreaEntity;
import com.example.realestate.model.dto.BuildingDTO;
import com.example.realestate.repository.RentAreaRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class BuildingConverter {
    @Autowired
    private ModelMapper mapper;

    @Autowired
    private RentAreaRepository rentAreaRepository;

    public BuildingDTO toBuildingDTO (BuildingEntity buildingEntity){
        BuildingDTO buildingDTO = mapper.map(buildingEntity,BuildingDTO.class);

        if (buildingEntity.getType() !=null){
            List<String > typeList = Arrays.asList(buildingEntity.getType().split(","));
            buildingDTO.setTypeCode(typeList);
        }

        List<RentAreaEntity> rentAreaEntities = rentAreaRepository.findByBuilding_Id(buildingEntity.getId());
        String areaResult = rentAreaEntities.stream().map(i -> i.getValue().toString()).collect(Collectors.joining(","));
        buildingDTO.setRentArea(areaResult);

        if (buildingEntity.getImages() != null) {
            List<String> imageUrls = buildingEntity.getImages()
                    .stream()
                    .map(BuildingImageEntity::getImageUrl)
                    .collect(Collectors.toList());
            buildingDTO.setImageUrls(imageUrls);
        }
        return buildingDTO;
    }
}
