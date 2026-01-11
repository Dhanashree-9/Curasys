package com.org;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DoctorAppointments")
public class DoctorAppointmentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer doctorId = (Integer) session.getAttribute("doctorId");

        if (doctorId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<String[]> appointments = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                "SELECT appointment_id, patient_id, status FROM appointment WHERE doctor_id=?");

            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                appointments.add(new String[]{
                    rs.getString("appointment_id"),
                    rs.getString("patient_id"),
                    rs.getString("status")
                });
            }

            con.close();

            request.setAttribute("appointments", appointments);
            RequestDispatcher rd = request.getRequestDispatcher("DoctorAppointments.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
