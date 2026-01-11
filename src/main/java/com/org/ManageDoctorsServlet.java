package com.org;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ManageDoctorsServlet")
public class ManageDoctorsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ArrayList<String[]> doctors = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            // ⭐ Fetch from doctor_profile (NOT users)
            PreparedStatement ps = con.prepareStatement(
                "SELECT id, name, email, image FROM doctor_profile"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                doctors.add(new String[]{
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("image")  // ⭐ doctor uploaded image
                });
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("doctors", doctors);
        RequestDispatcher rd = req.getRequestDispatcher("manageDoctors.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String id = req.getParameter("id");

        try {
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            // ⭐ Delete doctor profile
            PreparedStatement ps1 = con.prepareStatement(
                "DELETE FROM doctor_profile WHERE id=?"
            );
            ps1.setString(1, id);
            ps1.executeUpdate();

            // ⭐ Also delete from users (optional but recommended)
            PreparedStatement ps2 = con.prepareStatement(
                "DELETE FROM users WHERE email IN (SELECT email FROM doctor_profile WHERE id=?)"
            );
            ps2.setString(1, id);
            ps2.executeUpdate();

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("ManageDoctorsServlet");
    }
}
