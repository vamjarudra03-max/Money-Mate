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

    <title>Add Pocket Money</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 450px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }

        h1 {
            text-align: center;
            color: #2563eb;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        textarea {
            height: 100px;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 13px;
            border: none;
            border-radius: 5px;
            background: #2563eb;
            color: white;
            font-size: 16px;
            cursor: pointer;
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

    <h1>Add Pocket Money</h1>

    <form action="savePocketMoney.jsp" method="post">

        <label>Amount</label>

        <input
            type="number"
            name="amount"
            step="0.01"
            min="1"
            placeholder="Enter amount"
            required>


        <label>Description</label>

        <textarea
            name="description"
            placeholder="Example: Monthly pocket money"
            required></textarea>


        <button type="submit">
            Add Pocket Money
        </button>

    </form>

    <a class="back" href="dashboard.jsp">
        Back to Dashboard
    </a>

</div>

</body>

</html>