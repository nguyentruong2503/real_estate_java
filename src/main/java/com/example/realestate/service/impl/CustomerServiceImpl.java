package com.example.realestate.service.impl;

import com.example.realestate.builder.CustomerSearchBuilder;
import com.example.realestate.converter.CustomerConverter;
import com.example.realestate.converter.CustomerSearchBuilderConverter;
import com.example.realestate.entity.BuildingEntity;
import com.example.realestate.entity.CustomerEntity;
import com.example.realestate.entity.TransactionEntity;
import com.example.realestate.entity.UserEntity;
import com.example.realestate.exception.NotFoundException;
import com.example.realestate.model.dto.AssignmentCustomerDTO;
import com.example.realestate.model.dto.CustomerDTO;
import com.example.realestate.model.dto.TransactionDTO;
import com.example.realestate.model.response.ResponseDTO;
import com.example.realestate.model.response.StaffResponseDTO;
import com.example.realestate.repository.BuildingRepository;
import com.example.realestate.repository.CustomerRepository;
import com.example.realestate.repository.UserRepository;
import com.example.realestate.repository.custome.TransactionRepository;
import com.example.realestate.security.SecurityUtils;
import com.example.realestate.service.CustomerService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.security.Security;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    CustomerRepository customerRepository;

    @Autowired
    BuildingRepository buildingRepository;
    @Autowired
    CustomerSearchBuilderConverter customerSearchBuilderConverter;

    @Autowired
    CustomerConverter customerConverter;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TransactionRepository transactionRepository;

    @Override
    public List<CustomerDTO> findAll(CustomerDTO customerDTO, Pageable pageable) {
        CustomerSearchBuilder customerSearchBuilder = customerSearchBuilderConverter.toCustomerSearchBuilder(customerDTO);
        List<CustomerEntity> customerEntities = customerRepository.findAll(customerSearchBuilder,pageable);
        List<CustomerDTO> list = new ArrayList<>();
        for(CustomerEntity it : customerEntities){
            CustomerDTO customer = customerConverter.toCustomerDTO(it);
            list.add(customer);
        }

        return list;
    }

    @Override
    public int countTotalItems(CustomerDTO customerDTO) {
        CustomerSearchBuilder customerSearchBuilder = customerSearchBuilderConverter.toCustomerSearchBuilder(customerDTO);
        return customerRepository.countTotalItems(customerSearchBuilder);
    }

    @Override
    public CustomerDTO insertOrUpdateCustomer(CustomerDTO customerDTO) {
        Long customerID = customerDTO.getId();
        CustomerEntity customerEntity;

        if(customerID != null){
            CustomerEntity foundCustomer = customerRepository.findById(customerID)
                    .orElseThrow(() -> new NotFoundException("Customer not found!"));

            String createdBy = foundCustomer.getCreatedBy();
            Date createdDate = foundCustomer.getCreatedDate();

            modelMapper.map(customerDTO, foundCustomer);
            foundCustomer.setCreatedBy(createdBy);
            foundCustomer.setCreatedDate(createdDate);
            foundCustomer.setModifiedDate(new Date());
            foundCustomer.setModifiedBy(SecurityUtils.getPrincipal().getFullName());

            customerEntity = foundCustomer;

        }else {
            customerEntity= modelMapper.map(customerDTO,CustomerEntity.class);
            customerEntity.setCreatedDate(new Date());
            customerEntity.setActive(true);
        }
        customerRepository.save(customerEntity);
        customerDTO.setId(customerEntity.getId());
        return customerDTO;
    }

    @Override
    public void deleteCustomer(List<Long> ids) {
        for(Long id : ids) {
            CustomerEntity customerEntity = customerRepository.findById(id).get();
            customerEntity.setActive(false);
            customerRepository.save(customerEntity);
        }
    }

    @Override
    public CustomerDTO findById(Long id) {
        CustomerEntity customerEntity = customerRepository.findById(id).get();
        CustomerDTO customerDTO = customerConverter.toCustomerDTO(customerEntity);

        return customerDTO;
    }

    @Override
    public ResponseDTO listStaffs(Long customerId) {
        CustomerEntity customerEntity = customerRepository.findById(customerId).get();
        List<UserEntity> staffList = userRepository.findByActiveAndRoles_Code(1,"STAFF");

        List<UserEntity> assignedStaffList = customerEntity.getUserEntities();
        List<StaffResponseDTO> staffResponseDTOList = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();

        for(UserEntity uE : staffList){
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setStaffId(uE.getId());
            staffResponseDTO.setFullName(uE.getFullName());
            if (assignedStaffList.contains(uE)){
                staffResponseDTO.setChecked("checked");
            }
            else {
                staffResponseDTO.setChecked("");
            }
            staffResponseDTOList.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOList);
        responseDTO.setMessage("success");
        return responseDTO;
    }

    @Override
    public AssignmentCustomerDTO addAssignmentCustomer(AssignmentCustomerDTO assignmentCustomerDTO) {
        CustomerEntity customerEntity = customerRepository.findById(assignmentCustomerDTO.getCustomerId()).get();
        List<UserEntity> staffs = userRepository.findByIdIn(assignmentCustomerDTO.getStaffs());
        customerEntity.setUserEntities(staffs);
        customerRepository.save(customerEntity);
        return assignmentCustomerDTO;
    }

    @Override
    public List<TransactionDTO> findTransactionsByTransactionTypeAndCustomerId(String transactionType, Long customerId) {
        CustomerEntity customerEntity = customerRepository.findById(customerId).get();
        List<TransactionEntity> transactionEntities = transactionRepository.findByTransactionTypeAndCustomerId(transactionType,customerEntity);
        List<TransactionDTO> transactionDTOlist = new ArrayList<>();

        for(TransactionEntity it : transactionEntities){
            TransactionDTO transactionDTO = customerConverter.toTransactionDTO(it);
            transactionDTOlist.add(transactionDTO);
        }
        return transactionDTOlist;
    }

    @Override
    public TransactionDTO insertOrUpdateTransaction(TransactionDTO transactionDTO) {
        Long transactionId = transactionDTO.getId();
        TransactionEntity transactionEntity = new TransactionEntity();
        if(transactionId != null){
            TransactionEntity existTransaction = transactionRepository.findById(transactionId)
                    .orElseThrow(() -> new NotFoundException("Transaction not found"));

            String createdBy = existTransaction.getCreatedBy();
            Date createdDate = existTransaction.getCreatedDate();

            CustomerEntity customer = customerRepository.findById(transactionDTO.getCustomerId())
                    .orElseThrow(() -> new NotFoundException("Customer not found!"));
            existTransaction.setCustomerId(customer);
            existTransaction.setTransactionType(transactionDTO.getTransactionType());
            existTransaction.setNote(transactionDTO.getTransactionDetail());
            existTransaction.setAmount(transactionDTO.getAmount());
            if(transactionDTO.getBuildingId() != null){
                BuildingEntity building = buildingRepository.findById(transactionDTO.getBuildingId())
                        .orElseThrow(() -> new NotFoundException("Building not found!"));;
                existTransaction.setBuilding(building);

                updateBuildingStatus(building, transactionDTO.getTransactionType());
            }
            existTransaction.setCreatedBy(createdBy);
            existTransaction.setCreatedDate(createdDate);
            existTransaction.setModifiedDate(new Date());
            existTransaction.setModifiedBy(SecurityUtils.getPrincipal().getFullName());
            existTransaction.setStartDate(transactionDTO.getStartDate());
            existTransaction.setEndDate(transactionDTO.getEndDate());

            transactionEntity = existTransaction;
        }
        else{
            CustomerEntity customer = customerRepository.findById(transactionDTO.getCustomerId())
                    .orElseThrow(() -> new NotFoundException("Customer not found!"));
            transactionEntity.setCustomerId(customer);
            transactionEntity.setTransactionType(transactionDTO.getTransactionType());
            transactionEntity.setNote(transactionDTO.getTransactionDetail());
            transactionEntity.setAmount(transactionDTO.getAmount());
            if(transactionDTO.getBuildingId() != null){
                BuildingEntity building = buildingRepository.findById(transactionDTO.getBuildingId())
                        .orElseThrow(() -> new NotFoundException("Building not found!"));;
                transactionEntity.setBuilding(building);
                updateBuildingStatus(building, transactionDTO.getTransactionType());
            }
            transactionEntity.setCreatedDate(new Date());
            transactionEntity.setCreatedBy(SecurityUtils.getPrincipal().getFullName());
            transactionEntity.setStartDate(transactionDTO.getStartDate());
            transactionEntity.setEndDate(transactionDTO.getEndDate());

        }
        transactionRepository.save(transactionEntity);
        transactionDTO.setId(transactionEntity.getId());
        return transactionDTO;
    }

    private void updateBuildingStatus(BuildingEntity building, String transactionType) {
        if ("DEPOSIT".equalsIgnoreCase(transactionType)) {
            building.setStatus("DEPOSITED");
        } else if ("RENTED".equalsIgnoreCase(transactionType)) {
            building.setStatus("RENTED");
        } else {
            building.setStatus("AVAILABLE");
        }
        buildingRepository.save(building);
    }
}
