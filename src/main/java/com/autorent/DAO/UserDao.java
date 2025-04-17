package com.autorent.DAO;

import com.autorent.model.User;

public class UserDao {

    public static final String INSERT_USER = "INSERT INTO users(name,email,password,role, profile_picture) VALUES(?,?,?,?, ?)";

    public static int registerUser(User user){




        return -1;
    }

}
