package com.example.realestate.controller;

import com.example.realestate.enums.buildingType;
import com.example.realestate.enums.districtCode;
import com.example.realestate.model.request.BuildingSearchRequest;
import com.example.realestate.model.response.BuildingSearchResponse;
import com.example.realestate.security.SecurityUtils;
import com.example.realestate.service.BuildingService;
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
public class HomeController {

    @Autowired
    private BuildingService buildingService;

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

    @GetMapping("/homepage/bat-dong-san")
    public ModelAndView property(@ModelAttribute BuildingSearchRequest buildingSearchRequest,
                                 HttpServletRequest request) {
        DisplayTagUtils.of(request, buildingSearchRequest);


        List<BuildingSearchResponse> responseList = buildingService.findAll(
                buildingSearchRequest,
                PageRequest.of(buildingSearchRequest.getPage() - 1, buildingSearchRequest.getMaxPageItems())
        );

        buildingSearchRequest.setListResult(responseList);
        buildingSearchRequest.setTotalItems(buildingService.countTotalItems(buildingSearchRequest));

        ModelAndView mav = new ModelAndView("homepage/bat-dong-san");
        mav.addObject("model", buildingSearchRequest);
        mav.addObject("buildingTypes", buildingType.type());
        mav.addObject("districts", districtCode.type());

        return mav;
    }

    @GetMapping(value = "/homepage/building-view-{id}")
    public ModelAndView buildingViewDetail(@PathVariable("id") Long Id , HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/building/detail");

        BuildingSearchResponse buildingSearchResponse = buildingService.findDetailById(Id);

        mav.addObject("buildingDetail", buildingSearchResponse);

        mav.addObject("districts", districtCode.type());

        mav.addObject("buildingTypes", buildingType.type());

        return mav ;
    }

}
