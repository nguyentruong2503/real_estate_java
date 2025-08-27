package com.example.realestate.service.impl;

import com.example.realestate.converter.RoleConverter;
import com.example.realestate.entity.RoleEntity;
import com.example.realestate.model.dto.RoleDTO;
import com.example.realestate.repository.RoleRepository;
import com.example.realestate.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private RoleConverter roleConverter;

    @Override
    public List<RoleDTO> getRoles() {
        List<RoleEntity> roleEntity = roleRepository.findAll();
        List<RoleDTO> result = new ArrayList<>();
        for(RoleEntity item : roleEntity){
            RoleDTO roleDTO = roleConverter.toRoleDTO(item);
            result.add(roleDTO);
        }
        return result;
    }
}
