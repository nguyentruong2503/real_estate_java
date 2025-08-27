package com.example.realestate.security;
import com.example.realestate.model.dto.MyUserDetail;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
import java.util.List;

public class SecurityUtils {
    public static MyUserDetail getPrincipal() {
        return (MyUserDetail) SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();
    }

    public static List<String> getAuthorities() {
        List<String> results = new ArrayList<>();
        if (SecurityContextHolder.getContext().getAuthentication() != null) {
            for (GrantedAuthority authority : SecurityContextHolder
                    .getContext().getAuthentication().getAuthorities()) {
                results.add(authority.getAuthority());
            }
        }
        return results;
    }

    public static String getPrimaryRole() {
        List<String> roles = getAuthorities();
        return roles.isEmpty() ? "No Role" : roles.get(0);
    }

}
