<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="EmployeService.Dashboard" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Dashboard - UAE Government Employee Management</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #F9F7ED 0%, #F2ECCF 100%);
                min-height: 100vh;
            }

            .header {
                background: white;
                box-shadow: 0 2px 10px rgba(182, 138, 53, 0.1);
                padding: 20px 0;
                border-bottom: 4px solid #B68A35;
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
                color: #B68A35;
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
                color: #6C4527;
                font-weight: 600;
                font-size: 16px;
            }

            .user-role {
                color: #92722A;
                font-size: 14px;
            }

            .btn-logout {
                background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-logout:hover {
                background: linear-gradient(135deg, #92722A 0%, #B68A35 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(182, 138, 53, 0.3);
            }

            .main-content {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
            }

            .welcome-card {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(182, 138, 53, 0.1);
                padding: 40px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .welcome-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #B68A35, #CBA344, #D7BC6D);
            }

            .welcome-title {
                color: #B68A35;
                font-size: 32px;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .welcome-subtitle {
                color: #92722A;
                font-size: 18px;
                margin-bottom: 30px;
            }

            .login-time {
                background: #F9F7ED;
                border: 1px solid #E6D7A2;
                border-radius: 10px;
                padding: 15px;
                margin-top: 20px;
                color: #6C4527;
                font-size: 14px;
            }

            .features-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 30px;
                margin-top: 40px;
            }

            .feature-card {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 10px 30px rgba(182, 138, 53, 0.1);
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(182, 138, 53, 0.2);
                border-color: #E6D7A2;
            }

            .feature-icon {
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                color: white;
                font-size: 24px;
                font-weight: bold;
            }

            .feature-title {
                color: #B68A35;
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .feature-description {
                color: #6C4527;
                font-size: 14px;
                line-height: 1.6;
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
                    font-size: 16px;
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
                        <h1>UAE Government</h1>
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
                        <div class="feature-icon">👥</div>
                        <h3 class="feature-title">Employee Management</h3>
                        <p class="feature-description">
                            Add, edit, and manage employee information including personal details,
                            department assignments, and position updates.
                        </p>
                        <div style="margin-top: 15px;">
                            <a href="AdminEmployeeManagement.aspx" class="btn-logout"
                                style="text-decoration: none; display: inline-block; margin-top: 10px;">
                                Manage Employees
                            </a>
                        </div>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">👤</div>
                        <h3 class="feature-title">My Profile</h3>
                        <p class="feature-description">
                            View your personal employee information, contact details, and employment status.
                        </p>
                        <div style="margin-top: 15px;">
                            <a href="EmployeeView.aspx" class="btn-logout"
                                style="text-decoration: none; display: inline-block; margin-top: 10px;">
                                View My Profile
                            </a>
                        </div>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">🏢</div>
                        <h3 class="feature-title">Department Management</h3>
                        <p class="feature-description">
                            Organize employees by departments and manage department information
                            with hierarchical structures.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">💼</div>
                        <h3 class="feature-title">Position Management</h3>
                        <p class="feature-description">
                            Define and manage job positions, titles, and responsibilities
                            within the organization.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">🔐</div>
                        <h3 class="feature-title">Secure Authentication</h3>
                        <p class="feature-description">
                            Role-based access control with secure login and user management
                            for government compliance.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">📊</div>
                        <h3 class="feature-title">Reporting & Analytics</h3>
                        <p class="feature-description">
                            Generate comprehensive reports and analytics for employee data,
                            department performance, and organizational insights.
                        </p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">⚙️</div>
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