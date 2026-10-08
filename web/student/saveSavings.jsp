<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.moneymate.dao.SavingsDAO"%>
<%@page import="com.moneymate.dao.StudentDAO"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"STUDENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String goalName = request.getParameter("goalName");
    String targetStr = request.getParameter("targetAmount");
    String savedStr = request.getParameter("savedAmount");

    try {
        double targetAmount = Double.parseDouble(targetStr);
        double savedAmount = Double.parseDouble(savedStr);

        StudentDAO studentDAO = new StudentDAO();
        int studentId = studentDAO.getStudentId(username);

        SavingsDAO savingsDAO = new SavingsDAO();
        boolean success = savingsDAO.addSavingsGoal(studentId, goalName, targetAmount, savedAmount);

        if (success) {
            response.sendRedirect("savings.jsp");
        } else {
            out.println("<h3>Failed to save savings goal. Please try again.</h3>");
            out.println("<a href='addSavings.jsp'>Back</a>");
        }

    } catch (Exception e) {
        out.println("<h3>Invalid input.</h3>");
        out.println("<a href='addSavings.jsp'>Back</a>");
    }
%>
