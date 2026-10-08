<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.moneymate.dao.StudentDAO"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"STUDENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    StudentDAO studentDAO = new StudentDAO();

    int studentId = studentDAO.getStudentId(username);

    double pocketMoney = studentDAO.getTotalPocketMoney(studentId);
    double expenses = studentDAO.getTotalExpenses(studentId);
    double savings = studentDAO.getTotalSavings(studentId);

    double balance = pocketMoney - expenses;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Dashboard - MoneyMate</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        .header {
            background: #2563eb;
            color: white;
            padding: 25px 35px;
        }

        .header h1 {
            margin: 0;
            font-size: 28px;
        }

        .header p {
            margin: 6px 0 0;
        }

        .container {
            padding: 30px;
        }

        .welcome {
            margin-bottom: 25px;
        }

        .welcome h2 {
            margin-bottom: 5px;
        }

        .cards {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card {
            background: white;
            width: 220px;
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.10);
        }

        .card h3 {
            color: #555;
            margin-top: 0;
        }

        .amount {
            font-size: 26px;
            font-weight: bold;
            color: #2563eb;
        }

        .section {
            margin-top: 30px;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.08);
        }

        .section h2 {
            margin-top: 0;
        }

        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .button {
            display: inline-block;
            padding: 13px 22px;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .pocket-button {
            background: #2563eb;
        }

        .pocket-button:hover {
            background: #1d4ed8;
        }

        .expense-button {
            background: #dc2626;
        }

        .expense-button:hover {
            background: #b91c1c;
        }

        .logout {
            display: inline-block;
            margin-top: 30px;
            padding: 11px 25px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .logout:hover {
            background: #111;
        }

    </style>

</head>

<body>


<!-- HEADER -->

<div class="header">

    <h1>MoneyMate</h1>

    <p>Student Dashboard</p>

</div>


<!-- MAIN CONTAINER -->

<div class="container">


    <!-- WELCOME -->

    <div class="welcome">

        <h2>Welcome, <%= username %></h2>

        <p>Here is your personal financial overview.</p>

    </div>


    <!-- FINANCIAL CARDS -->

    <div class="cards">


        <!-- POCKET MONEY -->

        <div class="card">

            <h3>Pocket Money</h3>

            <div class="amount">
                Rs. <%= pocketMoney %>
            </div>

        </div>


        <!-- EXPENSES -->

        <div class="card">

            <h3>Total Expenses</h3>

            <div class="amount">
                Rs. <%= expenses %>
            </div>

        </div>


        <!-- BALANCE -->

        <div class="card">

            <h3>Current Balance</h3>

            <div class="amount">
                Rs. <%= balance %>
            </div>

        </div>


        <!-- SAVINGS -->

        <div class="card">

            <h3>Total Savings</h3>

            <div class="amount">
                Rs. <%= savings %>
            </div>

        </div>


    </div>


    <!-- FINANCIAL OVERVIEW -->

    <div class="section">

        <h2>Financial Overview</h2>

        <p>Your current financial summary:</p>

        <p>
            <strong>Pocket Money:</strong>
            Rs. <%= pocketMoney %>
        </p>

        <p>
            <strong>Total Expenses:</strong>
            Rs. <%= expenses %>
        </p>

        <p>
            <strong>Current Balance:</strong>
            Rs. <%= balance %>
        </p>

        <p>
            <strong>Total Savings:</strong>
            Rs. <%= savings %>
        </p>

    </div>


    <!-- ACTION BUTTONS -->

    <div class="action-buttons">


        <a class="button pocket-button"
           href="${pageContext.request.contextPath}/student/addPocketMoney.jsp">

            + Add Pocket Money

        </a>


        <a class="button expense-button"
           href="${pageContext.request.contextPath}/student/addExpense.jsp">

            + Add Expense

        </a>

        <a class="button" style="background: #eab308;"
           href="${pageContext.request.contextPath}/student/expenseHistory.jsp">
            Expense History
        </a>

        <a class="button" style="background: #10b981;"
           href="${pageContext.request.contextPath}/student/savings.jsp">
            Savings Goals
        </a>

        <a class="button" style="background: #8b5cf6;"
           href="${pageContext.request.contextPath}/student/investments.jsp">
            Investments
        </a>

    </div>


    <!-- LOGOUT -->

    <a class="logout" href="../login.jsp">

        Logout

    </a>


</div>


</body>

</html>