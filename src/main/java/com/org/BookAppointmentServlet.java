package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔥 REMOVE patientId logic completely
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital","root","root");

            // ⚠️ TEMP: use dummy patient id = 1
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO appointment (doctor_id, patient_id, status) VALUES (?, 1, 'PENDING')");

            ps.setInt(1, doctorId);
            ps.executeUpdate();

            con.close();

            response.sendRedirect("pAppointment.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
