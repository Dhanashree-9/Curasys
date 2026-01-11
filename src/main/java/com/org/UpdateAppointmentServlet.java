package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/UpdateAppointment")
public class UpdateAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        String status = request.getParameter("status");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital","root","root");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE appointment SET status=? WHERE appointment_id=?");

            ps.setString(1, status);
            ps.setInt(2, appointmentId);
            ps.executeUpdate();

            con.close();

            // 🔁 back to doctor appointment list
            response.sendRedirect("DoctorAppointments.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
