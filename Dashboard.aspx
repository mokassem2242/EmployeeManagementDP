<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="EmployeService.Dashboard" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Dashboard - UAE Government Employee Management</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #F5F5F5;
                min-height: 100vh;
            }

            .header {
                background: white;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                padding: 20px 0;
                border-bottom: 2px solid #2E8B57;
            }

            .header-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo h1 {
                color: #2E8B57;
                font-size: 24px;
                font-weight: 600;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .user-details {
                text-align: right;
            }

            .user-name {
                color: #333;
                font-weight: 600;
                font-size: 16px;
            }

            .user-role {
                color: #666;
                font-size: 14px;
            }

            .btn-logout {
                background: #2E8B57;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-logout:hover {
                background: #1F5F3F;
            }

            .main-content {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
            }

            .welcome-card {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 30px;
                text-align: center;
                border-left: 4px solid #2E8B57;
            }

            .welcome-title {
                color: #2E8B57;
                font-size: 28px;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .welcome-subtitle {
                color: #666;
                font-size: 16px;
                margin-bottom: 20px;
            }

            .login-time {
                background: #F8F9FA;
                border: 1px solid #E9ECEF;
                border-radius: 4px;
                padding: 12px;
                margin-top: 15px;
                color: #495057;
                font-size: 14px;
            }

            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                margin-top: 30px;
            }

            .feature-card {
                background: white;
                border-radius: 6px;
                padding: 25px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                transition: box-shadow 0.2s ease;
                border: 1px solid #E9ECEF;
            }

            .feature-card:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .feature-icon {
                width: 50px;
                height: 50px;
                background: #2E8B57;
                border-radius: 6px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 15px;
                color: white;
                font-size: 20px;
                font-weight: normal;
            }

            .feature-title {
                color: #2E8B57;
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .feature-description {
                color: #495057;
                font-size: 14px;
                line-height: 1.5;
            }

            .feature-link {
                background: #2E8B57;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease;
                text-decoration: none;
                display: inline-block;
                margin-top: 15px;
            }

            .feature-link:hover {
                background: #1F5F3F;
                text-decoration: none;
                color: white;
            }

            @media (max-width: 768px) {
                .header-content {
                    flex-direction: column;
                    gap: 15px;
                }

                .user-info {
                    flex-direction: column;
                    gap: 10px;
                }

                .user-details {
                    text-align: center;
                }

                .welcome-title {
                    font-size: 24px;
                }

                .welcome-subtitle {
                    font-size: 14px;
                }

                .features-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="header">
                <div class="header-content">
                    <div class="logo">
                        <h1>UAE Government Employee Management</h1>
                    </div>
                    <div class="user-info">
                        <div class="user-details">
                            <div class="user-name" id="userName" runat="server"></div>
                            <div class="user-role" id="userRole" runat="server"></div>
                        </div>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn-logout" OnClick="btnLogout_Click"
                            Text="Logout"></asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="main-content">
                <div class="welcome-card">
                    <h2 class="welcome-title">Welcome to Employee Management System</h2>
                    <p class="welcome-subtitle">Manage your employee data efficiently and securely</p>

                    <div class="login-time" id="loginTime" runat="server">
                        <!-- Login time will be populated by code-behind -->
                    </div>
                </div>

                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="feature-title">Employee Management</h3>
                        <p class="feature-description">
                            Add, edit, and manage employee information including personal details,
                            department assignments, and position updates.
                        </p>
                        <a href="AdminEmployeeManagement.aspx" class="feature-link">
                            Manage Employees
                        </a>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3 class="feature-title">My Profile</h3>
                        <p class="feature-description">
                            View your personal employee information, contact details, and employment status.
                        </p>
                        <a href="EmployeeView.aspx" class="feature-link">
                            View My Profile
                        </a>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-building"></i>
                        </div>
                        <h3 class="feature-title">Department Management</h3>
                        <p class="feature-description">
                            Organize employees by departments and manage department information
                            with hierarchical structures.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <h3 class="feature-title">Position Management</h3>
                        <p class="feature-description">
                            Define and manage job positions, titles, and responsibilities
                            within the organization.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h3 class="feature-title">Secure Authentication</h3>
                        <p class="feature-description">
                            Role-based access control with secure login and user management
                            for government compliance.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h3 class="feature-title">Reporting & Analytics</h3>
                        <p class="feature-description">
                            Generate comprehensive reports and analytics for employee data,
                            department performance, and organizational insights.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-cog"></i>
                        </div>
                        <h3 class="feature-title">System Administration</h3>
                        <p class="feature-description">
                            Administrative tools for user management, system configuration,
                            and data maintenance.
                        </p>
                    </div>
                </div>
            </div>
        </form>
    </body>

    </html>