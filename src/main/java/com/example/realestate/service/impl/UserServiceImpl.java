package com.example.realestate.service.impl;

import com.example.realestate.converter.UserConverter;
import com.example.realestate.entity.RoleEntity;
import com.example.realestate.entity.UserEntity;
import com.example.realestate.exception.NotFoundException;
import com.example.realestate.model.dto.PasswordDTO;
import com.example.realestate.model.dto.UserDTO;
import com.example.realestate.repository.RoleRepository;
import com.example.realestate.repository.UserRepository;
import com.example.realestate.security.SecurityUtils;
import com.example.realestate.service.UserService;
import org.modelmapper.Conditions;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.apache.commons.lang.StringUtils;

import java.util.*;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserConverter userConverter;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public Map<Long, String> getStaffs() {
        Map<Long,String> listStaffs = new HashMap<>();
        List<UserEntity> staffs = userRepository.findByActiveAndRoles_Code(1, "STAFF");
        for (UserEntity it : staffs){
            listStaffs.put(it.getId(), it.getFullName());
        }
        return listStaffs;
    }

    @Override
    public UserDTO findOneByUserNameAndActive(String name, int active) {
        return userConverter.toUserDTO(userRepository.findOneByUserNameAndActive(name,active));
    }

    @Override
    public List<UserDTO> getUsers(String searchValue, Pageable pageable) {
        Page<UserEntity> userList = null;
        if(StringUtils.isNotBlank(searchValue)){
            userList = userRepository.findByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndActive(searchValue,searchValue,1,pageable);
        }else {
            userList = userRepository.findByActive(1,pageable);
        }
        List<UserEntity> userEntities = userList.getContent();
        List<UserDTO> result = new ArrayList<>();
        for(UserEntity userEntity : userList){
            UserDTO userDTO = userConverter.toUserDTO(userEntity);
            userDTO.setRoleCode(userEntity.getRoles().get(0).getCode());
            result.add(userDTO);
        }
        return result;
    }

    @Override
    public int countTotalItems(String searchValue) {
        if (StringUtils.isNotBlank(searchValue)) {
            return userRepository.countByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndActive(
                    searchValue, searchValue, 1);
        } else {
            return userRepository.countByActive(1);
        }
    }

    @Override
    public UserDTO InsertOrUpdateUser(UserDTO userDTO) {
        Long userID = userDTO.getId();
        UserEntity userEntity;
        if(userID != null){
            UserEntity existEntity = userRepository.findById(userID).orElseThrow(() -> new NotFoundException("User not found!"));

            modelMapper.getConfiguration().setPropertyCondition(Conditions.isNotNull());
            modelMapper.map(userDTO, existEntity);
            existEntity.setModifiedDate(new Date());
            existEntity.setModifiedBy(SecurityUtils.getPrincipal().getFullName());

            userEntity = existEntity;
        }else {
            userEntity = modelMapper.map(userDTO,UserEntity.class);
            userEntity.setCreatedDate(new Date());
            userEntity.setCreatedBy(SecurityUtils.getPrincipal().getFullName());
            userEntity.setPassword(passwordEncoder.encode("123456"));

        }
        RoleEntity roleEntity = roleRepository.findOneByCode(userDTO.getRoleCode());
        List<RoleEntity> roles = new ArrayList<>();
        roles.add(roleEntity);
        userEntity.setRoles(roles);
        userEntity.setActive(1);
        userRepository.save(userEntity);
        userDTO.setId(userEntity.getId());
        return userDTO;
    }


    @Override
    public UserDTO findUserById(long id) {
        UserEntity entity = userRepository.findById(id).get();
        List<RoleEntity> roles = entity.getRoles();
        UserDTO dto = userConverter.toUserDTO(entity);
        roles.forEach(item -> {
            dto.setRoleCode(item.getCode());
        });
        return dto;
    }

    @Override
    public void deleteUser(Long id) {
        UserEntity userEntity= userRepository.findById(id).get();
        userEntity.setActive(0);
        userRepository.save(userEntity);
    }

    @Override
    public UserDTO resetPassword(long id) {
        UserEntity userEntity = userRepository.findById(id).get();
        userEntity.setPassword(passwordEncoder.encode("123456"));
        return userConverter.toUserDTO(userRepository.save(userEntity));
    }

    @Override
    public UserDTO findOneByUserName(String userName) {
        UserEntity userEntity = userRepository.findOneByUserName(userName);
        UserDTO userDTO = userConverter.toUserDTO(userEntity);
        return userDTO;
    }

    @Override
    public boolean updatePassword(long id, PasswordDTO passwordDTO) {
        UserEntity user = userRepository.findById(id).get();
        if (passwordEncoder.matches(passwordDTO.getCurrentPassword(), user.getPassword())
                && passwordDTO.getNewPassword().equals(passwordDTO.getConfirmPassword())) {
            user.setPassword(passwordEncoder.encode(passwordDTO.getNewPassword()));
            userRepository.save(user);
            return true;
        }
    return false;
    }
}
