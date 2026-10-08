<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.moneymate.dao.ParentDAO"%>
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

    if (studentId > 0) {
        studentName = parentDAO.getStudentName(studentId);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Give Pocket Money - MoneyMate</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; }
        .header { background: #2563eb; color: white; padding: 25px 35px; }
        .header h1 { margin: 0; font-size: 28px; }
        .container { padding: 30px; max-width: 600px; margin: auto; }
        .form-box { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 3px 12px rgba(0,0,0,0.08); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="number"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        input[readonly] { background: #e9ecef; }
        .btn { display: inline-block; padding: 10px 20px; color: white; text-decoration: none; border-radius: 6px; cursor: pointer; border: none; font-size: 16px; }
        .btn-submit { background: #10b981; }
        .btn-cancel { background: #333; margin-left: 10px; }
    </style>
</head>
<body>
<div class="header">
    <h1>MoneyMate</h1>
    <p>Give Pocket Money</p>
</div>
<div class="container">
    <div class="form-box">
        <h2>Send Pocket Money</h2>
        <% if (studentId > 0) { %>
        <form action="savePocketMoney.jsp" method="POST">
            <input type="hidden" name="studentId" value="<%= studentId %>">
            <div class="form-group">
                <label>Student</label>
                <input type="text" value="<%= studentName %>" readonly>
            </div>
            <div class="form-group">
                <label>Amount (Rs.)</label>
                <input type="number" step="0.01" name="amount" required placeholder="e.g. 500">
            </div>
            <div class="form-group">
                <label>Description</label>
                <input type="text" name="description" required placeholder="e.g. Monthly pocket money">
            </div>
            <button type="submit" class="btn btn-submit">Send Money</button>
            <a href="dashboard.jsp" class="btn btn-cancel">Cancel</a>
        </form>
        <% } else { %>
            <p style="color:red;">No student linked to this account.</p>
            <a href="dashboard.jsp" class="btn btn-cancel">Go Back</a>
        <% } %>
    </div>
</div>
</body>
</html>
