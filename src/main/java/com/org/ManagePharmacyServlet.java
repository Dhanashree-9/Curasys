package com.org;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ManagePharmacyServlet")
public class ManagePharmacyServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ArrayList<String[]> pharmacies = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                "SELECT id, name, email, contact, degree, license_number, age, experience, photo FROM pharmacy_profile"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                pharmacies.add(new String[]{
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("contact"),
                    rs.getString("degree"),
                    rs.getString("license_number"),
                    rs.getString("age"),
                    rs.getString("experience"),
                    rs.getString("photo")
                });
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("pharmacies", pharmacies);
        RequestDispatcher rd = req.getRequestDispatcher("managePharmacy.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String id = req.getParameter("id");

        try {
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            PreparedStatement ps1 = con.prepareStatement(
                "DELETE FROM pharmacy_profile WHERE id=?"
            );
            ps1.setString(1, id);
            ps1.executeUpdate();

            PreparedStatement ps2 = con.prepareStatement(
                "DELETE FROM users WHERE email=(SELECT email FROM pharmacy_profile WHERE id=?) AND role='pharmacy'"
            );
            ps2.setString(1, id);
            ps2.executeUpdate();

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("ManagePharmacyServlet");
    }
}
