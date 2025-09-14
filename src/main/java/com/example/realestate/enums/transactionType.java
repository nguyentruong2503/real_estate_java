package com.example.realestate.enums;

import java.util.HashMap;
import java.util.Map;

public enum transactionType {
    CALL ("Gọi điện và tư vấn"),
    VIEWING ("Dẫn đi xem"),
    DEPOSIT ("Đặt cọc"),
    RENTED ("Làm HĐ cho thuê");

    private final String name;

    transactionType(String name) {
        this.name = name;
    }


    public static Map<String,String> transactionType(){
        Map<String,String> listType = new HashMap<>();
        for(transactionType it : transactionType.values()){
            listType.put(it.toString() , it.name);
        }
        return listType;
    }
}
