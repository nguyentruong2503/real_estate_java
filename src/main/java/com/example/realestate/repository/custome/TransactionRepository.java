package com.example.realestate.repository.custome;

import com.example.realestate.entity.CustomerEntity;
import com.example.realestate.entity.TransactionEntity;
import com.example.realestate.model.dto.TransactionDTO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionRepository extends JpaRepository<TransactionEntity, Long> {
    List<TransactionEntity> findByTransactionTypeAndCustomerId(String transactionType, CustomerEntity customer);
}
