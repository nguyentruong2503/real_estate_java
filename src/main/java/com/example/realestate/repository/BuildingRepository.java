package com.example.realestate.repository;

import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.repository.custome.BuildingRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BuildingRepository extends JpaRepository<BuildingEntity,Long>, BuildingRepositoryCustom {
    List<BuildingEntity> findByStatus(String status);
}
