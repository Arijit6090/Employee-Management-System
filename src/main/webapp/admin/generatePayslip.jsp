<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Employee, java.util.List" %>
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
    String error = (String) request.getAttribute("error");
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");

    java.util.Calendar cal = java.util.Calendar.getInstance();
    int currentYear  = cal.get(java.util.Calendar.YEAR);
    int currentMonth = cal.get(java.util.Calendar.MONTH) + 1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Payslip — WorkHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
    <style>
        .row { display: flex; flex-wrap: wrap; gap: 0 20px; }
        .col-half { flex: 1 1 calc(50% - 10px); min-width: 180px; margin-bottom: 18px; }
        .col-full  { flex: 1 1 100%; margin-bottom: 18px; }
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
        <a href="<%= request.getContextPath() %>/admin/employeeList">
            <i class="bi bi-people"></i> All Employees
        </a>
        <a href="<%= request.getContextPath() %>/admin/addEmployee">
            <i class="bi bi-person-plus"></i> Add Employee
        </a>
        <div class="nav-section">Payslip</div>
        <a href="<%= request.getContextPath() %>/admin/generatePayslip" class="active">
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
            <div class="topbar-title">Generate Payslip</div>
            <div style="font-size:12px;color:var(--text-muted);margin-top:1px;">
                Create and optionally email a payslip to an employee
            </div>
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
        <% if (error != null) { %>
        <div class="alert alert-danger">
            <i class="bi bi-exclamation-circle"></i> <%= error %>
            <button class="alert-close" onclick="this.parentElement.remove()">×</button>
        </div>
        <% } %>

        <div style="max-width:640px;">
            <div class="page-card">
                <div class="card-section-title">
                    <i class="bi bi-receipt" style="color:var(--warning);"></i> New Payslip
                </div>

                <form action="<%= request.getContextPath() %>/admin/generatePayslip" method="post">

                    <div style="margin-bottom:18px;">
                        <label class="form-label">Select Employee *</label>
                        <select id="empSelect" name="employeeId" class="form-select" required>
                            <option value="">— Choose Employee —</option>
                            <% if (employees != null) {
                                   for (Employee emp : employees) { %>
                            <option value="<%= emp.getEmployeeId() %>"
                                    data-salary="<%= (int) emp.getSalary() %>">
                                <%= emp.getName() %> &mdash; <%= emp.getDepartment() %>
                            </option>
                            <% }} %>
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-half">
                            <label class="form-label">Month *</label>
                            <select name="month" class="form-select" required>
                                <% String[] mNames = {"","January","February","March","April","May","June",
                                                       "July","August","September","October","November","December"};
                                   for (int i = 1; i <= 12; i++) { %>
                                <option value="<%= i %>" <%= i == currentMonth ? "selected" : "" %>>
                                    <%= mNames[i] %>
                                </option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-half">
                            <label class="form-label">Year *</label>
                            <input type="number" name="year" class="form-control"
                                   value="<%= currentYear %>" min="2020" max="2099" required>
                        </div>
                    </div>

                    <div style="margin-bottom:18px;">
                        <label class="form-label">Basic Salary (₹) *</label>
                        <input type="number" id="salaryInput" name="basicSalary" class="form-control"
                               placeholder="Auto-filled when employee is selected" min="0" required>
                        <div class="form-hint">
                            <i class="bi bi-info-circle"></i>
                            Auto-filled from employee record — adjust if needed.
                        </div>
                    </div>

                    <div class="email-option-box" style="margin-bottom:22px;">
                        <div class="form-check">
                            <input type="checkbox" name="sendEmail" id="sendEmail" class="form-check-input">
                            <label for="sendEmail" class="form-check-label">
                                <strong>Send email to employee</strong> after generating the payslip
                                <span style="display:block;font-size:12px;color:var(--text-muted);margin-top:2px;">
                                    The payslip will be emailed automatically
                                </span>
                            </label>
                        </div>
                    </div>

                    <div style="display:flex;gap:12px;">
                        <button type="submit" class="btn-main">
                            <i class="bi bi-check-lg"></i> Generate Payslip
                        </button>
                        <a href="<%= request.getContextPath() %>/admin/employeeList" class="btn-outline-secondary">
                            <i class="bi bi-x-lg"></i> Cancel
                        </a>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('empSelect').addEventListener('change', function () {
        const selected = this.options[this.selectedIndex];
        const salary = selected.getAttribute('data-salary');
        document.getElementById('salaryInput').value = salary || '';
    });
</script>
</body>
</html>
