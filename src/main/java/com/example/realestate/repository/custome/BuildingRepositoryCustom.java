package com.example.realestate.repository.custome;

import com.example.realestate.builder.BuildingSearchBuilder;
import com.example.realestate.entity.BuildingEntity;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface BuildingRepositoryCustom {
    List<BuildingEntity> findAll(BuildingSearchBuilder builder, Pageable pageable);

    List<BuildingEntity> findAvailableBuildings(Long customerId);

    int countTotalItems(BuildingSearchBuilder builder);
}
