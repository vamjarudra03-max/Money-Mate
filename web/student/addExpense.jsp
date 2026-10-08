<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"STUDENT".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Add Expense - MoneyMate</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        .container {
            width: 480px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        h1 {
            text-align: center;
            color: #dc2626;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        textarea {
            height: 90px;
            resize: vertical;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 13px;
            background: #dc2626;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #b91c1c;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 20px;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Add Expense</h1>

    <form action="saveExpense.jsp" method="post">

        <label>Amount</label>

        <input
            type="number"
            name="amount"
            step="0.01"
            min="1"
            placeholder="Enter expense amount"
            required>


        <label>Category</label>

        <select name="category" required>

            <option value="">Select Category</option>

            <option value="Food">Food</option>

            <option value="Travel">Travel</option>

            <option value="Shopping">Shopping</option>

            <option value="Education">Education</option>

            <option value="Entertainment">Entertainment</option>

            <option value="Bills">Bills</option>

            <option value="Health">Health</option>

            <option value="Other">Other</option>

        </select>


        <label>Description</label>

        <textarea
            name="description"
            placeholder="Example: Lunch at college"
            required></textarea>


        <label>Payment Mode</label>

        <select name="paymentMode" required>

            <option value="">Select Payment Mode</option>

            <option value="Cash">Cash</option>

            <option value="UPI">UPI</option>

            <option value="Debit Card">Debit Card</option>

            <option value="Credit Card">Credit Card</option>

            <option value="Other">Other</option>

        </select>


        <button type="submit">
            Add Expense
        </button>

    </form>


    <a class="back" href="dashboard.jsp">
        Back to Dashboard
    </a>

</div>

</body>

</html>