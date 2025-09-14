package com.example.realestate.controller;

import com.example.realestate.model.dto.CustomerDTO;
import com.example.realestate.model.dto.UserDTO;
import com.example.realestate.security.SecurityUtils;
import com.example.realestate.service.RoleService;
import com.example.realestate.service.UserService;
import com.example.realestate.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;


    @RequestMapping(value = "/admin/user-list",method = RequestMethod.GET)
    public ModelAndView getUser(@ModelAttribute UserDTO userDTO, HttpServletRequest httpServletRequest){
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/user/list.jsp");
        mav.addObject("activeMenu", "user");
        DisplayTagUtils.of(httpServletRequest, userDTO);

        List<UserDTO> userList = userService.getUsers(userDTO.getSearchValue(), PageRequest.of(userDTO.getPage() - 1, userDTO.getMaxPageItems()));
        userDTO.setListResult(userList);
        userDTO.setTotalItems(userService.countTotalItems(userDTO.getSearchValue()));
        mav.addObject("userDTO", userDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/user-edit", method = RequestMethod.GET)
    public ModelAndView addUser(@ModelAttribute("userEdit") UserDTO userDTO) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/user/edit.jsp");
        mav.addObject("activeMenu", "customer");

        userDTO.setRoles(roleService.getRoles());
        mav.addObject("userEdit", userDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/user-edit-{id}", method = RequestMethod.GET)
    public ModelAndView updateUser(@PathVariable("id") Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/user/edit.jsp");
        UserDTO userDTO = userService.findUserById(id);
        userDTO.setRoles(roleService.getRoles());
        mav.addObject("userEdit", userDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/changePass", method = RequestMethod.GET)
    public ModelAndView updatePassword(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/user/changepass.jsp");
        UserDTO userDTO = userService.findOneByUserName(SecurityUtils.getPrincipal().getUsername());
        mav.addObject("userEdit", userDTO);
        return mav;
    }

    @RequestMapping(value = "/admin/user/profile-{id}", method = RequestMethod.GET)
    public ModelAndView updateInfo(@PathVariable("id") Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("layout");
        mav.addObject("contentPage", "admin/user/profile.jsp");
        UserDTO userDTO = userService.findUserById(id);
        mav.addObject("userEdit", userDTO);
        return mav;
    }


}
