package com.example.realestate.service.impl;

import com.example.realestate.entity.UserEntity;
import com.example.realestate.repository.UserRepository;
import com.example.realestate.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public Map<Long, String> getStaffs() {
        Map<Long,String> listStaffs = new HashMap<>();
        List<UserEntity> staffs = userRepository.findByActiveAndRoles_Code(1, "STAFF");
        for (UserEntity it : staffs){
            listStaffs.put(it.getId(), it.getFullName());
        }
        return listStaffs;
    }
}
