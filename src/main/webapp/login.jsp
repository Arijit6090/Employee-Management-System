<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — WorkHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
            min-height: 100vh;
            display: flex;
            background: #f1f5f9;
        }

        /* Left decorative panel */
        .login-panel-left {
            width: 45%;
            background: linear-gradient(145deg, #0f172a 0%, #1e1b4b 50%, #312e81 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px 44px;
            position: relative;
            overflow: hidden;
        }

        .login-panel-left::before {
            content: '';
            position: absolute;
            width: 400px; height: 400px;
            background: rgba(99,102,241,0.18);
            border-radius: 50%;
            top: -100px; right: -100px;
        }

        .login-panel-left::after {
            content: '';
            position: absolute;
            width: 280px; height: 280px;
            background: rgba(99,102,241,0.12);
            border-radius: 50%;
            bottom: -80px; left: -60px;
        }

        .brand-logo-wrap {
            width: 72px; height: 72px;
            background: rgba(255,255,255,0.1);
            border-radius: 20px;
            display: flex; align-items: center; justify-content: center;
            font-size: 30px; color: #fff;
            margin-bottom: 24px;
            position: relative; z-index: 1;
            border: 1px solid rgba(255,255,255,0.12);
        }

        .login-panel-left h2 {
            font-size: 26px; font-weight: 800;
            color: #fff; text-align: center;
            position: relative; z-index: 1;
            margin-bottom: 8px;
        }

        .login-panel-left p {
            font-size: 13px; color: rgba(255,255,255,0.55);
            text-align: center;
            position: relative; z-index: 1;
            line-height: 1.7;
        }

        .feature-list {
            margin-top: 36px;
            list-style: none;
            position: relative; z-index: 1;
            width: 100%;
        }

        .feature-list li {
            display: flex; align-items: center; gap: 12px;
            padding: 10px 0;
            color: rgba(255,255,255,0.65);
            font-size: 13px;
            border-bottom: 1px solid rgba(255,255,255,0.07);
        }

        .feature-list li:last-child { border-bottom: none; }
        .feature-list li i { font-size: 16px; color: #818cf8; flex-shrink: 0; }

        /* Right form panel */
        .login-panel-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 48px 40px;
        }

        .login-form-box {
            width: 100%;
            max-width: 400px;
        }

        .login-form-box h3 {
            font-size: 24px; font-weight: 800;
            color: #0f172a;
            margin-bottom: 4px;
        }

        .login-form-box .sub {
            font-size: 13px; color: #64748b;
            margin-bottom: 32px;
        }

        .form-group { margin-bottom: 20px; }

        .form-label {
            display: block;
            font-size: 12.5px; font-weight: 600;
            color: #475569;
            margin-bottom: 7px;
        }

        .input-wrap {
            position: relative;
        }

        .input-wrap i {
            position: absolute; left: 14px; top: 50%;
            transform: translateY(-50%);
            color: #94a3b8; font-size: 16px;
            pointer-events: none;
        }

        .form-control {
            width: 100%;
            padding: 11px 14px 11px 42px;
            border: 1.5px solid #e2e8f0;
            border-radius: 9px;
            font-size: 14px;
            color: #0f172a;
            background: #fff;
            outline: none;
            font-family: inherit;
            transition: all 0.2s;
        }

        .form-control:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.12);
        }

        .form-control::placeholder { color: #94a3b8; }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: #6366f1;
            color: #fff;
            border: none;
            border-radius: 9px;
            font-size: 14px; font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            font-family: inherit;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            margin-top: 8px;
        }

        .btn-login:hover { background: #4f46e5; transform: translateY(-1px); box-shadow: 0 4px 16px rgba(99,102,241,0.35); }

        .alert-danger {
            display: flex; align-items: center; gap: 10px;
            padding: 12px 14px;
            background: #fee2e2; color: #991b1b;
            border: 1px solid #fca5a5;
            border-radius: 9px;
            font-size: 13px; font-weight: 500;
            margin-bottom: 20px;
        }

        @media (max-width: 700px) {
            .login-panel-left { display: none; }
            .login-panel-right { padding: 32px 20px; }
        }
    </style>
</head>
<body>

<div class="login-panel-left">
    <div class="brand-logo-wrap">
        <i class="bi bi-people-fill"></i>
    </div>
    <h2>WorkHub</h2>
    <p>Employee Management System<br>The Heritage Academy</p>
    <ul class="feature-list">
        <li><i class="bi bi-shield-check"></i> Secure role-based access</li>
        <li><i class="bi bi-receipt"></i> Automated payslip generation</li>
        <li><i class="bi bi-people"></i> Complete employee directory</li>
        <li><i class="bi bi-envelope"></i> Email payslip delivery</li>
    </ul>
</div>

<div class="login-panel-right">
    <div class="login-form-box">
        <h3>Welcome back 👋</h3>
        <p class="sub">Sign in to your account to continue</p>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="alert-danger">
            <i class="bi bi-exclamation-circle"></i> <%= error %>
        </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="form-group">
                <label class="form-label">Username</label>
                <div class="input-wrap">
                    <i class="bi bi-person"></i>
                    <input type="text" name="username" class="form-control"
                           placeholder="Enter your username" required autocomplete="off">
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Password</label>
                <div class="input-wrap">
                    <i class="bi bi-lock"></i>
                    <input type="password" name="password" class="form-control"
                           placeholder="Enter your password" required>
                </div>
            </div>
            <button type="submit" class="btn-login">
                <i class="bi bi-box-arrow-in-right"></i> Sign In
            </button>
        </form>
    </div>
</div>

</body>
</html>
