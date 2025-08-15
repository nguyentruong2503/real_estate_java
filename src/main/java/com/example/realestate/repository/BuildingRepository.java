package com.example.realestate.repository;

import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.repository.custome.BuildingRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BuildingRepository extends JpaRepository<BuildingEntity,Long>, BuildingRepositoryCustom {
}
