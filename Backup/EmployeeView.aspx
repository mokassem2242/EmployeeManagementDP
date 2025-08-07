<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeView.aspx.cs" Inherits="EmployeService.EmployeeView"
    MasterPageFile="~/Site.Master" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <title>My Employee Profile</title>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div class="breadcrumb">
            <a href="Dashboard.aspx"><i class="fas fa-home"></i> Home</a>
            <i class="fas fa-chevron-right"></i>
            <span>My Profile</span>
        </div>

        <div class="page-header">
            <h1 class="page-title">My Employee Profile</h1>
            <p class="page-subtitle">View and manage your personal information</p>
        </div>

        <div class="content-area">
            <div class="profile-container">
                <!-- Profile Header -->
                <div class="profile-header">
                    <div class="profile-avatar">
                        <i class="fas fa-user-circle"></i>
                    </div>
                    <div class="profile-info">
                        <h2 id="employeeName" runat="server">Employee Name</h2>
                        <p id="employeePosition" runat="server">Position</p>
                        <p id="employeeDepartment" runat="server">Department</p>
                    </div>
                    <div class="profile-status">
                        <span class="status-badge active">Active</span>
                    </div>
                </div>

                <!-- Profile Details -->
                <div class="profile-details">
                    <div class="detail-section">
                        <h3>Personal Information</h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Employee ID:</label>
                                <span id="employeeId" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Full Name:</label>
                                <span id="fullName" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Email:</label>
                                <span id="email" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Phone:</label>
                                <span id="phone" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Address:</label>
                                <span id="address" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Date of Birth:</label>
                                <span id="dateOfBirth" runat="server">-</span>
                            </div>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h3>Employment Information</h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Department:</label>
                                <span id="department" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Position:</label>
                                <span id="position" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Hire Date:</label>
                                <span id="hireDate" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Employment Status:</label>
                                <span id="employmentStatus" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Salary:</label>
                                <span id="salary" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Manager:</label>
                                <span id="manager" runat="server">-</span>
                            </div>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h3>Additional Information</h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Emergency Contact:</label>
                                <span id="emergencyContact" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Emergency Phone:</label>
                                <span id="emergencyPhone" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Blood Type:</label>
                                <span id="bloodType" runat="server">-</span>
                            </div>
                            <div class="detail-item">
                                <label>Nationality:</label>
                                <span id="nationality" runat="server">-</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="profile-actions">
                    <asp:Button ID="btnEditProfile" runat="server" Text="Edit Profile" CssClass="btn btn-primary"
                        OnClick="btnEditProfile_Click" />
                    <asp:Button ID="btnChangePassword" runat="server" Text="Change Password"
                        CssClass="btn btn-secondary" OnClick="btnChangePassword_Click" />
                    <asp:Button ID="btnPrintProfile" runat="server" Text="Print Profile" CssClass="btn btn-success"
                        OnClick="btnPrintProfile_Click" />
                </div>
            </div>
        </div>
    </asp:Content>