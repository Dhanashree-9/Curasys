package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            // Check unique email
            PreparedStatement check = con.prepareStatement(
                "SELECT email FROM users WHERE email=?"
            );
            check.setString(1, email);

            if (check.executeQuery().next()) {
                response.sendRedirect("signup.jsp?error=emailexists");
                return;
            }

            // Insert new user
            PreparedStatement pst = con.prepareStatement(
                "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)"
            );

            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, role);

            pst.executeUpdate();
            con.close();

            response.sendRedirect("login.jsp?signup=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=db");
        }
    }
}
