package com.example.realestate.repository.custome;

import com.example.realestate.builder.CustomerSearchBuilder;
import com.example.realestate.entity.CustomerEntity;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CustomerRepositoryCustome {
    List<CustomerEntity> findAll(CustomerSearchBuilder customerSearchBuilder, Pageable pageable);

    int countTotalItems(CustomerSearchBuilder builder);
}
