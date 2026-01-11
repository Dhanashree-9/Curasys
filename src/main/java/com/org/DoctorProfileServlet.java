package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/DoctorProfileServlet")
@MultipartConfig
public class DoctorProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String gender = req.getParameter("gender");
        String specialization = req.getParameter("specialization");
        String qualification = req.getParameter("qualification");
        String experience = req.getParameter("experience");

        Part imagePart = req.getPart("image");
        String imageName = (imagePart != null && imagePart.getSize() > 0)
                ? System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName()
                : null;

        HttpSession session = req.getSession();
        String oldEmail = (String) session.getAttribute("doctorEmail");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital", "root", "root"
            );

            PreparedStatement ps;

            if (oldEmail == null) {
                ps = con.prepareStatement(
                    "INSERT INTO doctor_profile " +
                    "(name,email,contact,gender,specialization,qualification,experience,image) " +
                    "VALUES (?,?,?,?,?,?,?,?)"
                );
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, contact);
                ps.setString(4, gender);
                ps.setString(5, specialization);
                ps.setString(6, qualification);
                ps.setString(7, experience);
                ps.setString(8, imageName != null ? "images/" + imageName : null);

            } else {
                ps = con.prepareStatement(
                    "UPDATE doctor_profile SET name=?, contact=?, gender=?, specialization=?, " +
                    "qualification=?, experience=?, image=? WHERE email=?"
                );
                ps.setString(1, name);
                ps.setString(2, contact);
                ps.setString(3, gender);
                ps.setString(4, specialization);
                ps.setString(5, qualification);
                ps.setString(6, experience);
                ps.setString(7, imageName != null ? "images/" + imageName : (String)session.getAttribute("doctorImg"));
                ps.setString(8, email);
            }

            ps.executeUpdate();

            // ⭐ Save image physically
            if(imageName != null){
                String uploadPath = getServletContext().getRealPath("/images/");
                imagePart.write(uploadPath + imageName);
                session.setAttribute("doctorImg", "images/" + imageName);
            }

            // ⭐ Update Session Values
            session.setAttribute("doctorName", name);
            session.setAttribute("doctorSpec", specialization);
            session.setAttribute("doctorEmail", email);
            session.setAttribute("doctorContact", contact);
            session.setAttribute("doctorGender", gender);
            session.setAttribute("doctorQualification", qualification);
            session.setAttribute("doctorExperience", experience);

            // ⭐ UPDATE USERS TABLE FOR ADMIN VIEW
            if(session.getAttribute("doctorImg") != null){
                PreparedStatement ps2 = con.prepareStatement(
                    "UPDATE users SET profile_image=? WHERE email=? AND role='doctor'"
                );
                ps2.setString(1, session.getAttribute("doctorImg").toString());
                ps2.setString(2, email);
                ps2.executeUpdate();
                ps2.close();
            }

            con.close();
            res.sendRedirect("doctorProfile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp");
        }
    }
}
