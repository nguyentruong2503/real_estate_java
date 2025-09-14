package com.example.realestate.repository;

import com.example.realestate.entity.CustomerEntity;
import com.example.realestate.repository.custome.CustomerRepositoryCustome;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<CustomerEntity,Long>, CustomerRepositoryCustome {
}
