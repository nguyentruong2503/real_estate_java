package com.example.realestate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/home")
    public String home() {
        return "layout";
    }

    @GetMapping("/homepage/trang-chu")
    public String homePage() {
        return "homepage/trang-chu";
    }

    @GetMapping("/homepage/gioi-thieu")
    public String introduce() {
        return "homepage/gioi-thieu";
    }

    @GetMapping("/homepage/lien-he")
    public String contact() {
        return "homepage/lien-he";
    }
}
