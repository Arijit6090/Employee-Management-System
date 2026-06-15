<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Access Denied — EMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
            background: #f1f5f9;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .card {
            background: #fff;
            border-radius: 20px;
            padding: 52px 44px;
            text-align: center;
            box-shadow: 0 8px 40px rgba(0,0,0,0.10);
            max-width: 440px;
            width: 100%;
        }

        .icon-wrap {
            width: 80px; height: 80px;
            background: #fee2e2;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 24px;
        }

        .icon-wrap i { font-size: 2.4rem; color: #ef4444; }

        h3 {
            font-size: 22px; font-weight: 800;
            color: #0f172a;
            margin-bottom: 10px;
        }

        p {
            font-size: 14px; color: #64748b;
            line-height: 1.6;
            margin-bottom: 28px;
        }

        a {
            display: inline-flex; align-items: center; gap: 8px;
            background: #6366f1; color: #fff;
            border-radius: 10px;
            padding: 11px 28px;
            font-size: 14px; font-weight: 700;
            text-decoration: none;
            transition: all 0.2s;
        }

        a:hover { background: #4f46e5; transform: translateY(-1px); }
    </style>
</head>
<body>

<div class="card">
    <div class="icon-wrap">
        <i class="bi bi-shield-x"></i>
    </div>
    <h3>Access Denied</h3>
    <p>
        You don't have permission to view this page.<br>
        Please contact your administrator if you think this is a mistake.
    </p>
    <a href="<%= request.getContextPath() %>/login.jsp">
        <i class="bi bi-arrow-left"></i> Back to Login
    </a>
</div>

</body>
</html>
