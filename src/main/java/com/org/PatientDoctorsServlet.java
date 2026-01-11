package com.org;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PatientDoctors")
public class PatientDoctorsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");

        if (patientId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<String[]> doctors = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/hospital", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                "SELECT d.id, d.name, d.specialization, " +
                "(SELECT COUNT(*) FROM appointment a WHERE a.doctor_id=d.id AND a.patient_id=?) AS booked " +
                "FROM doctor_profile d");

            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                doctors.add(new String[]{
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("specialization"),
                    rs.getString("booked")
                });
            }

            con.close();

            request.setAttribute("doctors", doctors);
            RequestDispatcher rd = request.getRequestDispatcher("pAppointment.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
