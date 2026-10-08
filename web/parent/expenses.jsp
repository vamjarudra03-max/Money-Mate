<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.moneymate.dao.ExpenseDAO"%>
<%@page import="com.moneymate.dao.ParentDAO"%>
<%@page import="com.moneymate.model.Expense"%>
<%@page import="java.util.List"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"PARENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    ParentDAO parentDAO = new ParentDAO();
    int parentId = parentDAO.getParentId(username);
    int studentId = parentDAO.getLinkedStudentId(parentId);
    String studentName = "Unknown Student";

    List<Expense> expenses = null;
    if (studentId > 0) {
        studentName = parentDAO.getStudentName(studentId);
        ExpenseDAO expenseDAO = new ExpenseDAO();
        expenses = expenseDAO.getExpensesByStudent(studentId);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Expenses - MoneyMate</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; }
        .header { background: #2563eb; color: white; padding: 25px 35px; }
        .header h1 { margin: 0; font-size: 28px; }
        .container { padding: 30px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 3px 12px rgba(0,0,0,0.08); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #dc2626; color: white; }
        .btn-back { display: inline-block; margin-bottom: 20px; padding: 10px 20px; background: #333; color: white; text-decoration: none; border-radius: 6px; }
    </style>
</head>
<body>

<div class="header">
    <h1>MoneyMate</h1>
    <p>Student Expenses: <%= studentName %></p>
</div>

<div class="container">
    <a href="dashboard.jsp" class="btn-back">&larr; Back to Dashboard</a>
    
    <% if (studentId > 0) { %>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Category</th>
                <th>Description</th>
                <th>Payment Mode</th>
                <th>Amount (Rs.)</th>
            </tr>
        </thead>
        <tbody>
            <% if (expenses == null || expenses.isEmpty()) { %>
            <tr><td colspan="5">No expenses found.</td></tr>
            <% } else {
                for (Expense e : expenses) { %>
            <tr>
                <td><%= e.getExpenseDate() != null ? e.getExpenseDate() : "N/A" %></td>
                <td><%= e.getCategory() %></td>
                <td><%= e.getDescription() %></td>
                <td><%= e.getPaymentMode() %></td>
                <td><%= e.getAmount() %></td>
            </tr>
            <% } } %>
        </tbody>
    </table>
    <% } else { %>
        <p style="color:red;">No student linked to this account.</p>
    <% } %>
</div>

</body>
</html>
