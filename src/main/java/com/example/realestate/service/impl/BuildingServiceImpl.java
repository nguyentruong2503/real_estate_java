package com.example.realestate.service.impl;

import com.example.realestate.builder.BuildingSearchBuilder;
import com.example.realestate.converter.BuildingConverter;
import com.example.realestate.converter.BuildingSearchBuilderConverter;
import com.example.realestate.converter.BuildingSearchResponseConverter;
import com.example.realestate.converter.RentAreaConverter;
import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.entity.BuildingImageEntity;
import com.example.realestate.entity.RentAreaEntity;
import com.example.realestate.entity.UserEntity;
import com.example.realestate.exception.NotFoundException;
import com.example.realestate.model.dto.AssignmentBuildingDTO;
import com.example.realestate.model.dto.BuildingDTO;
import com.example.realestate.model.request.BuildingSearchRequest;
import com.example.realestate.model.response.BuildingSearchResponse;
import com.example.realestate.model.response.ResponseDTO;
import com.example.realestate.model.response.StaffResponseDTO;
import com.example.realestate.repository.BuildingRepository;
import com.example.realestate.repository.UserRepository;
import com.example.realestate.service.BuildingService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;



@Service
public class BuildingServiceImpl implements BuildingService {

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private BuildingSearchBuilderConverter buildingSearchBuilderConverter;

    @Autowired
    private BuildingSearchResponseConverter buildingSearchResponseConverter;

    @Autowired
    private BuildingConverter buildingConverter;

    @Autowired
    private RentAreaConverter rentAreaConverter;

    @Autowired
    private UserRepository userRepository;


    @Override
    public List<BuildingDTO> getAllBuildings() {
        List<BuildingEntity> entities = buildingRepository.findAll();
        return entities.stream()
                .map(entity -> modelMapper.map(entity, BuildingDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public BuildingDTO findById(Long id) {
        BuildingEntity buildingEntity = buildingRepository.findById(id).get();

        BuildingDTO buildingDTO = buildingConverter.toBuildingDTO(buildingEntity);
        return buildingDTO;
    }

    @Override
    public BuildingSearchResponse findDetailById(Long id) {
        BuildingEntity buildingEntity = buildingRepository.findById(id).get();

        BuildingSearchResponse buildingSearchResponse = buildingSearchResponseConverter.toBuildingSearchResponse(buildingEntity);
        return buildingSearchResponse;
    }

    @Override
    public List<BuildingSearchResponse> findAll(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        List<String> typeCode = buildingSearchRequest.getTypeCode();
        BuildingSearchBuilder buildingSearchBuilder = buildingSearchBuilderConverter.toBuildingSearchBuilder(buildingSearchRequest,typeCode);

        List<BuildingEntity> buildingEntities = buildingRepository.findAll(buildingSearchBuilder,pageable);
        List<BuildingSearchResponse> buildingSearchResponses = new ArrayList<>();
        for(BuildingEntity item : buildingEntities) {
            BuildingSearchResponse building = buildingSearchResponseConverter.toBuildingSearchResponse(item);
            buildingSearchResponses.add(building);
        }
        return buildingSearchResponses;
    }

    @Override
    public int countTotalItems(BuildingSearchRequest request) {
        BuildingSearchBuilder builder = buildingSearchBuilderConverter
                .toBuildingSearchBuilder(request, request.getTypeCode());
        return buildingRepository.countTotalItems(builder);
    }

    @Override
    public ResponseDTO listStaffs(Long buildingId) {
        BuildingEntity building = buildingRepository.findById(buildingId).get();
        List<UserEntity> staffs = userRepository.findByActiveAndRoles_Code(1,"STAFF");
        List<UserEntity> staffAssignment = building.getUserEntities();
        List<StaffResponseDTO> staffResponseDTOS = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();
        for(UserEntity it : staffs){
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setStaffId(it.getId());
            staffResponseDTO.setFullName(it.getFullName());
            if(staffAssignment.contains(it)){
                staffResponseDTO.setChecked("checked");
            }
            else{
                staffResponseDTO.setChecked("");
            }
            staffResponseDTOS.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOS);
        responseDTO.setMessage("success");
        return responseDTO;
    }

    @Override
    public BuildingDTO insertBuildingOrUpdate(BuildingDTO buildingDTO) {
        Long buildingId = buildingDTO.getId();
        BuildingEntity buildingEntity;

        if (buildingId != null) {
            BuildingEntity foundBuilding = buildingRepository.findById(buildingId)
                    .orElseThrow(() -> new NotFoundException("Building not found!"));
            modelMapper.map(buildingDTO, foundBuilding);

            foundBuilding.getRentAreaEntities().clear();
            List<RentAreaEntity> newRentAreas = rentAreaConverter.toRentAreaEntityList(buildingDTO, foundBuilding);
            foundBuilding.getRentAreaEntities().addAll(newRentAreas);

            if (buildingDTO.getImageUrls() != null) {
                List<BuildingImageEntity> imageEntities = buildingDTO.getImageUrls().stream()
                        .map(url -> {
                            BuildingImageEntity img = new BuildingImageEntity();
                            img.setImageUrl(url);
                            img.setBuilding(foundBuilding);
                            return img;
                        }).collect(Collectors.toList());

                foundBuilding.getImages().clear();
                foundBuilding.getImages().addAll(imageEntities);
            }

            buildingEntity = foundBuilding;
        } else {
            buildingEntity = modelMapper.map(buildingDTO, BuildingEntity.class);
            buildingEntity.setRentAreaEntities(
                    rentAreaConverter.toRentAreaEntityList(buildingDTO, buildingEntity)
            );
            if (buildingDTO.getImageUrls() != null && !buildingDTO.getImageUrls().isEmpty()) {
                List<BuildingImageEntity> imageEntities = buildingDTO.getImageUrls().stream()
                        .map(url -> {
                            BuildingImageEntity img = new BuildingImageEntity();
                            img.setImageUrl(url);
                            img.setBuilding(buildingEntity);
                            return img;
                        }).collect(Collectors.toList());

                buildingEntity.setImages(imageEntities);
            }
        }

        buildingEntity.setType(String.join(",", buildingDTO.getTypeCode()));

        buildingRepository.save(buildingEntity); // cascade sẽ tự lưu rentAreaEntities

        buildingDTO.setId(buildingEntity.getId());
        return buildingDTO;
    }

    @Override
    public void deleteBuilding(Long id) {
        buildingRepository.deleteById(id);
    }

    @Override
    public AssignmentBuildingDTO addAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO) {
        BuildingEntity buildingEntity = buildingRepository.findById(assignmentBuildingDTO.getBuildingId()).get();
        List<UserEntity> staffs = userRepository.findByIdIn(assignmentBuildingDTO.getStaffs());
        buildingEntity.setUserEntities(staffs);
        buildingRepository.save(buildingEntity);
        return assignmentBuildingDTO;
    }

    @Override
    public List<BuildingDTO> findDepositedBuildings(Long customerId) {
        List<BuildingEntity> buildingEntityList = buildingRepository.findAvailableBuildings(customerId);
        List<BuildingDTO> buildingDTOList = new ArrayList<>();;

        for(BuildingEntity it : buildingEntityList){
            BuildingDTO buildingDTO = buildingConverter.toBuildingDTO(it);
            buildingDTOList.add(buildingDTO);
        }
        return buildingDTOList;
    }

    @Override
    public List<BuildingDTO> findAvailableBuildings() {
        List<BuildingEntity> buildingEntityList = buildingRepository.findByStatus("AVAILABLE");
        List<BuildingDTO> buildingDTOList = new ArrayList<>();;

        for(BuildingEntity it : buildingEntityList){
            BuildingDTO buildingDTO = buildingConverter.toBuildingDTO(it);
            buildingDTOList.add(buildingDTO);
        }
        return buildingDTOList;
    }
}
