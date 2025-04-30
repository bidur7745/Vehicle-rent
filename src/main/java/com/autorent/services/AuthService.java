package com.autorent.services;

import com.autorent.DAO.UserDao;
import com.autorent.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthService {
    public static boolean isValidPassword(String password) {
        // At least 8 chars, 1 uppercase, 1 number, 1 special character
        String pattern = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?\":{}|<>])(?=\\S+$).{8,}$";
        return password != null && password.matches(pattern);
    }

    public static boolean isValidPhone(String phone) {
        // Exactly 10 digits
        return phone != null && phone.matches("^[0-9]{10}$");
    }

    public static boolean phoneExists(String phone) {
        return UserDao.phoneExists(phone);
    }

    public static int register(String firstName, String lastName, String email, String password, String phone, String role, String createdAt) {
        // Check email
        if (UserDao.emailExists(email)) {
            return -2; // Email exists
        }

        // Check if name already exists
        if (UserDao.nameExists(firstName, lastName)) {
            return -3; // Name exists
        }

        // Check phone
        if (!isValidPhone(phone)) {
            return -5; // Invalid phone format
        }

        if (phoneExists(phone)) {
            return -6; // Phone number already exists
        }

        // Check password
        if (!isValidPassword(password)) {
            return -4; // Invalid password
        }

        User usermodel = new User();
        usermodel.setFirstName(firstName);
        usermodel.setLastName(lastName);
        usermodel.setEmail(email);
        usermodel.setPassword(password);
        usermodel.setPhone(phone);
        usermodel.setRole(User.Role.user);
        usermodel.setCreatedAt(createdAt);

        return UserDao.registerUser(usermodel);
    }

    public static User login(String email, String password){
        // Create a UserModel with the provided credentials
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);

        // Authenticate the user and return the result
        return UserDao.loginUser(user);
       
    }


    public static boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        User user = (User) session.getAttribute("user");
        return user != null;
    }

    public static User getUserById(int id) {

        return UserDao.getUserById(id);

    }




    public static void createUserSession(HttpServletRequest request, User user, int timeoutSeconds) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setMaxInactiveInterval(timeoutSeconds);
    }




    public static User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute("user");
    }


    public static void logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }


}



