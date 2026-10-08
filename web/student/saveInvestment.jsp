<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.moneymate.dao.InvestmentDAO"%>
<%@page import="com.moneymate.dao.StudentDAO"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"STUDENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String type = request.getParameter("investmentType");
    String name = request.getParameter("investmentName");
    String amountStr = request.getParameter("investedAmount");

    try {
        double amount = Double.parseDouble(amountStr);

        StudentDAO studentDAO = new StudentDAO();
        int studentId = studentDAO.getStudentId(username);

        InvestmentDAO investmentDAO = new InvestmentDAO();
        boolean success = investmentDAO.addInvestment(studentId, type, name, amount);

        if (success) {
            response.sendRedirect("investments.jsp");
        } else {
            out.println("<h3>Failed to save investment. Please try again.</h3>");
            out.println("<a href='addInvestment.jsp'>Back</a>");
        }

    } catch (Exception e) {
        out.println("<h3>Invalid input.</h3>");
        out.println("<a href='addInvestment.jsp'>Back</a>");
    }
%>
