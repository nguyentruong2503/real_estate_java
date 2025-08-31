package com.example.realestate.controller;

import com.example.realestate.enums.transactionType;
import com.example.realestate.model.dto.BuildingDTO;
import com.example.realestate.model.dto.CustomerDTO;
import com.example.realestate.model.dto.TransactionDTO;
import com.example.realestate.security.SecurityUtils;
import com.example.realestate.service.BuildingService;
import com.example.realestate.service.CustomerService;
import com.example.realestate.service.UserService;
import com.example.realestate.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BuildingService buildingService;

    @Autowired
    private UserService userService;

    @GetMapping("/admin/customer-list")
    public ModelAndView showCustomerList(@ModelAttribute CustomerDTO customerDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/customer/list.jsp");
        mav.addObject("activeMenu", "customer");

        DisplayTagUtils.of(request, customerDTO);

        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            Long staffID = SecurityUtils.getPrincipal().getId();
            customerDTO.setStaffId(staffID);
        }

        List<CustomerDTO> responseList = customerService.findAll(customerDTO,
                PageRequest.of(customerDTO.getPage() - 1, customerDTO.getMaxPageItems()));

        customerDTO.setListResult(responseList);
        customerDTO.setTotalItems(customerService.countTotalItems(customerDTO));

        mav.addObject("customerDTO", customerDTO);
        mav.addObject("listStaffs", userService.getStaffs());
        return mav;
    }

    @GetMapping(value = "/admin/customer-edit")
    public ModelAndView addCustomer(@ModelAttribute("customerEdit") CustomerDTO customerDTO) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/customer/edit.jsp");
        mav.addObject("activeMenu", "customer");

        mav.addObject("customerEdit", customerDTO);
        return mav;
    }

    @GetMapping(value = "/admin/customer-edit-{id}")
    public ModelAndView updateCustomer(@PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/customer/edit.jsp");
        mav.addObject("activeMenu", "customer");

        CustomerDTO customerDTO = customerService.findById(id);

        mav.addObject("customerEdit", customerDTO);
        mav.addObject("transactionType", transactionType.transactionType());

        List<BuildingDTO> depositedBuildings = buildingService.findDepositedBuildings(id);
        mav.addObject("depositedBuildings",depositedBuildings);

        List<BuildingDTO> availableBuildings = buildingService.findAvailableBuildings();
        mav.addObject("availableBuildings",availableBuildings);

        List<TransactionDTO> listCall = customerService.findTransactionsByTransactionTypeAndCustomerId("CALL", id);
        List<TransactionDTO> listViewing = customerService.findTransactionsByTransactionTypeAndCustomerId("VIEWING", id);
        List<TransactionDTO> listDeposit = customerService.findTransactionsByTransactionTypeAndCustomerId("DEPOSIT", id);
        List<TransactionDTO> listRent = customerService.findTransactionsByTransactionTypeAndCustomerId("RENTED", id);

        mav.addObject("listCall", listCall);
        mav.addObject("listViewing", listViewing);
        mav.addObject("listDeposit", listDeposit);
        mav.addObject("listRent", listRent);

        return mav;
    }
}
