package com.example.realestate.repository;

import com.example.realestate.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> {

    List<UserEntity> findByActiveAndRoles_Code(Integer active, String roleCode);
    List<UserEntity> findByIdIn(List<Long> id);
}
