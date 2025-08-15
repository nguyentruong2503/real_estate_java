package com.example.realestate.repository;

import com.example.realestate.entity.RentAreaEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RentAreaRepository extends JpaRepository<RentAreaEntity,Long> {
    List<RentAreaEntity> findByBuilding_Id(Long buildingId);
}
