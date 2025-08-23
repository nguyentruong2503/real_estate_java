package com.example.realestate.api;

import com.example.realestate.model.dto.AssignmentCustomerDTO;
import com.example.realestate.model.dto.CustomerDTO;
import com.example.realestate.model.dto.TransactionDTO;
import com.example.realestate.model.response.ResponseDTO;
import com.example.realestate.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/customer")
public class CustomerAPI {

    @Autowired
    private CustomerService customerService;

    @PostMapping
    public CustomerDTO addOrUpdateCustomer(@RequestBody CustomerDTO customerDTO){
        customerService.insertOrUpdateCustomer(customerDTO);
        return customerDTO;
    }

    @DeleteMapping("/{ids}")
    public void deleteCustomer(@PathVariable List<Long> ids) {
        customerService.deleteCustomer(ids);
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id){

        ResponseDTO result = customerService.listStaffs(id);
        return result;
    }

    @PostMapping("/assignment")
    public ResponseEntity<AssignmentCustomerDTO> insertOrUpdateAssignCustomer(@RequestBody AssignmentCustomerDTO assignmentCustomerDTO){
        customerService.addAssignmentCustomer(assignmentCustomerDTO);
        return ResponseEntity.ok(assignmentCustomerDTO);
    }

    @PostMapping("/transaction")
    public void addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO) {
        customerService.insertOrUpdateTransaction(transactionDTO);
        System.out.println("ok");
    }
}
