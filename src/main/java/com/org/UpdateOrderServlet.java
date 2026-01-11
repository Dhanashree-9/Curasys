package com.org;

import java.io.IOException;
import java.sql.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateOrderServlet")
public class UpdateOrderServlet extends HttpServlet {

protected void doPost(HttpServletRequest r, HttpServletResponse s)
throws IOException {

    int orderId = Integer.parseInt(r.getParameter("order_id"));
    String action = r.getParameter("action");

    Connection con = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/hospital","root","root");

        // 🔐 START TRANSACTION
        con.setAutoCommit(false);

        if("ACCEPT".equals(action)){

            int inventoryId = Integer.parseInt(r.getParameter("inventory_id"));
            int qty = Integer.parseInt(r.getParameter("quantity"));

            // 1️⃣ CHECK STOCK
            PreparedStatement check = con.prepareStatement(
                "SELECT total_quantity FROM pharmacy_inventory WHERE inventory_id=?");
            check.setInt(1, inventoryId);
            ResultSet rs = check.executeQuery();

            if(!rs.next() || rs.getInt("total_quantity") < qty){
                con.rollback();
                s.sendRedirect("recentOrders.jsp?error=nostock");
                return;
            }

            // 2️⃣ REDUCE INVENTORY
            PreparedStatement reduce = con.prepareStatement(
                "UPDATE pharmacy_inventory SET total_quantity = total_quantity - ? WHERE inventory_id=?");
            reduce.setInt(1, qty);
            reduce.setInt(2, inventoryId);
            reduce.executeUpdate();

            // 3️⃣ UPDATE ORDER STATUS
            PreparedStatement updateOrder = con.prepareStatement(
                "UPDATE medicine_orders SET status='ACCEPTED' WHERE order_id=?");
            updateOrder.setInt(1, orderId);
            updateOrder.executeUpdate();

        }
        else if("REJECT".equals(action)){

            PreparedStatement reject = con.prepareStatement(
                "UPDATE medicine_orders SET status='REJECTED' WHERE order_id=?");
            reject.setInt(1, orderId);
            reject.executeUpdate();
        }

        // ✅ COMMIT ONLY IF ALL OK
        con.commit();
        con.close();

    }catch(Exception e){
        try{ if(con!=null) con.rollback(); }catch(Exception ex){}
        e.printStackTrace();
    }

    s.sendRedirect("recentOrders.jsp?msg=rejected");

}
}
