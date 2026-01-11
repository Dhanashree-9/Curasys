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
import javax.servlet.http.Part;

@WebServlet("/AddInventoryServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,   // 1MB
    maxFileSize = 1024 * 1024 * 5,      // 5MB
    maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class AddInventoryServlet extends HttpServlet {

protected void doPost(HttpServletRequest r, HttpServletResponse s)
throws ServletException, IOException {

    // -------- TEXT FIELDS --------
    String medicine = r.getParameter("medicine");
    String dosage = r.getParameter("dosage");
    int quantity = Integer.parseInt(r.getParameter("quantity"));
    double price = Double.parseDouble(r.getParameter("price"));

    // -------- IMAGE UPLOAD --------
    Part part = r.getPart("image");   // ✅ NOW SAFE
    String fileName = part.getSubmittedFileName();

    String uploadPath = getServletContext().getRealPath("/") + "uploads";
    new java.io.File(uploadPath).mkdirs();

    part.write(uploadPath + "/" + fileName);

    // -------- DATABASE SAVE --------
    try {
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hospital", "root", "root");

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO pharmacy_inventory(medicine_name,dosage,total_quantity,price,image) VALUES(?,?,?,?,?)");

        ps.setString(1, medicine);
        ps.setString(2, dosage);
        ps.setInt(3, quantity);
        ps.setDouble(4, price);
        ps.setString(5, fileName);

        ps.executeUpdate();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    // -------- REDIRECT --------
    s.sendRedirect("inventory.jsp");
}
}
