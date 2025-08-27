package com.example.realestate.repository;

import com.example.realestate.entity.UserEntity;
import com.example.realestate.repository.custome.UserRepositoryCustom;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> , UserRepositoryCustom {

    Page<UserEntity> findByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndActive(String userName,String fullName,int active, Pageable pageable);

    int countByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndActive(
            String userName, String fullName, int active);

    int countByActive(int active);

    Page<UserEntity> findByActive(int active, Pageable pageable);

    List<UserEntity> findByActiveAndRoles_Code(Integer active, String roleCode);
    List<UserEntity> findByIdIn(List<Long> id);

    UserEntity findOneByUserNameAndActive(String name, int active);

    UserEntity findOneByUserName(String userName);

}
