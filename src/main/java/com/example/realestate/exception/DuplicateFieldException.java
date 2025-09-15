package com.example.realestate.exception;

public class DuplicateFieldException extends RuntimeException{
    public DuplicateFieldException(String message) {
        super(message);
    }
}
