package com.autorent.controllers;

import com.autorent.model.User;
import com.autorent.services.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       String email = request.getParameter("email");
       String password = request.getParameter("password");

       User user = AuthService.login(email,password);
        System.out.println("Role:" + user.getRole());

        HttpSession session = request.getSession();
        session.setAttribute("user",user);
        session.setAttribute("role",user.getRole());


       response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");



    }
}