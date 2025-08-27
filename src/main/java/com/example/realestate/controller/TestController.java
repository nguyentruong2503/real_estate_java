package com.example.realestate.controller;

import com.example.realestate.model.dto.MyUserDetail;
import com.example.realestate.security.SecurityUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/test")
public class TestController {

    @GetMapping("/me")
    public String getCurrentUser() {
        return SecurityUtils.getPrincipal().getFullName();
    }

    @GetMapping("/role")
    @ResponseBody
    public String testRole() {
        MyUserDetail user = SecurityUtils.getPrincipal();
        return "FullName: " + user.getFullName() +
                ", Roles: " + user.getAuthorities().stream()
                .map(a -> a.getAuthority())
                .reduce((a,b) -> a + ", " + b)
                .orElse("No Role");
    }
}
