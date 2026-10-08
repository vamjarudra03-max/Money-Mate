<%@page import="com.moneymate.dao.UserDAO"%>

<%

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    UserDAO userDAO = new UserDAO();

    String role = userDAO.login(username, password);

    if (role != null) {

        session.setAttribute("username", username);
        session.setAttribute("role", role);

        if ("STUDENT".equals(role)) {

            response.sendRedirect("student/dashboard.jsp");

        } else if ("PARENT".equals(role)) {

            response.sendRedirect("parent/dashboard.jsp");

        }

    } else {

        response.sendRedirect("login.jsp?error=invalid");

    }

%>