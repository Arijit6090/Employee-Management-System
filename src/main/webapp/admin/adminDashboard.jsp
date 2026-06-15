<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.dao.EmployeeDAO, com.ems.dao.PayslipDAO" %>
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

    EmployeeDAO dao = new EmployeeDAO();
    int empCount     = dao.getEmployeeCount();
    int deptCount    = dao.getDepartmentCount();
    int payslipCount = new PayslipDAO().getPayslipCount();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard — EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
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
        <a href="<%= request.getContextPath() %>/admin/adminDashboard.jsp" class="active">
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
        <div class="topbar-title">Dashboard</div>
        <div class="topbar-right">
            <a href="<%= request.getContextPath() %>/admin/addEmployee" class="btn-main" style="padding:8px 16px; font-size:13px;">
                <i class="bi bi-person-plus"></i> Add Employee
            </a>
            <div class="d-flex align-items-center gap-2" style="display:flex;align-items:center;gap:10px;">
                <div class="avatar"><%= username.substring(0,1).toUpperCase() %></div>
                <div class="avatar-info">
                    <div class="av-name"><%= username %></div>
                    <div class="av-role">Administrator</div>
                </div>
            </div>
        </div>
    </div>

    <div class="content">

        <!-- Welcome -->
        <div style="margin-bottom:28px;">
            <h4 style="font-weight:800; color:var(--text-primary); margin:0 0 4px;">
                Good day, <%= username %>! 👋
            </h4>
            <p style="color:var(--text-muted); font-size:13.5px; margin:0;">
                Here's a quick overview of your organisation.
            </p>
        </div>

        <!-- Stat Cards -->
        <div style="display:grid; grid-template-columns:repeat(auto-fit,minmax(210px,1fr)); gap:20px; margin-bottom:32px;">
            <div class="stat-card">
                <div class="stat-icon primary"><i class="bi bi-people-fill"></i></div>
                <div>
                    <h3><%= empCount %></h3>
                    <p>Total Employees</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon success"><i class="bi bi-building"></i></div>
                <div>
                    <h3><%= deptCount %></h3>
                    <p>Departments</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon warning"><i class="bi bi-receipt"></i></div>
                <div>
                    <h3><%= payslipCount %></h3>
                    <p>Payslips Generated</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon danger"><i class="bi bi-shield-check"></i></div>
                <div>
                    <h3><%= empCount + 1 %></h3>
                    <p>Active Users</p>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="page-card">
            <div class="card-section-title">
                <i class="bi bi-lightning-fill" style="color:var(--warning);"></i> Quick Actions
            </div>
            <div style="display:grid; grid-template-columns:repeat(auto-fit,minmax(160px,1fr)); gap:14px;">
                <a href="<%= request.getContextPath() %>/admin/employeeList"
                   style="display:flex;align-items:center;gap:12px;padding:16px;border-radius:10px;border:1.5px solid var(--border);text-decoration:none;color:var(--text-primary);transition:all 0.2s;"
                   onmouseover="this.style.borderColor='#6366f1';this.style.background='#f0f0ff';"
                   onmouseout="this.style.borderColor='var(--border)';this.style.background='';">
                    <div style="width:40px;height:40px;background:var(--primary-light);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="bi bi-people" style="color:var(--primary);font-size:18px;"></i>
                    </div>
                    <div>
                        <div style="font-weight:700;font-size:13px;">View All</div>
                        <div style="font-size:11.5px;color:var(--text-muted);">Employees</div>
                    </div>
                </a>
                <a href="<%= request.getContextPath() %>/admin/addEmployee"
                   style="display:flex;align-items:center;gap:12px;padding:16px;border-radius:10px;border:1.5px solid var(--border);text-decoration:none;color:var(--text-primary);transition:all 0.2s;"
                   onmouseover="this.style.borderColor='#10b981';this.style.background='#f0fdf4';"
                   onmouseout="this.style.borderColor='var(--border)';this.style.background='';">
                    <div style="width:40px;height:40px;background:#d1fae5;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="bi bi-person-plus" style="color:#10b981;font-size:18px;"></i>
                    </div>
                    <div>
                        <div style="font-weight:700;font-size:13px;">Add New</div>
                        <div style="font-size:11.5px;color:var(--text-muted);">Employee</div>
                    </div>
                </a>
                <a href="<%= request.getContextPath() %>/admin/generatePayslip"
                   style="display:flex;align-items:center;gap:12px;padding:16px;border-radius:10px;border:1.5px solid var(--border);text-decoration:none;color:var(--text-primary);transition:all 0.2s;"
                   onmouseover="this.style.borderColor='#f59e0b';this.style.background='#fffbeb';"
                   onmouseout="this.style.borderColor='var(--border)';this.style.background='';">
                    <div style="width:40px;height:40px;background:#fef3c7;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="bi bi-receipt" style="color:#f59e0b;font-size:18px;"></i>
                    </div>
                    <div>
                        <div style="font-weight:700;font-size:13px;">Generate</div>
                        <div style="font-size:11.5px;color:var(--text-muted);">Payslip</div>
                    </div>
                </a>
                <a href="<%= request.getContextPath() %>/logout"
                   style="display:flex;align-items:center;gap:12px;padding:16px;border-radius:10px;border:1.5px solid var(--border);text-decoration:none;color:var(--text-primary);transition:all 0.2s;"
                   onmouseover="this.style.borderColor='#ef4444';this.style.background='#fff5f5';"
                   onmouseout="this.style.borderColor='var(--border)';this.style.background='';">
                    <div style="width:40px;height:40px;background:#fee2e2;border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                        <i class="bi bi-box-arrow-left" style="color:#ef4444;font-size:18px;"></i>
                    </div>
                    <div>
                        <div style="font-weight:700;font-size:13px;">Sign Out</div>
                        <div style="font-size:11.5px;color:var(--text-muted);">Logout</div>
                    </div>
                </a>
            </div>
        </div>

    </div>
</div>

</body>
</html>
