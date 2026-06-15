<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>My Payslips — WorkHub</title>
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
        <a href="<%= request.getContextPath() %>/employee/profile">
            <i class="bi bi-person-circle"></i> My Profile
        </a>
        <a href="<%= request.getContextPath() %>/employee/viewPayslip" class="active">
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
        <div class="topbar-title">My Payslips</div>
        <div style="display:flex;align-items:center;gap:10px;">
            <div class="avatar" style="background:#10b981;"><%= username.substring(0,1).toUpperCase() %></div>
            <div class="avatar-info">
                <div class="av-name"><%= username %></div>
                <div class="av-role">Employee</div>
            </div>
        </div>
    </div>

    <div class="content">
        <div class="page-card">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
                <div class="card-section-title" style="margin:0;padding:0;border:none;">
                    <i class="bi bi-receipt" style="color:var(--success);"></i>
                    Payslip History
                </div>
                <div style="font-size:12.5px;color:var(--text-muted);">
                    Download your salary slips below
                </div>
            </div>

            <c:choose>
                <c:when test="${empty payslips}">
                    <div class="empty-state">
                        <i class="bi bi-receipt" style="color:var(--success);"></i>
                        <p>No payslips available yet</p>
                        <small>Your administrator hasn't generated any payslips. Please contact them.</small>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="ems-table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Pay Period</th>
                                <th>Basic Salary</th>
                                <th>Net Salary</th>
                                <th>Generated On</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="slip" items="${payslips}" varStatus="st">
                                <tr>
                                    <td style="color:var(--text-muted);font-size:12px;">${st.count}</td>
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
                                        <a href="${pageContext.request.contextPath}/employee/downloadPayslip?id=${slip.payslipId}"
                                           class="action-btn dl" title="Download PDF">
                                            <i class="bi bi-download"></i>
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
