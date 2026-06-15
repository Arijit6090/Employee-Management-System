<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

    String successMsg = (String) session.getAttribute("successMsg");
    if (successMsg != null) session.removeAttribute("successMsg");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Employees — EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin.css">
    <style>
        .search-bar {
            display: flex; align-items: center; gap: 8px;
            background: var(--body-bg);
            border: 1.5px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 0 12px;
        }
        .search-bar input {
            border: none; background: transparent; outline: none;
            font-size: 13.5px; color: var(--text-primary); padding: 10px 0;
            width: 220px; font-family: inherit;
        }
        .search-bar i { color: var(--text-muted); }
        .search-btn {
            background: var(--primary); color: #fff; border: none;
            border-radius: 7px; padding: 8px 12px; cursor: pointer;
            font-size: 14px; transition: all 0.2s;
        }
        .search-btn:hover { background: var(--primary-dark); }
        .clear-btn {
            display: inline-flex; align-items: center; justify-content: center;
            width: 36px; height: 36px;
            border: 1.5px solid var(--border); border-radius: 8px;
            color: var(--text-muted); text-decoration: none; font-size: 15px;
            transition: all 0.2s;
        }
        .clear-btn:hover { border-color: var(--danger); color: var(--danger); }
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
        <div class="topbar-title">All Employees</div>
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

        <div class="page-card">
            <!-- Toolbar -->
            <div style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px;margin-bottom:18px;">
                <div style="font-size:13.5px;color:var(--text-muted);">
                    Showing <strong style="color:var(--text-primary);">${total}</strong> employee(s)
                    <c:if test="${not empty search}">
                        matching <strong>"${search}"</strong>
                    </c:if>
                </div>
                <div style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;">
                    <form method="get" action="${pageContext.request.contextPath}/admin/employeeList"
                          style="display:flex;gap:8px;align-items:center;">
                        <div class="search-bar">
                            <i class="bi bi-search"></i>
                            <input type="text" name="search"
                                   placeholder="Search name, dept, ID…" value="${search}">
                        </div>
                        <input type="hidden" name="sortBy" value="${sortBy}">
                        <input type="hidden" name="order"  value="${order}">
                        <button type="submit" class="search-btn"><i class="bi bi-search"></i></button>
                        <c:if test="${not empty search}">
                            <a href="${pageContext.request.contextPath}/admin/employeeList" class="clear-btn"
                               title="Clear search"><i class="bi bi-x-lg"></i></a>
                        </c:if>
                    </form>
                    <a href="${pageContext.request.contextPath}/admin/addEmployee" class="btn-main">
                        <i class="bi bi-person-plus"></i> Add Employee
                    </a>
                </div>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table class="ems-table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>
                            <a class="sort-link" href="?sortBy=name&order=${sortBy == 'name' && order == 'asc' ? 'desc' : 'asc'}&page=1&search=${search}">
                                Name
                                <c:choose>
                                    <c:when test="${sortBy == 'name' && order == 'asc'}"><i class="bi bi-arrow-up"></i></c:when>
                                    <c:when test="${sortBy == 'name' && order == 'desc'}"><i class="bi bi-arrow-down"></i></c:when>
                                    <c:otherwise><i class="bi bi-arrow-down-up" style="opacity:0.3;"></i></c:otherwise>
                                </c:choose>
                            </a>
                        </th>
                        <th>
                            <a class="sort-link" href="?sortBy=department&order=${sortBy == 'department' && order == 'asc' ? 'desc' : 'asc'}&page=1&search=${search}">
                                Department
                                <c:choose>
                                    <c:when test="${sortBy == 'department' && order == 'asc'}"><i class="bi bi-arrow-up"></i></c:when>
                                    <c:when test="${sortBy == 'department' && order == 'desc'}"><i class="bi bi-arrow-down"></i></c:when>
                                    <c:otherwise><i class="bi bi-arrow-down-up" style="opacity:0.3;"></i></c:otherwise>
                                </c:choose>
                            </a>
                        </th>
                        <th>Designation</th>
                        <th>
                            <a class="sort-link" href="?sortBy=salary&order=${sortBy == 'salary' && order == 'asc' ? 'desc' : 'asc'}&page=1&search=${search}">
                                Salary
                                <c:choose>
                                    <c:when test="${sortBy == 'salary' && order == 'asc'}"><i class="bi bi-arrow-up"></i></c:when>
                                    <c:when test="${sortBy == 'salary' && order == 'desc'}"><i class="bi bi-arrow-down"></i></c:when>
                                    <c:otherwise><i class="bi bi-arrow-down-up" style="opacity:0.3;"></i></c:otherwise>
                                </c:choose>
                            </a>
                        </th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty employees}">
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">
                                        <i class="bi bi-inbox"></i>
                                        <p>No employees found</p>
                                        <small>Try adjusting your search or add a new employee.</small>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="emp" items="${employees}" varStatus="status">
                            <tr>
                                <td style="color:var(--text-muted);font-size:12px;">
                                    ${(currentPage - 1) * 10 + status.count}
                                </td>
                                <td>
                                    <div class="emp-cell">
                                        <div class="emp-init">${emp.name.substring(0,1).toUpperCase()}</div>
                                        <div>
                                            <div class="emp-cell-name">${emp.name}</div>
                                            <div class="emp-cell-id">#${emp.employeeId}</div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="dept-badge">${emp.department}</span></td>
                                <td style="color:var(--text-secondary);">${emp.designation}</td>
                                <td style="font-weight:600;">
                                    <fmt:formatNumber value="${emp.salary}" type="currency"
                                        currencySymbol="₹" maxFractionDigits="0"/>
                                </td>
                                <td>
                                    <div style="display:flex;gap:6px;">
                                        <a href="${pageContext.request.contextPath}/admin/viewEmployee?id=${emp.employeeId}"
                                           class="action-btn view" title="View Details">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/updateEmployee?id=${emp.employeeId}"
                                           class="action-btn edit" title="Edit">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/deleteEmployee?id=${emp.employeeId}"
                                           class="action-btn del" title="Delete"
                                           onclick="return confirm('Delete ${emp.name}? This cannot be undone.')">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-top:20px;flex-wrap:wrap;gap:12px;">
                <div style="font-size:12.5px;color:var(--text-muted);">
                    Page <strong>${currentPage}</strong> of <strong>${totalPages}</strong>
                </div>
                <nav>
                    <ul class="pagination">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage - 1}&search=${search}&sortBy=${sortBy}&order=${order}">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&search=${search}&sortBy=${sortBy}&order=${order}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="?page=${currentPage + 1}&search=${search}&sortBy=${sortBy}&order=${order}">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>
