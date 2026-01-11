package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SaveOrganRequestServlet")
public class SaveOrganRequestServlet extends HttpServlet {
protected void doPost(HttpServletRequest r, HttpServletResponse s)throws IOException{
try{
Connection c=DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital","root","root");
PreparedStatement p=c.prepareStatement(
"INSERT INTO organ_request(name,age,gender,blood_group,organ_name,city,address,identity_type,identity_number,contact_number,emergency_contact,note) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
p.setString(1,r.getParameter("name"));
p.setInt(2,Integer.parseInt(r.getParameter("age")));
p.setString(3,r.getParameter("gender"));
p.setString(4,r.getParameter("blood"));
p.setString(5,r.getParameter("organ"));
p.setString(6,r.getParameter("city"));
p.setString(7,r.getParameter("address"));
p.setString(8,r.getParameter("idType"));
p.setString(9,r.getParameter("idNumber"));
p.setString(10,r.getParameter("contact"));
p.setString(11,r.getParameter("emergency"));
p.setString(12,r.getParameter("note"));
p.executeUpdate();
s.sendRedirect("PatientRequestOrgan.jsp");
}catch(Exception e){e.printStackTrace();}
}
}
