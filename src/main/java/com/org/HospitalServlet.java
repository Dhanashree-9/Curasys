package com.org;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/HospitalServlet")
public class HospitalServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        if(type == null) type = "";

        ArrayList<String[]> hospitals = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital", "root", "root");

            PreparedStatement ps = con.prepareStatement(
              "SELECT name, area, latitude, longitude FROM hospital1 WHERE LOWER(specialization) LIKE ?"
            );
            ps.setString(1, "%" + type.toLowerCase() + "%");

            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                hospitals.add(new String[]{
                    rs.getString("name"),
                    rs.getString("area"),
                    rs.getString("latitude"),
                    rs.getString("longitude")
                });
            }
            con.close();
        } catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("type", type);
        request.setAttribute("hospitals", hospitals);
        request.getRequestDispatcher("hospitalList.jsp").forward(request, response);
    }
}
