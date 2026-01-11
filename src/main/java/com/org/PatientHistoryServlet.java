package com.org;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PatientHistory")
public class PatientHistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        // NO LOGIC, NO SESSION, NO ATTRIBUTES
        res.sendRedirect("PHistory.jsp");
    }
}
