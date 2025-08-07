<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="EmployeService.Dashboard"
    MasterPageFile="~/Site.Master" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <title>Dashboard - UAE Government Employee Management</title>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="breadcrumb">
            <a href="Dashboard.aspx"><i class="fas fa-home"></i> Home</a>
            <i class="fas fa-chevron-right"></i>
            <span>Dashboard</span>
        </div>

        <div class="page-header">
            <h1 class="page-title">Dashboard</h1>
            <p class="page-subtitle">Welcome to the Employee Management System</p>
        </div>

        <div class="content-area">
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
    </asp:Content>