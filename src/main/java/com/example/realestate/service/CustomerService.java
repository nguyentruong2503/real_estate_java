package com.example.realestate.service;

import com.example.realestate.model.dto.AssignmentCustomerDTO;
import com.example.realestate.model.dto.CustomerDTO;
import com.example.realestate.model.dto.TransactionDTO;
import com.example.realestate.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CustomerService {
    List<CustomerDTO> findAll(CustomerDTO customerDTO, Pageable pageable);

    int countTotalItems(CustomerDTO customerDTO);

    CustomerDTO insertOrUpdateCustomer(CustomerDTO customerDTO);

    CustomerDTO insertCustomerFromContact(CustomerDTO customerDTO);

    void deleteCustomer(List<Long> ids);

    CustomerDTO findById(Long id);

    ResponseDTO listStaffs(Long customerId);

    public AssignmentCustomerDTO addAssignmentCustomer(AssignmentCustomerDTO assignmentCustomerDTO);

    List<TransactionDTO> findTransactionsByTransactionTypeAndCustomerId(String transactionType, Long customerId);

    TransactionDTO insertOrUpdateTransaction(TransactionDTO transactionDTO);
}
