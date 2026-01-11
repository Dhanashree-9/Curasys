package com.org;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/PharmacyProfileServlet")
@MultipartConfig
public class PharmacyProfileServlet extends HttpServlet {

protected void doPost(HttpServletRequest r, HttpServletResponse s)
throws ServletException, IOException {

 String uploadPath = getServletContext().getRealPath("")+"uploads";
 new java.io.File(uploadPath).mkdir();

 String photoName = null;
 Part p = r.getPart("photo");
 if(p!=null && p.getSize()>0){
   photoName = System.currentTimeMillis()+"_"+p.getSubmittedFileName();
   p.write(uploadPath+"/"+photoName);
 }

 try{
  Connection c=DriverManager.getConnection(
   "jdbc:mysql://localhost:3306/hospital","root","root");

  PreparedStatement ps=c.prepareStatement(
   "REPLACE INTO pharmacy_profile VALUES(1,?,?,?,?,?,?,?,?)");

  ps.setString(1,r.getParameter("name"));
  ps.setString(2,r.getParameter("email"));
  ps.setString(3,r.getParameter("contact"));
  ps.setString(4,r.getParameter("degree"));
  ps.setString(5,r.getParameter("license"));
  ps.setInt(6,Integer.parseInt(r.getParameter("age")));
  ps.setInt(7,Integer.parseInt(r.getParameter("experience")));
  ps.setString(8,photoName);

  ps.executeUpdate();
  c.close();

 }catch(Exception e){ e.printStackTrace(); }

 s.sendRedirect("pharmacyDashboard.jsp");
}
}
