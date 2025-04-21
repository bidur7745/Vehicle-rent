package com.autorent.services;

import com.autorent.DAO.UserDao;
import com.autorent.model.User;

public class AuthService {
    public static int register(String firstName, String lastName, String email, String password, String phone, String role, String createdAt) {
        User usermodel = new User();
        usermodel.setFirstName(firstName);
        usermodel.setLastName(lastName);
        usermodel.setEmail(email);
        usermodel.setPassword(password);
        usermodel.setPhone(phone);
        usermodel.setRole(User.Role.valueOf(role));
        usermodel.setCreatedAt(createdAt);

        return UserDao.registerUser(usermodel);
    }
    }


