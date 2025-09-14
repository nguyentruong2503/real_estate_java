package com.example.realestate.converter;

import com.example.realestate.entity.CustomerEntity;
import com.example.realestate.entity.TransactionEntity;
import com.example.realestate.model.dto.CustomerDTO;
import com.example.realestate.model.dto.TransactionDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CustomerConverter {
    @Autowired
    private ModelMapper mapper;

    public CustomerDTO toCustomerDTO (CustomerEntity customerEntity){
        CustomerDTO customerDTO = mapper.map(customerEntity, CustomerDTO.class);
        return customerDTO;
    }

    public TransactionDTO toTransactionDTO (TransactionEntity transactionEntity){
        TransactionDTO dto = new TransactionDTO();
        dto.setId(transactionEntity.getId());
        dto.setTransactionType(transactionEntity.getTransactionType());
        dto.setTransactionDetail(transactionEntity.getNote());

        if (transactionEntity.getCustomerId() != null) {
            dto.setCustomerId(transactionEntity.getCustomerId().getId());
        }

        dto.setCreatedDate(transactionEntity.getCreatedDate());
        dto.setCreatedBy(transactionEntity.getCreatedBy());
        dto.setModifiedDate(transactionEntity.getModifiedDate());
        dto.setModifiedBy(transactionEntity.getModifiedBy());
        if(transactionEntity.getBuilding() != null){
            dto.setBuildingId(transactionEntity.getBuilding().getId());
            dto.setNameOfBuilding(transactionEntity.getBuilding().getName());
        }
        dto.setStartDate(transactionEntity.getStartDate());
        dto.setEndDate(transactionEntity.getEndDate());
        dto.setAmount(transactionEntity.getAmount());

        return dto;
    }
}
