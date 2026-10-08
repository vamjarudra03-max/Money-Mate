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
    <title>Create Savings Goal - MoneyMate</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; }
        .header { background: #2563eb; color: white; padding: 25px 35px; }
        .header h1 { margin: 0; font-size: 28px; }
        .container { padding: 30px; max-width: 600px; margin: auto; }
        .form-box { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 3px 12px rgba(0,0,0,0.08); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="number"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { display: inline-block; padding: 10px 20px; color: white; text-decoration: none; border-radius: 6px; cursor: pointer; border: none; font-size: 16px; }
        .btn-submit { background: #10b981; }
        .btn-cancel { background: #333; margin-left: 10px; }
    </style>
</head>
<body>
<div class="header">
    <h1>MoneyMate</h1>
    <p>Create Savings Goal</p>
</div>
<div class="container">
    <div class="form-box">
        <h2>New Goal</h2>
        <form action="saveSavings.jsp" method="POST">
            <div class="form-group">
                <label>Goal Name</label>
                <input type="text" name="goalName" required placeholder="e.g. New Laptop">
            </div>
            <div class="form-group">
                <label>Target Amount (Rs.)</label>
                <input type="number" step="0.01" name="targetAmount" required placeholder="e.g. 50000">
            </div>
            <div class="form-group">
                <label>Already Saved Amount (Rs.)</label>
                <input type="number" step="0.01" name="savedAmount" required placeholder="e.g. 10000" value="0">
            </div>
            <button type="submit" class="btn btn-submit">Save Goal</button>
            <a href="savings.jsp" class="btn btn-cancel">Cancel</a>
        </form>
    </div>
</div>
</body>
</html>
