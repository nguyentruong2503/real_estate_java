package com.example.realestate.api;

import com.example.realestate.model.dto.AssignmentBuildingDTO;
import com.example.realestate.model.dto.BuildingDTO;
import com.example.realestate.model.response.ResponseDTO;
import com.example.realestate.service.BuildingService;
import com.example.realestate.service.CloudinaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController(value = "buildingAIPOfAdmin")
@RequestMapping("/api/building")
public class BuildingAPI {
    @Autowired
    private BuildingService buildingService;

    @Autowired
    private CloudinaryService cloudinaryService;

    @PostMapping
    public BuildingDTO addOrUpdateBuilding(@RequestBody BuildingDTO buildingDTO){
        buildingService.insertBuildingOrUpdate(buildingDTO);
        return buildingDTO;
    }

    @DeleteMapping("/{id}")
    public void deleteBuilding(@PathVariable Long id){
        buildingService.deleteBuilding(id);
    }

    @PostMapping("/upload-img")
    public List<String> uploadMultiple(@RequestParam("files") MultipartFile[] files) throws IOException {
        List<String> urls = new ArrayList<>();
        for (MultipartFile file : files) {
            String url = cloudinaryService.uploadImage(file);
            urls.add(url);
        }
        return urls;
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id){

        ResponseDTO result = buildingService.listStaffs(id);
        return result;
    }

    @PostMapping("/assignment")
    public ResponseEntity<AssignmentBuildingDTO> updateAssignmentBuilding(@RequestBody AssignmentBuildingDTO assignmentBuildingDTO){
        buildingService.addAssignmentBuilding(assignmentBuildingDTO);
        return ResponseEntity.ok(assignmentBuildingDTO);
    }

}
