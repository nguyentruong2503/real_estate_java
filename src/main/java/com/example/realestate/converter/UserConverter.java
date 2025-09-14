package com.example.realestate.converter;

import com.example.realestate.entity.RoleEntity;
import com.example.realestate.entity.UserEntity;
import com.example.realestate.model.dto.RoleDTO;
import com.example.realestate.model.dto.UserDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class UserConverter {

    @Autowired
    private ModelMapper modelMapper;

    public UserDTO toUserDTO(UserEntity entity) {
        UserDTO dto = modelMapper.map(entity, UserDTO.class);
        List<RoleDTO> roleDTOs = entity.getRoles().stream()
                .map(role -> modelMapper.map(role, RoleDTO.class))
                .collect(Collectors.toList());
        dto.setRoles(roleDTOs);
        return dto;
    }



}
