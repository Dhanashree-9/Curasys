package com.org;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ManagePatientsServlet")
public class ManagePatientsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ArrayList<String[]> patients = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            // Fetch full patient profile
            PreparedStatement ps = con.prepareStatement(
                "SELECT email, full_name, gender, age, blood_group, address, photo FROM patient_profile"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                patients.add(new String[]{
                    rs.getString("email"),
                    rs.getString("full_name"),
                    rs.getString("gender"),
                    rs.getString("age"),
                    rs.getString("blood_group"),
                    rs.getString("address"),
                    rs.getString("photo")
                });
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("patients", patients);
        RequestDispatcher rd = req.getRequestDispatcher("managePatients.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String email = req.getParameter("email");

        try {
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            // Delete profile
            PreparedStatement ps1 = con.prepareStatement(
                "DELETE FROM patient_profile WHERE email=?"
            );
            ps1.setString(1, email);
            ps1.executeUpdate();

            // Delete login from users (optional)
            PreparedStatement ps2 = con.prepareStatement(
                "DELETE FROM users WHERE email=? AND role='patient'"
            );
            ps2.setString(1, email);
            ps2.executeUpdate();

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("ManagePatientsServlet");
    }
}
