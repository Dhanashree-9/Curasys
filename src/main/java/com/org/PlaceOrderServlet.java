package com.org;

import java.io.IOException;
import java.sql.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

protected void doPost(HttpServletRequest r, HttpServletResponse s)
throws IOException {

    System.out.println("👉 Servlet called");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hospital","root","root");

        System.out.println("👉 DB Connected");

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO medicine_orders(inventory_id, medicine_name, dosage, quantity, price, total_amount) VALUES (?,?,?,?,?,?)");

        ps.setInt(1, Integer.parseInt(r.getParameter("inventory_id")));
        ps.setString(2, r.getParameter("medicine_name"));
        ps.setString(3, r.getParameter("dosage"));

        int qty = Integer.parseInt(r.getParameter("quantity"));
        double price = Double.parseDouble(r.getParameter("price"));

        ps.setInt(4, qty);
        ps.setDouble(5, price);
        ps.setDouble(6, qty * price);

        int rows = ps.executeUpdate();
        System.out.println("👉 Rows inserted = " + rows);

        con.close();

    }catch(Exception e){
        System.out.println("❌ ERROR");
        e.printStackTrace();
    }

    s.sendRedirect("patientpharmacy.jsp?success=1");
}
}
