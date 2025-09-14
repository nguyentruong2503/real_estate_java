package com.example.realestate.converter;

import com.example.realestate.builder.CustomerSearchBuilder;
import com.example.realestate.model.dto.CustomerDTO;
import com.example.realestate.utils.MapUtils;
import org.springframework.stereotype.Component;

@Component
public class CustomerSearchBuilderConverter {
    public CustomerSearchBuilder toCustomerSearchBuilder(CustomerDTO customerDTO){
        CustomerSearchBuilder customerSearchBuilder = new CustomerSearchBuilder.Builder()
                .setFullName(MapUtils.getObject(customerDTO.getFullName(),String.class))
                .setPhone(MapUtils.getObject(customerDTO.getPhone(), String.class))
                .setEmail(MapUtils.getObject(customerDTO.getEmail(), String.class))
                .setStaffId(MapUtils.getObject(customerDTO.getStaffId(), Long.class))
                .build();
        return customerSearchBuilder;
    }
}
