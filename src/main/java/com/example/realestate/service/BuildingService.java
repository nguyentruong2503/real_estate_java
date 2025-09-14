package com.example.realestate.service;

import com.example.realestate.model.dto.AssignmentBuildingDTO;
import com.example.realestate.model.dto.BuildingDTO;
import com.example.realestate.model.request.BuildingSearchRequest;
import com.example.realestate.model.response.BuildingSearchResponse;
import com.example.realestate.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface BuildingService {

    List<BuildingDTO> getAllBuildings();

    BuildingDTO findById(Long id);

    BuildingSearchResponse findDetailById(Long id);

    List<BuildingSearchResponse> findAll(BuildingSearchRequest request, Pageable pageable);
    int countTotalItems(BuildingSearchRequest request);

    ResponseDTO listStaffs(Long buildingId);

    BuildingDTO insertBuildingOrUpdate(BuildingDTO buildingDTO);
    void deleteBuilding(Long id);
    public AssignmentBuildingDTO addAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO);

    List<BuildingDTO> findDepositedBuildings(Long customerId);

    List<BuildingDTO> findAvailableBuildings();

}
