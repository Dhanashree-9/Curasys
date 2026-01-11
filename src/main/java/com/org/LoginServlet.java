package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                    "SELECT role FROM users WHERE email=? AND password=?");

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // ✅ CREATE SESSION (THIS WAS MISSING)
                HttpSession session = request.getSession();
                session.setAttribute("email", email);

                String role = rs.getString("role");

                switch (role) {

                    case "admin":
                        response.sendRedirect("adminDashboard.jsp");
                        break;

                    case "doctor":
                        response.sendRedirect("doctorDashboard.jsp");
                        break;

                    case "pharmacy":
                        response.sendRedirect("pharmacyDashboard.jsp");
                        break;
                      
                    case "ambulance":
                        response.sendRedirect("ambulanceDashboard.jsp");
                        break;
                        
                        
                    case "patient":
                        // ✅ REDIRECT TO SERVLET (NOT JSP)
                        response.sendRedirect("PatientDashboard");
                        break;

                    default:
                        response.sendRedirect("login.jsp?error=invalidrole");
                }

            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        }
    }
}
