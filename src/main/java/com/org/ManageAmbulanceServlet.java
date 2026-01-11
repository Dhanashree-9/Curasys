package com.org;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ManageAmbulanceServlet")
public class ManageAmbulanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ArrayList<String[]> ambulances = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            // ⭐ NOW FETCH FROM ambulance_profile (not users)
            PreparedStatement ps = con.prepareStatement(
                "SELECT ambulance_id, driver_name, contact_number, photo FROM ambulance_profile"
            );

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ambulances.add(new String[]{
                    rs.getString("ambulance_id"),
                    rs.getString("driver_name"),
                    rs.getString("contact_number"),
                    rs.getString("photo")
                });
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("ambulances", ambulances);
        RequestDispatcher rd = req.getRequestDispatcher("manageAmbulance.jsp");
        rd.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String id = req.getParameter("id");

        try {
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            // ⭐ Delete from ambulance_profile table
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM ambulance_profile WHERE ambulance_id=?"
            );

            ps.setString(1, id);
            ps.executeUpdate();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("ManageAmbulanceServlet");
    }
}
