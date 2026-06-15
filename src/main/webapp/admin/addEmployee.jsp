<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Employee — EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
    <style>
        .row { display: flex; flex-wrap: wrap; gap: 0 20px; }
        .col-half { flex: 1 1 calc(50% - 10px); min-width: 200px; margin-bottom: 18px; }
        .col-third { flex: 1 1 calc(33.33% - 14px); min-width: 160px; margin-bottom: 18px; }
        .col-full  { flex: 1 1 100%; margin-bottom: 18px; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="bi bi-people-fill" style="color:#fff;"></i></div>
        <div>
            <div class="brand-text">EMS Portal</div>
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
        <a href="<%= request.getContextPath() %>/admin/addEmployee" class="active">
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
            <div class="topbar-title">Add Employee</div>
            <div style="font-size:12px;color:var(--text-muted);margin-top:1px;">Fill in the form to create a new employee record</div>
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

        <form action="<%= request.getContextPath() %>/admin/addEmployee" method="post">

            <!-- Employee Information -->
            <div class="page-card" style="margin-bottom:20px;">
                <div class="card-section-title">
                    <i class="bi bi-person-badge" style="color:var(--primary);"></i>
                    Employee Information
                </div>
                <div class="row">
                    <div class="col-half">
                        <label class="form-label">Full Name *</label>
                        <input type="text" name="name" class="form-control"
                               placeholder="e.g. Rahul Sharma" required>
                    </div>
                    <div class="col-half">
                        <label class="form-label">Email Address *</label>
                        <input type="email" name="email" class="form-control"
                               placeholder="e.g. rahul@company.com" required>
                    </div>
                    <div class="col-half">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" name="phone" class="form-control"
                               placeholder="e.g. 9876543210" pattern="[0-9]{10}" maxlength="10"
                               title="Please enter exactly 10 digits">
                    </div>
                    <div class="col-half">
                        <label class="form-label">Department *</label>
                        <select name="department" class="form-select" required>
                            <option value="">— Select Department —</option>
                            <option>IT</option>
                            <option>HR</option>
                            <option>Finance</option>
                            <option>Marketing</option>
                            <option>Operations</option>
                            <option>Admin</option>
                        </select>
                    </div>
                    <div class="col-half">
                        <label class="form-label">Designation *</label>
                        <input type="text" name="designation" class="form-control"
                               placeholder="e.g. Software Developer" required>
                    </div>
                    <div class="col-third">
                        <label class="form-label">Salary (₹) *</label>
                        <input type="number" name="salary" class="form-control"
                               placeholder="e.g. 50000" min="0" required>
                    </div>
                    <div class="col-third">
                        <label class="form-label">Joining Date *</label>
                        <input type="date" name="joiningDate" class="form-control" required>
                    </div>
                </div>
            </div>

            <!-- Login Credentials -->
            <div class="page-card" style="margin-bottom:24px;">
                <div class="card-section-title">
                    <i class="bi bi-key-fill" style="color:var(--warning);"></i>
                    Login Credentials
                </div>
                <div class="row">
                    <div class="col-half">
                        <label class="form-label">Username *</label>
                        <input type="text" name="username" class="form-control"
                               placeholder="e.g. rahul.sharma" required autocomplete="off">
                    </div>
                    <div class="col-half">
                        <label class="form-label">Password *</label>
                        <input type="text" name="password" class="form-control"
                               placeholder="Set a strong password" required>
                    </div>
                </div>
            </div>

            <div style="display:flex;gap:12px;">
                <button type="submit" class="btn-main">
                    <i class="bi bi-person-check"></i> Add Employee
                </button>
                <a href="<%= request.getContextPath() %>/admin/employeeList" class="btn-outline-secondary">
                    <i class="bi bi-x-lg"></i> Cancel
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>
