<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.moneymate.dao.StudentDAO"%>
<%@page import="com.moneymate.dao.ExpenseDAO"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"STUDENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String amountString = request.getParameter("amount");
    String category = request.getParameter("category");
    String description = request.getParameter("description");
    String paymentMode = request.getParameter("paymentMode");

    try {

        StudentDAO studentDAO = new StudentDAO();

        int studentId = studentDAO.getStudentId(username);

        double amount = Double.parseDouble(amountString);

        ExpenseDAO expenseDAO = new ExpenseDAO();

        boolean success = expenseDAO.addExpense(
                studentId,
                amount,
                category,
                description,
                paymentMode
        );

        if (success) {

            response.sendRedirect("dashboard.jsp");

        } else {

            out.println("<h2>Failed to add expense.</h2>");
            out.println("<a href='addExpense.jsp'>Try Again</a>");

        }

    } catch (Exception e) {

        out.println("<h2>Error occurred.</h2>");
        out.println("<p>" + e.getMessage() + "</p>");
        out.println("<a href='addExpense.jsp'>Go Back</a>");

    }
%>