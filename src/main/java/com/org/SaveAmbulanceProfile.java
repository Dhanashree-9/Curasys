package com.org;

import java.io.*;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SaveAmbulanceProfile")
@MultipartConfig
public class SaveAmbulanceProfile extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String driverName = request.getParameter("driverName");
        String ambulanceNumber = request.getParameter("ambulanceNumber");
        String contact = request.getParameter("contact");
        String area = request.getParameter("area");
        String hospital = request.getParameter("hospital");

        String photoPath = "images/default.png";
        Connection con = null;

        try {
            Part photo = request.getPart("photo");

            if(photo != null && photo.getSize() > 0){
                String fileName = System.currentTimeMillis()+"_"+photo.getSubmittedFileName();
                String uploadDir = request.getServletContext().getRealPath("/images");

                File dir = new File(uploadDir);
                if(!dir.exists()) dir.mkdirs();

                photo.write(uploadDir + File.separator + fileName);
                photoPath = "images/" + fileName;
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital","root","root");

            // INSERT into ambulance_profile
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO ambulance_profile " +
                "(ambulance_number, driver_name, contact_number, area, hospital_name, photo) " +
                "VALUES (?,?,?,?,?,?)");

            ps.setString(1, ambulanceNumber);
            ps.setString(2, driverName);
            ps.setString(3, contact);
            ps.setString(4, area);
            ps.setString(5, hospital);
            ps.setString(6, photoPath);
            ps.executeUpdate();
            ps.close();

            // UPDATE users table for admin ManageAmbulance view
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");

            if(email != null) {
                PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE users SET profile_image=? WHERE email=? AND role='ambulance'");
                ps2.setString(1, photoPath);
                ps2.setString(2, email);
                ps2.executeUpdate();
                ps2.close();
            }

            con.close();
            response.sendRedirect("ambulanceProfile.jsp?success=1");

        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("ambulanceProfile.jsp?error=1");
        }
    }
}
