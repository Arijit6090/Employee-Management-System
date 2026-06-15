<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Employee" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
    }
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/error/accessDenied.jsp"); return;
    }
    String username = (String) session.getAttribute("username");
    Employee emp = (Employee) request.getAttribute("employee");
    if (emp == null) {
        response.sendRedirect(request.getContextPath() + "/admin/employeeList"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Employee — WorkHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
    <style>
        .row { display: flex; flex-wrap: wrap; gap: 0 20px; }
        .col-half  { flex: 1 1 calc(50% - 10px); min-width: 200px; margin-bottom: 18px; }
        .col-third { flex: 1 1 calc(33.33% - 14px); min-width: 160px; margin-bottom: 18px; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="bi bi-people-fill" style="color:#fff;"></i></div>
        <div>
            <div class="brand-text">WorkHub</div>
            <span class="brand-sub">Admin Panel</span>
        </div>
    </div>
    <div class="sidebar-nav">
        <div class="nav-section">Main</div>
        <a href="<%= request.getContextPath() %>/admin/adminDashboard.jsp">
            <i class="bi bi-grid-1x2-fill"></i> Dashboard
        </a>
        <div class="nav-section">Employees</div>
        <a href="<%= request.getContextPath() %>/admin/employeeList" class="active">
            <i class="bi bi-people"></i> All Employees
        </a>
        <a href="<%= request.getContextPath() %>/admin/addEmployee">
            <i class="bi bi-person-plus"></i> Add Employee
        </a>
        <div class="nav-section">Payslip</div>
        <a href="<%= request.getContextPath() %>/admin/generatePayslip">
            <i class="bi bi-receipt"></i> Generate Payslip
        </a>
        <div class="nav-section">Account</div>
        <a href="<%= request.getContextPath() %>/logout">
            <i class="bi bi-box-arrow-left"></i> Logout
        </a>
    </div>
    <div class="sidebar-footer">
        <div class="user-card-sidebar">
            <div class="avatar"><%= username.substring(0,1).toUpperCase() %></div>
            <div>
                <div class="u-name"><%= username %></div>
                <div class="u-role">Administrator</div>
            </div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="topbar">
        <div>
            <div class="topbar-title">
                Edit Employee
                <span style="font-weight:400;color:var(--text-muted);font-size:15px;"> — #<%= emp.getEmployeeId() %></span>
            </div>
            <div style="font-size:12px;color:var(--text-muted);margin-top:1px;">Update the details below and save changes</div>
        </div>
        <div style="display:flex;align-items:center;gap:10px;">
            <div class="avatar"><%= username.substring(0,1).toUpperCase() %></div>
            <div class="avatar-info">
                <div class="av-name"><%= username %></div>
                <div class="av-role">Administrator</div>
            </div>
        </div>
    </div>

    <div class="content">
        <form action="<%= request.getContextPath() %>/admin/updateEmployee" method="post">
            <input type="hidden" name="employeeId" value="<%= emp.getEmployeeId() %>">

            <div class="page-card" style="margin-bottom:24px;">
                <div class="card-section-title">
                    <i class="bi bi-pencil-square" style="color:var(--primary);"></i>
                    Edit Employee Information
                </div>
                <div class="row">
                    <div class="col-half">
                        <label class="form-label">Full Name *</label>
                        <input type="text" name="name" class="form-control"
                               value="<%= emp.getName() %>" required>
                    </div>
                    <div class="col-half">
                        <label class="form-label">Email Address *</label>
                        <input type="email" name="email" class="form-control"
                               value="<%= emp.getEmail() %>" required>
                    </div>
                    <div class="col-half">
                        <label class="form-label">Phone Number</label>
                        <input type="text" name="phone" class="form-control"
                               value="<%= emp.getPhone() != null ? emp.getPhone() : "" %>">
                    </div>
                    <div class="col-half">
                        <label class="form-label">Department *</label>
                        <select name="department" class="form-select" required>
                            <% String[] depts = {"IT","HR","Finance","Marketing","Operations","Admin"};
                               for (String d : depts) { %>
                            <option value="<%= d %>" <%= d.equals(emp.getDepartment()) ? "selected" : "" %>>
                                <%= d %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-half">
                        <label class="form-label">Designation *</label>
                        <input type="text" name="designation" class="form-control"
                               value="<%= emp.getDesignation() %>" required>
                    </div>
                    <div class="col-third">
                        <label class="form-label">Salary (₹) *</label>
                        <input type="number" name="salary" class="form-control"
                               value="<%= (int)emp.getSalary() %>" min="0" required>
                    </div>
                    <div class="col-third">
                        <label class="form-label">Joining Date *</label>
                        <input type="date" name="joiningDate" class="form-control"
                               value="<%= emp.getJoiningDate() %>" required>
                    </div>
                </div>
            </div>

            <div style="display:flex;gap:12px;">
                <button type="submit" class="btn-main">
                    <i class="bi bi-check-lg"></i> Save Changes
                </button>
                <a href="<%= request.getContextPath() %>/admin/employeeList" class="btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i> Back to List
                </a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
