package com.org;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileServlet")
@MultipartConfig
public class ProfileServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String email = (String) session.getAttribute("email");

    // PROFILE DATA
    String fullName = request.getParameter("fullName");
    int age = Integer.parseInt(request.getParameter("age"));
    Date dob = Date.valueOf(request.getParameter("dob"));
    String gender = request.getParameter("gender");
    String blood = request.getParameter("bloodGroup");
    String address = request.getParameter("address");

    // VITALS DATA
    String chronic = request.getParameter("chronic");
    String weight = request.getParameter("weight");
    String bp = request.getParameter("bp");
    String pulse = request.getParameter("pulse");

    Part photoPart = request.getPart("photo");
    String photoName = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hospital","root","root");

        // IMAGE HANDLING
        if (photoPart != null && photoPart.getSize() > 0) {
            photoName = System.currentTimeMillis() + "_" + photoPart.getSubmittedFileName();
            String path = getServletContext().getRealPath("") + "uploads";
            File dir = new File(path);
            if (!dir.exists()) dir.mkdir();
            photoPart.write(path + File.separator + photoName);
        } else {
            PreparedStatement p = con.prepareStatement(
                "SELECT photo FROM patient_profile WHERE email=?");
            p.setString(1, email);
            ResultSet r = p.executeQuery();
            if (r.next()) photoName = r.getString("photo");
        }

        // PROFILE SAVE
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO patient_profile VALUES (?,?,?,?,?,?,?,?) " +
            "ON DUPLICATE KEY UPDATE full_name=?, age=?, dob=?, gender=?, blood_group=?, address=?, photo=?");

        ps.setString(1,email);
        ps.setString(2,fullName);
        ps.setInt(3,age);
        ps.setDate(4,dob);
        ps.setString(5,gender);
        ps.setString(6,blood);
        ps.setString(7,address);
        ps.setString(8,photoName);

        ps.setString(9,fullName);
        ps.setInt(10,age);
        ps.setDate(11,dob);
        ps.setString(12,gender);
        ps.setString(13,blood);
        ps.setString(14,address);
        ps.setString(15,photoName);

        ps.executeUpdate();

        // ✅ VITALS SAVE
        PreparedStatement vs = con.prepareStatement(
            "INSERT INTO vitals VALUES (?,?,?,?,?) " +
            "ON DUPLICATE KEY UPDATE chronic_disease=?, weight=?, bp=?, pulse=?");

        vs.setString(1,email);
        vs.setString(2,chronic);
        vs.setString(3,weight);
        vs.setString(4,bp);
        vs.setString(5,pulse);

        vs.setString(6,chronic);
        vs.setString(7,weight);
        vs.setString(8,bp);
        vs.setString(9,pulse);

        vs.executeUpdate();

        con.close();

        response.sendRedirect("PatientDashboard");

    } catch(Exception e){
        e.printStackTrace();
    }
}
}
