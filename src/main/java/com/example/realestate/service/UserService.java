package com.example.realestate.service;

import com.example.realestate.model.dto.PasswordDTO;
import com.example.realestate.model.dto.UserDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface UserService {
    Map<Long,String> getStaffs();

    UserDTO findOneByUserNameAndActive(String name, int active);

    List<UserDTO> getUsers(String searchValue, Pageable pageable);

    int countTotalItems(String searchValue);

    UserDTO InsertOrUpdateUser (UserDTO userDTO);

    UserDTO findUserById(long id);

    void deleteUser(Long id);

    UserDTO resetPassword(long id);

    UserDTO findOneByUserName(String userName);

    boolean  updatePassword(long id, PasswordDTO passwordDTO);
}
