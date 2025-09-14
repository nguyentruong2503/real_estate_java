package com.example.realestate.converter;

import com.example.realestate.entity.RoleEntity;
import com.example.realestate.model.dto.RoleDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RoleConverter {
    @Autowired
    private ModelMapper modelMapper;

    public RoleDTO toRoleDTO(RoleEntity entity) {
        RoleDTO result = modelMapper.map(entity, RoleDTO.class);
        return result;
    }
}
