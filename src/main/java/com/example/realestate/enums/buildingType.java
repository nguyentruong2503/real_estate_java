package com.example.realestate.enums;

import java.util.HashMap;
import java.util.Map;

public enum buildingType {

    CAN_HO ("Căn hộ "),
    NGUYEN_CAN ("Nguyên Căn "),
    VAN_PHONG ("Văn phòng ");

    private final String name;

    buildingType(String name) {
        this.name = name;
    }

    public String getCode() {
        return name;
    }

    public static Map<String,String> type(){
        Map<String,String> listType = new HashMap<>();
        for(buildingType item : buildingType.values()){
            listType.put(item.toString() , item.name);
        }
        return listType;
    }
}
