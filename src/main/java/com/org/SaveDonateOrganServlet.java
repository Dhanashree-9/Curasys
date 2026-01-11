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

@WebServlet("/SaveDonateOrganServlet")
public class SaveDonateOrganServlet extends HttpServlet {
protected void doPost(HttpServletRequest r, HttpServletResponse s) throws IOException {
try{
Connection c=DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital","root","root");
PreparedStatement p=c.prepareStatement(
"INSERT INTO organ_donation(name,age,blood_group,organ_name,address,contact_number,note) VALUES(?,?,?,?,?,?,?)");
p.setString(1,r.getParameter("name"));
p.setInt(2,Integer.parseInt(r.getParameter("age")));
p.setString(3,r.getParameter("blood"));
p.setString(4,r.getParameter("organ"));
p.setString(5,r.getParameter("address"));
p.setString(6,r.getParameter("contact"));
p.setString(7,r.getParameter("note"));
p.executeUpdate();
s.sendRedirect("donateOrgan.jsp");
}catch(Exception e){e.printStackTrace();}
}
}
