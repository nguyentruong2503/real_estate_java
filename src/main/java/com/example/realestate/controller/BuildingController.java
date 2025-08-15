package com.example.realestate.controller;

import com.example.realestate.enums.buildingType;
import com.example.realestate.enums.districtCode;
import com.example.realestate.model.dto.BuildingDTO;
import com.example.realestate.model.request.BuildingSearchRequest;
import com.example.realestate.model.response.BuildingSearchResponse;
import com.example.realestate.service.BuildingService;
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
public class BuildingController {

    @Autowired
    private BuildingService buildingService;

    @Autowired
    private UserService userService;

    @GetMapping("/admin/building-list")
    public ModelAndView showBuildingList(@ModelAttribute BuildingSearchRequest buildingSearchRequest, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/building/list.jsp");

        DisplayTagUtils.of(request, buildingSearchRequest);

        List<BuildingSearchResponse> responseList = buildingService.findAll(buildingSearchRequest,
                PageRequest.of(buildingSearchRequest.getPage() - 1, buildingSearchRequest.getMaxPageItems()));

        buildingSearchRequest.setListResult(responseList);
        buildingSearchRequest.setTotalItems(buildingService.countTotalItems(buildingSearchRequest));

        mav.addObject("model", buildingSearchRequest);
        mav.addObject("listStaffs", userService.getStaffs());
        mav.addObject("buildingTypes", buildingType.type());
        mav.addObject("districts", districtCode.type());
        return mav;
    }

    @GetMapping(value = "/admin/building-edit")
    public ModelAndView addNewBuilding(@ModelAttribute BuildingDTO buildingDTO, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/building/edit.jsp");
        mav.addObject("buildingEdit", buildingDTO);

        mav.addObject("districts", districtCode.type());

        mav.addObject("buildingTypes", buildingType.type());
        return mav;
    }

    @GetMapping(value = "/admin/building-edit-{id}")
    public ModelAndView buildingEdit(@PathVariable("id") Long Id , HttpServletRequest request){
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/building/edit.jsp");

        BuildingDTO buildingDTO = buildingService.findById(Id);

        mav.addObject("buildingEdit", buildingDTO);

        mav.addObject("districts", districtCode.type());

        mav.addObject("buildingTypes", buildingType.type());

        return mav;
    }

    @GetMapping(value = "/admin/building-view-{id}")
    public ModelAndView buildingViewDetail(@PathVariable("id") Long Id , HttpServletRequest request){
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/building/detail.jsp");

        BuildingSearchResponse buildingSearchResponse = buildingService.findDetailById(Id);

        mav.addObject("buildingDetail", buildingSearchResponse);

        mav.addObject("districts", districtCode.type());

        mav.addObject("buildingTypes", buildingType.type());

        return mav;
    }

}
