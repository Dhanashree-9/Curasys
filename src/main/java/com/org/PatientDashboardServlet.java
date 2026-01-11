package com.org;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PatientDashboard")
public class PatientDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Profile.jsp");   // ✅ changed here
            return;
        }

        String email = (String) session.getAttribute("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM patient_profile WHERE email=?");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("fullName", rs.getString("full_name"));
                request.setAttribute("age", rs.getString("age"));
                request.setAttribute("dob", rs.getString("dob"));
                request.setAttribute("gender", rs.getString("gender"));
                request.setAttribute("blood", rs.getString("blood_group"));
                request.setAttribute("address", rs.getString("address"));

                if (rs.getString("photo") != null) {
                    request.setAttribute("photo", "uploads/" + rs.getString("photo"));
                }
            }

            con.close();
            request.getRequestDispatcher("patientDashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
