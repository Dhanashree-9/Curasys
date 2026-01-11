package com.org;
import java.io.IOException;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {

        boolean ajax = "true".equals(req.getParameter("ajax"));
        String name="", photo="default.png";
        int doctor=0,patient=0,pharmacy=0,ambulance=0;

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital","root","root");

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT admin_name, photo FROM admin LIMIT 1");
            if(rs.next()){
                name = rs.getString("admin_name");
                photo = rs.getString("photo");
            }

            rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='DOCTOR'"); rs.next(); doctor=rs.getInt(1);
            rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='PATIENT'"); rs.next(); patient=rs.getInt(1);
            rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='PHARMACY'"); rs.next(); pharmacy=rs.getInt(1);
            rs = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='AMBULANCE'"); rs.next(); ambulance=rs.getInt(1);

            con.close();
        }catch(Exception e){ e.printStackTrace(); }

        if(ajax){
            res.setContentType("application/json");
            res.getWriter().print(
            "{ \"adminName\":\""+name+"\","+
              "\"adminPhoto\":\""+photo+"\","+
              "\"doctor\":"+doctor+","+
              "\"patient\":"+patient+","+
              "\"pharmacy\":"+pharmacy+","+
              "\"ambulance\":"+ambulance+" }"
            );
            return;
        }

        res.sendRedirect("adminDashboard.jsp");
    }
}
