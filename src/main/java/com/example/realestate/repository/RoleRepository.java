package com.example.realestate.repository;

import com.example.realestate.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<RoleEntity,Long> {
    RoleEntity findOneByCode(String code);
}
