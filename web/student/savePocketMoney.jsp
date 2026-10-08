<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.moneymate.dao.StudentDAO"%>
<%@page import="com.moneymate.dao.PocketMoneyDAO"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    // Check login
    if (username == null || !"STUDENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String amountString = request.getParameter("amount");
    String description = request.getParameter("description");

    try {

        // Get student ID
        StudentDAO studentDAO = new StudentDAO();
        int studentId = studentDAO.getStudentId(username);

        // Convert amount
        double amount = Double.parseDouble(amountString);

        // Save pocket money
        PocketMoneyDAO pocketMoneyDAO = new PocketMoneyDAO();

        boolean success = pocketMoneyDAO.addPocketMoney(
                studentId,
                0,
                amount,
                description
        );

        if (success) {

            response.sendRedirect("dashboard.jsp");

        } else {

            out.println("<h2>Failed to add pocket money.</h2>");
            out.println("<a href='addPocketMoney.jsp'>Try Again</a>");

        }

    } catch (Exception e) {

        out.println("<h2>Error occurred.</h2>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("<a href='addPocketMoney.jsp'>Go Back</a>");

    }
%>