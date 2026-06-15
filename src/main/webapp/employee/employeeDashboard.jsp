<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); return;
    }
    if (!"employee".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/error/accessDenied.jsp"); return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Dashboard — WorkHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
</head>
<body>

<div class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon" style="background:#10b981;">
            <i class="bi bi-people-fill" style="color:#fff;"></i>
        </div>
        <div>
            <div class="brand-text">WorkHub</div>
            <span class="brand-sub">Employee Panel</span>
        </div>
    </div>
    <div class="sidebar-nav">
        <div class="nav-section">My Account</div>
        <a href="<%= request.getContextPath() %>/employee/employeeDashboard.jsp" class="active">
            <i class="bi bi-grid-1x2-fill"></i> Dashboard
        </a>
        <a href="<%= request.getContextPath() %>/employee/profile">
            <i class="bi bi-person-circle"></i> My Profile
        </a>
        <a href="<%= request.getContextPath() %>/employee/viewPayslip">
            <i class="bi bi-receipt"></i> My Payslips
        </a>
        <div class="nav-section">Account</div>
        <a href="<%= request.getContextPath() %>/logout">
            <i class="bi bi-box-arrow-left"></i> Logout
        </a>
    </div>
    <div class="sidebar-footer">
        <div class="user-card-sidebar">
            <div class="avatar" style="background:#10b981;"><%= username.substring(0,1).toUpperCase() %></div>
            <div>
                <div class="u-name"><%= username %></div>
                <div class="u-role">Employee</div>
            </div>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="topbar">
        <div class="topbar-title">My Dashboard</div>
        <div style="display:flex;align-items:center;gap:10px;">
            <div class="avatar" style="background:#10b981;"><%= username.substring(0,1).toUpperCase() %></div>
            <div class="avatar-info">
                <div class="av-name"><%= username %></div>
                <div class="av-role">Employee</div>
            </div>
        </div>
    </div>

    <div class="content">

        <!-- Welcome Banner -->
        <div style="background:linear-gradient(135deg,#0f172a,#065f46);border-radius:var(--radius);padding:28px 32px;margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;gap:20px;">
            <div>
                <h4 style="color:#fff;font-weight:800;margin:0 0 6px;font-size:20px;">
                    Hello, <%= username %>! 👋
                </h4>
                <p style="color:rgba(255,255,255,0.65);font-size:13.5px;margin:0;">
                    Welcome to your employee portal. Here you can view your profile and payslips.
                </p>
            </div>
            <div style="width:64px;height:64px;background:rgba(255,255,255,0.1);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:800;color:#fff;flex-shrink:0;">
                <%= username.substring(0,1).toUpperCase() %>
            </div>
        </div>

        <!-- Quick Cards -->
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:20px;">
            <a href="<%= request.getContextPath() %>/employee/profile" class="quick-card">
                <span class="qc-icon" style="color:#6366f1;">
                    <i class="bi bi-person-circle"></i>
                </span>
                <h6>My Profile</h6>
                <p>View your personal details and employment information</p>
            </a>
            <a href="<%= request.getContextPath() %>/employee/viewPayslip" class="quick-card">
                <span class="qc-icon" style="color:#10b981;">
                    <i class="bi bi-receipt"></i>
                </span>
                <h6>My Payslips</h6>
                <p>View and download your monthly salary slips</p>
            </a>
            <a href="<%= request.getContextPath() %>/logout" class="quick-card">
                <span class="qc-icon" style="color:#ef4444;">
                    <i class="bi bi-box-arrow-left"></i>
                </span>
                <h6>Sign Out</h6>
                <p>Securely log out of your account</p>
            </a>
        </div>

    </div>
</div>

</body>
</html>
