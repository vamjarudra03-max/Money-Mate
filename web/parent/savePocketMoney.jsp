<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.moneymate.dao.PocketMoneyDAO"%>
<%@page import="com.moneymate.dao.ParentDAO"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"PARENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String studentIdStr = request.getParameter("studentId");
    String amountStr = request.getParameter("amount");
    String description = request.getParameter("description");

    try {
        int studentId = Integer.parseInt(studentIdStr);
        double amount = Double.parseDouble(amountStr);

        ParentDAO parentDAO = new ParentDAO();
        int parentId = parentDAO.getParentId(username);

        PocketMoneyDAO pocketMoneyDAO = new PocketMoneyDAO();
        boolean success = pocketMoneyDAO.addPocketMoney(studentId, parentId, amount, description);

        if (success) {
            response.sendRedirect("dashboard.jsp");
        } else {
            out.println("<h3>Failed to send pocket money.</h3>");
            out.println("<a href='givePocketMoney.jsp'>Back</a>");
        }

    } catch (Exception e) {
        out.println("<h3>Invalid input.</h3>");
        out.println("<a href='givePocketMoney.jsp'>Back</a>");
    }
%>
