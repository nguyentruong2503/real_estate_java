package com.example.realestate.service.impl;
import com.example.realestate.converter.UserConverter;
import com.example.realestate.entity.UserEntity;
import com.example.realestate.model.dto.MyUserDetail;
import com.example.realestate.model.dto.UserDTO;
import com.example.realestate.repository.UserRepository;
import com.example.realestate.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CustomUserDetailService implements UserDetailsService{

    @Autowired
    private UserService userService;

    @Autowired
    private UserConverter userConverter;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserDTO userDTO = userService.findOneByUserNameAndActive(username, 1);

        if(userDTO == null){
            throw new UsernameNotFoundException("Username not found");
        }

        List<GrantedAuthority> authorities = userDTO.getRoles().stream()
                .map(role -> new SimpleGrantedAuthority("ROLE_" + role.getCode()))
                .collect(Collectors.toList());

        return new MyUserDetail(userDTO, authorities);
    }
}
