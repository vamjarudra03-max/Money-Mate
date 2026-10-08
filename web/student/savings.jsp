<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.moneymate.dao.SavingsDAO"%>
<%@page import="com.moneymate.dao.StudentDAO"%>
<%@page import="com.moneymate.model.SavingsGoal"%>
<%@page import="java.util.List"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"STUDENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    StudentDAO studentDAO = new StudentDAO();
    int studentId = studentDAO.getStudentId(username);

    SavingsDAO savingsDAO = new SavingsDAO();
    List<SavingsGoal> goals = savingsDAO.getSavingsGoals(studentId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Savings Goals - MoneyMate</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; }
        .header { background: #2563eb; color: white; padding: 25px 35px; }
        .header h1 { margin: 0; font-size: 28px; }
        .container { padding: 30px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 3px 12px rgba(0,0,0,0.08); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #10b981; color: white; }
        .btn { display: inline-block; padding: 10px 20px; color: white; text-decoration: none; border-radius: 6px; }
        .btn-back { background: #333; margin-bottom: 20px; }
        .btn-add { background: #10b981; margin-bottom: 20px; float: right; }
    </style>
</head>
<body>

<div class="header">
    <h1>MoneyMate</h1>
    <p>Savings Goals</p>
</div>

<div class="container">
    <a href="dashboard.jsp" class="btn btn-back">&larr; Back to Dashboard</a>
    <a href="addSavings.jsp" class="btn btn-add">+ Create Savings Goal</a>
    
    <div style="clear: both;"></div>

    <table>
        <thead>
            <tr>
                <th>Goal Name</th>
                <th>Target Amount (Rs.)</th>
                <th>Saved Amount (Rs.)</th>
                <th>Remaining (Rs.)</th>
            </tr>
        </thead>
        <tbody>
            <% if (goals.isEmpty()) { %>
            <tr><td colspan="4">No savings goals found.</td></tr>
            <% } else {
                for (SavingsGoal g : goals) { 
                    double remaining = g.getTargetAmount() - g.getSavedAmount();
                    if(remaining < 0) remaining = 0;
            %>
            <tr>
                <td><%= g.getGoalName() %></td>
                <td><%= g.getTargetAmount() %></td>
                <td><%= g.getSavedAmount() %></td>
                <td><%= remaining %></td>
            </tr>
            <% } } %>
        </tbody>
    </table>
</div>

</body>
</html>
