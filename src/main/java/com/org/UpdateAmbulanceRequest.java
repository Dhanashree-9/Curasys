package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateAmbulanceRequest")
public class UpdateAmbulanceRequest extends HttpServlet {

    protected void doPost(HttpServletRequest r, HttpServletResponse s)
            throws IOException {

        int id = Integer.parseInt(r.getParameter("requestId"));
        String status = r.getParameter("status");

        try {
            Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital","root","root");

            PreparedStatement p = c.prepareStatement(
                "UPDATE ambulance_request SET status=? WHERE request_id=?");

            p.setString(1, status);
            p.setInt(2, id);
            p.executeUpdate();

            c.close();
            s.sendRedirect("ambulanceRequests.jsp");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
