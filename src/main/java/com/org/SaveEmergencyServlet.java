package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SaveEmergencyServlet")
public class SaveEmergencyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest r, HttpServletResponse s)
            throws IOException {

        try {
            // ✅ LOAD DRIVER (VERY IMPORTANT)
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital",
                "root",
                "root"
            );

            // ✅ EXPLICIT COLUMN NAMES (SAFE)
            PreparedStatement p = c.prepareStatement(
                "INSERT INTO ambulance_emergency " +
                "(patient_name, age, accident_type, location, hospital_name, contact_number) " +
                "VALUES (?,?,?,?,?,?)"
            );

            p.setString(1, r.getParameter("patientName"));
            p.setInt(2, Integer.parseInt(r.getParameter("age")));
            p.setString(3, r.getParameter("accident"));
            p.setString(4, r.getParameter("location"));
            p.setString(5, r.getParameter("hospital"));
            p.setString(6, r.getParameter("contact"));

            p.executeUpdate();
            c.close();

            // ✅ SAME PAGE + TOAST
            s.sendRedirect("ambulanceEmergency.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            s.sendRedirect("ambulanceEmergency.jsp?error=1");
        }
    }
}
