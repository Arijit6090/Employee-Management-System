<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Employee" %>
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
    Employee emp = (Employee) request.getAttribute("employee");
    if (emp == null) {
        response.sendRedirect(request.getContextPath() + "/employee/employeeDashboard.jsp"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile — WorkHub</title>
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
        <a href="<%= request.getContextPath() %>/employee/employeeDashboard.jsp">
            <i class="bi bi-grid-1x2-fill"></i> Dashboard
        </a>
        <a href="<%= request.getContextPath() %>/employee/profile" class="active">
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
        <div class="topbar-title">My Profile</div>
        <div style="display:flex;align-items:center;gap:10px;">
            <div class="avatar" style="background:#10b981;"><%= username.substring(0,1).toUpperCase() %></div>
            <div class="avatar-info">
                <div class="av-name"><%= username %></div>
                <div class="av-role">Employee</div>
            </div>
        </div>
    </div>

    <div class="content">
        <div style="max-width:700px;">
            <div class="page-card">
                <!-- Profile Header -->
                <div style="display:flex;align-items:center;gap:22px;padding-bottom:22px;margin-bottom:22px;border-bottom:1px solid var(--border);">
                    <% if (emp.getProfilePhoto() != null && !emp.getProfilePhoto().isEmpty()) { %>
                        <img src="<%= request.getContextPath() %>/images/<%= emp.getProfilePhoto() %>"
                             class="profile-photo" alt="Profile Photo">
                    <% } else { %>
                        <div class="profile-avatar" style="background:linear-gradient(135deg,#065f46,#10b981);">
                            <%= emp.getName().substring(0,1).toUpperCase() %>
                        </div>
                    <% } %>
                    <div>
                        <h5 style="margin:0 0 3px;font-weight:800;color:var(--text-primary);font-size:20px;">
                            <%= emp.getName() %>
                        </h5>
                        <div style="color:var(--text-muted);font-size:13px;margin-bottom:8px;">
                            <%= emp.getDesignation() %>
                        </div>
                        <span style="background:#d1fae5;color:#065f46;border-radius:999px;padding:4px 14px;font-size:11.5px;font-weight:700;">
                            <%= emp.getDepartment() %>
                        </span>
                    </div>
                </div>

                <!-- Info Rows -->
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-hash"></i> Employee ID</div>
                    <div class="info-value">#<%= emp.getEmployeeId() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-envelope"></i> Email</div>
                    <div class="info-value"><%= emp.getEmail() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-phone"></i> Phone</div>
                    <div class="info-value"><%= emp.getPhone() != null ? emp.getPhone() : "—" %></div>
                </div>
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-building"></i> Department</div>
                    <div class="info-value"><%= emp.getDepartment() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-briefcase"></i> Designation</div>
                    <div class="info-value"><%= emp.getDesignation() %></div>
                </div>
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-currency-rupee"></i> Salary</div>
                    <div class="info-value" style="color:var(--success);">
                        ₹<%= String.format("%,.0f", emp.getSalary()) %> / month
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-calendar3"></i> Joining Date</div>
                    <div class="info-value"><%= emp.getJoiningDate() %></div>
                </div>

                <div style="margin-top:24px;">
                    <a href="<%= request.getContextPath() %>/employee/viewPayslip" class="btn-main">
                        <i class="bi bi-receipt"></i> View My Payslips
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
