package com.example.realestate.api;

import com.example.realestate.model.dto.PasswordDTO;
import com.example.realestate.model.dto.UserDTO;
import com.example.realestate.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserAPI {

    @Autowired
    private UserService userService;

    @PostMapping()
    public UserDTO insertOrUpdateUser(@RequestBody UserDTO userDTO){
        userService.InsertOrUpdateUser(userDTO);
        return userDTO;
    }

    @DeleteMapping(value = "{id}")
    public void deleteUser(@PathVariable Long id){
        userService.deleteUser(id);
    }

    @PutMapping("/password/{id}/reset")
    public ResponseEntity<UserDTO> resetPassword(@PathVariable("id") long id) {
        return ResponseEntity.ok(userService.resetPassword(id));
    }

    @PutMapping("/change-password/{id}")
    public ResponseEntity<String> changePasswordUser(@PathVariable("id") long id,
                                                     @RequestBody PasswordDTO passwordDTO) {
        boolean result = userService.updatePassword(id, passwordDTO);
        if (result) {
            return ResponseEntity.ok("Đổi mật khẩu thành công");
        } else {
            return ResponseEntity.badRequest().body("Đổi mật khẩu thất bại. Vui lòng kiểm tra lại!");
        }
    }

}
