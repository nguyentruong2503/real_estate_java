package com.example.realestate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String loginPage() {
        return "login"; // login.jsp trong WEB-INF/views
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied"; // access-denied.jsp
    }
}
