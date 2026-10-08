<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.moneymate.dao.ParentDAO"%>
<%@page import="com.moneymate.dao.StudentDAO"%>
<%@page import="com.moneymate.dao.ExpenseDAO"%>
<%@page import="com.moneymate.dao.SavingsDAO"%>
<%@page import="com.moneymate.dao.InvestmentDAO"%>
<%@page import="com.moneymate.model.Expense"%>
<%@page import="com.moneymate.model.SavingsGoal"%>
<%@page import="com.moneymate.model.Investment"%>
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
    
    String studentName = "No Student Linked";
    double pocketMoney = 0;
    double expensesTotal = 0;
    double balance = 0;
    double savingsTotal = 0;
    double investmentsTotal = 0;
    
    List<Expense> recentExpenses = null;
    List<SavingsGoal> savings = null;
    List<Investment> investments = null;

    if (studentId > 0) {
        studentName = parentDAO.getStudentName(studentId);
        StudentDAO studentDAO = new StudentDAO();
        pocketMoney = studentDAO.getTotalPocketMoney(studentId);
        expensesTotal = studentDAO.getTotalExpenses(studentId);
        balance = pocketMoney - expensesTotal;
        savingsTotal = studentDAO.getTotalSavings(studentId);
        investmentsTotal = studentDAO.getTotalInvestments(studentId);
        
        ExpenseDAO expenseDAO = new ExpenseDAO();
        recentExpenses = expenseDAO.getExpensesByStudent(studentId);
        if (recentExpenses.size() > 5) {
            recentExpenses = recentExpenses.subList(0, 5); // Show top 5
        }
        
        SavingsDAO savingsDAO = new SavingsDAO();
        savings = savingsDAO.getSavingsGoals(studentId);
        
        InvestmentDAO investmentDAO = new InvestmentDAO();
        investments = investmentDAO.getInvestments(studentId);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Parent Dashboard - MoneyMate</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f4f6f8; }
        .header { background: #2563eb; color: white; padding: 20px 30px; }
        .header h1 { margin: 0; }
        .container { padding: 30px; }
        .cards { display: flex; gap: 20px; flex-wrap: wrap; margin-bottom: 30px; }
        .card { background: white; padding: 20px; width: 220px; border-radius: 10px; box-shadow: 0 3px 10px rgba(0,0,0,0.1); }
        .card h3 { margin-top: 0; color: #555; }
        .card p { font-size: 22px; font-weight: bold; color: #2563eb; margin-bottom: 0;}
        .section { background: white; margin-bottom: 30px; padding: 25px; border-radius: 10px; box-shadow: 0 3px 10px rgba(0,0,0,0.1); }
        .nav-buttons { display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap; }
        .btn { padding: 10px 20px; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .btn-blue { background: #2563eb; }
        .btn-red { background: #dc2626; }
        .btn-green { background: #10b981; }
        .btn-purple { background: #8b5cf6; }
        .btn-dark { background: #333; margin-top: 20px; display: inline-block; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f1f5f9; }
    </style>
</head>
<body>

    <div class="header">
        <h1>MoneyMate</h1>
        <p>Parent Dashboard</p>
    </div>

    <div class="container">
        <h2>Welcome, <%= username %></h2>
        
        <div class="nav-buttons">
            <a class="btn btn-blue" href="dashboard.jsp">Dashboard</a>
            <a class="btn btn-green" href="givePocketMoney.jsp">Give Pocket Money</a>
            <a class="btn btn-red" href="expenses.jsp">Student Expenses</a>
            <a class="btn btn-dark" style="margin-top:0;" href="../login.jsp">Logout</a>
        </div>
        
        <div class="section">
            <h2 style="margin-top: 0;">Student: <%= studentName %></h2>
        </div>

        <div class="cards">
            <div class="card">
                <h3>Total Pocket Money</h3>
                <p>Rs. <%= pocketMoney %></p>
            </div>
            <div class="card">
                <h3>Total Expenses</h3>
                <p>Rs. <%= expensesTotal %></p>
            </div>
            <div class="card">
                <h3>Current Balance</h3>
                <p>Rs. <%= balance %></p>
            </div>
            <div class="card">
                <h3>Total Savings</h3>
                <p>Rs. <%= savingsTotal %></p>
            </div>
            <div class="card">
                <h3>Total Investments</h3>
                <p>Rs. <%= investmentsTotal %></p>
            </div>
        </div>

        <div class="section">
            <h2>Recent Expenses</h2>
            <table>
                <tr><th>Date</th><th>Category</th><th>Description</th><th>Amount</th></tr>
                <% if (recentExpenses == null || recentExpenses.isEmpty()) { %>
                    <tr><td colspan="4">No expenses found.</td></tr>
                <% } else {
                    for (Expense e : recentExpenses) { %>
                        <tr>
                            <td><%= e.getExpenseDate() != null ? e.getExpenseDate() : "N/A" %></td>
                            <td><%= e.getCategory() %></td>
                            <td><%= e.getDescription() %></td>
                            <td>Rs. <%= e.getAmount() %></td>
                        </tr>
                <% } } %>
            </table>
        </div>

        <div class="section">
            <h2>Savings Goals</h2>
            <table>
                <tr><th>Goal Name</th><th>Target</th><th>Saved</th><th>Remaining</th></tr>
                <% if (savings == null || savings.isEmpty()) { %>
                    <tr><td colspan="4">No savings goals found.</td></tr>
                <% } else {
                    for (SavingsGoal g : savings) { 
                        double remaining = g.getTargetAmount() - g.getSavedAmount();
                        if (remaining < 0) remaining = 0;
                    %>
                        <tr>
                            <td><%= g.getGoalName() %></td>
                            <td>Rs. <%= g.getTargetAmount() %></td>
                            <td>Rs. <%= g.getSavedAmount() %></td>
                            <td>Rs. <%= remaining %></td>
                        </tr>
                <% } } %>
            </table>
        </div>

        <div class="section">
            <h2>Investments</h2>
            <table>
                <tr><th>Type</th><th>Amount</th><th>Date</th><th>Description</th></tr>
                <% if (investments == null || investments.isEmpty()) { %>
                    <tr><td colspan="4">No investments found.</td></tr>
                <% } else {
                    for (Investment i : investments) { %>
                        <tr>
                            <td><%= i.getInvestmentType() %></td>
                            <td>Rs. <%= i.getInvestedAmount() %></td>
                            <td><%= i.getInvestmentDate() != null ? i.getInvestmentDate() : "N/A" %></td>
                            <td><%= i.getInvestmentName() %></td>
                        </tr>
                <% } } %>
            </table>
        </div>

    </div>
</body>
</html>