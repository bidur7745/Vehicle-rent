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
            LocalDate time = LocalDate.now();
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            // Store the form data in request attributes
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);

            int userid = AuthService.register(firstName, lastName, email, password, phone, "user", String.valueOf(time));
            if (userid > 0) {
                // Set success message and redirect to login
                request.getSession().setAttribute("successMessage", "Account created successfully! Please login.");
                response.sendRedirect("login.jsp");
                return;
            } else if (userid == -2) {
                request.setAttribute("errorMessage", "Email already in use.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (userid == -3) {
                request.setAttribute("errorMessage", "A user with this name already exists.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (userid == -4) {
                request.setAttribute("errorMessage", "Password must be at least 8 characters long, contain 1 uppercase letter, 1 number, and 1 special character.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (userid == -5) {
                request.setAttribute("errorMessage", "Phone number must be exactly 10 digits.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else if (userid == -6) {
                request.setAttribute("errorMessage", "Phone number already in use.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {





    }
}