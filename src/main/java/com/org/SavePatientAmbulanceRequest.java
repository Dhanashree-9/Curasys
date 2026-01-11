package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SavePatientAmbulanceRequest")
public class SavePatientAmbulanceRequest extends HttpServlet {

    protected void doPost(HttpServletRequest r, HttpServletResponse s)
            throws IOException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital","root","root");

            PreparedStatement p = c.prepareStatement(
                "INSERT INTO ambulance_request " +
                "(patient_name, ambulance_number, pickup_location, contact_number, status) " +
                "VALUES (?,?,?,?,?)");

            p.setString(1, r.getParameter("patientName"));
            p.setString(2, r.getParameter("ambulanceNumber"));
            p.setString(3, r.getParameter("pickupLocation"));
            p.setString(4, r.getParameter("contact"));
            p.setString(5, "PENDING");

            p.executeUpdate();
            c.close();

            // stays on same page
            s.sendRedirect("patientAmbulance.jsp");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
