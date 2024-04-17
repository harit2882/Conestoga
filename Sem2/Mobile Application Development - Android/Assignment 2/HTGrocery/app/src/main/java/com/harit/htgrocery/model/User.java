package com.harit.htgrocery.model;

import java.io.Serializable;

public class User implements Serializable {

    private String username,emailId,password;

    public User(){

    }
    public User(String username, String emailId, String password) {
        this.username = username;
        this.emailId = emailId;
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}