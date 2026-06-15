<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Employee, com.ems.model.Payslip, java.util.List" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    String successMsg = (String) session.getAttribute("successMsg");
    if (successMsg != null) session.removeAttribute("successMsg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Details — EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
    <style>
        .two-col { display: grid; grid-template-columns: 1fr 380px; gap: 20px; align-items: start; }
        @media (max-width: 900px) { .two-col { grid-template-columns: 1fr; } }
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
                Employee Details
                <span style="font-weight:400;color:var(--text-muted);font-size:15px;"> — #<%= emp.getEmployeeId() %></span>
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
        <% if (successMsg != null) { %>
        <div class="alert alert-success">
            <i class="bi bi-check-circle-fill"></i> <%= successMsg %>
            <button class="alert-close" onclick="this.parentElement.remove()">×</button>
        </div>
        <% } %>

        <div class="two-col" style="margin-bottom:20px;">
            <!-- Left: Profile Info -->
            <div class="page-card">
                <!-- Profile header -->
                <div style="display:flex;align-items:center;gap:20px;padding-bottom:20px;margin-bottom:20px;border-bottom:1px solid var(--border);">
                    <% if (emp.getProfilePhoto() != null && !emp.getProfilePhoto().isEmpty()) { %>
                        <img src="<%= request.getContextPath() %>/images/<%= emp.getProfilePhoto() %>"
                             class="profile-photo" alt="Profile">
                    <% } else { %>
                        <div class="profile-avatar"><%= emp.getName().substring(0,1).toUpperCase() %></div>
                    <% } %>
                    <div>
                        <h5 style="margin:0 0 3px;font-weight:800;color:var(--text-primary);font-size:18px;">
                            <%= emp.getName() %>
                        </h5>
                        <div style="color:var(--text-muted);font-size:13px;margin-bottom:8px;">
                            <%= emp.getDesignation() %>
                        </div>
                        <span class="dept-badge"><%= emp.getDepartment() %></span>
                    </div>
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
                    <div class="info-label"><i class="bi bi-currency-rupee"></i> Salary</div>
                    <div class="info-value" style="color:var(--success);">₹<%= String.format("%,.0f", emp.getSalary()) %> / mo</div>
                </div>
                <div class="info-row">
                    <div class="info-label"><i class="bi bi-calendar3"></i> Joined</div>
                    <div class="info-value"><%= emp.getJoiningDate() %></div>
                </div>

                <div style="display:flex;gap:12px;margin-top:22px;">
                    <a href="<%= request.getContextPath() %>/admin/updateEmployee?id=<%= emp.getEmployeeId() %>"
                       class="btn-main">
                        <i class="bi bi-pencil"></i> Edit
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/employeeList"
                       class="btn-outline-secondary">
                        <i class="bi bi-arrow-left"></i> Back
                    </a>
                </div>
            </div>

            <!-- Right: Photo Upload -->
            <div class="page-card">
                <div class="card-section-title">
                    <i class="bi bi-camera-fill" style="color:var(--primary);"></i> Profile Photo
                </div>
                <form action="<%= request.getContextPath() %>/admin/uploadPhoto"
                      method="post" enctype="multipart/form-data">
                    <input type="hidden" name="empId" value="<%= emp.getEmployeeId() %>">
                    <div style="margin-bottom:14px;">
                        <label class="form-label">Choose Photo</label>
                        <input type="file" name="photo" class="form-control"
                               accept="image/jpeg,image/png,image/jpg" required>
                        <div class="form-hint">JPG or PNG · max 2 MB</div>
                    </div>
                    <button type="submit" class="btn-main" style="width:100%;justify-content:center;">
                        <i class="bi bi-upload"></i> Upload Photo
                    </button>
                </form>
            </div>
        </div>

        <!-- Payslip History -->
        <div class="page-card">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
                <div class="card-section-title" style="margin:0;padding:0;border:none;">
                    <i class="bi bi-receipt" style="color:var(--warning);"></i> Payslip History
                </div>
                <a href="<%= request.getContextPath() %>/admin/generatePayslip"
                   class="btn-main" style="padding:7px 14px;font-size:12.5px;">
                    <i class="bi bi-plus-lg"></i> Generate New
                </a>
            </div>

            <c:choose>
                <c:when test="${empty payslips}">
                    <div class="empty-state">
                        <i class="bi bi-receipt"></i>
                        <p>No payslips generated yet</p>
                        <small>Generate a payslip for this employee to see it here.</small>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="ems-table">
                            <thead>
                            <tr>
                                <th>Period</th>
                                <th>Basic Salary</th>
                                <th>Net Salary</th>
                                <th>Generated On</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="slip" items="${payslips}">
                            <tr>
                                <td>
                                    <span class="month-badge">${slip.monthName} ${slip.year}</span>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${slip.basicSalary}" type="currency"
                                        currencySymbol="₹" maxFractionDigits="0"/>
                                </td>
                                <td style="font-weight:700;color:var(--success);">
                                    <fmt:formatNumber value="${slip.netSalary}" type="currency"
                                        currencySymbol="₹" maxFractionDigits="0"/>
                                </td>
                                <td style="color:var(--text-muted);font-size:12.5px;">${slip.generatedDate}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/sendEmail?payslipId=${slip.payslipId}&empId=${slip.employeeId}"
                                       class="action-btn email" title="Send Email"
                                       onclick="return confirm('Send payslip email to employee?')">
                                        <i class="bi bi-envelope"></i>
                                    </a>
                                </td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

</body>
</html>
