package com.autorent.controllers;

import com.autorent.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            LocalDate time  = LocalDate.now();
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email  = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            int userid = AuthService.register(firstName,lastName,email,password,phone,String.valueOf(role), String.valueOf(time));
            System.out.println(userid);
            if (userid != -1) {
                response.sendRedirect("login.jsp");

            }
            else {
                // Registration failed
                request.setAttribute("errorMessage", "Registration failed. Email may already be in use.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }


        } catch (Exception e) {
            // Handle any exceptions
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {





    }
}