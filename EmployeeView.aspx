<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeView.aspx.cs" Inherits="EmployeService.EmployeeView" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Employee Profile</title>
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

        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nav-link {
            color: #6C4527;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: #F2ECCF;
            color: #B68A35;
        }

        .nav-link.active {
            background: #B68A35;
            color: white;
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
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-title {
            color: #B68A35;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
        }

        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(182, 138, 53, 0.1);
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .profile-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #B68A35, #CBA344, #D7BC6D);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid #F2ECCF;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 48px;
            font-weight: bold;
        }

        .profile-name {
            color: #B68A35;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .profile-position {
            color: #92722A;
            font-size: 18px;
            margin-bottom: 5px;
        }

        .profile-department {
            color: #6C4527;
            font-size: 16px;
        }

        .profile-sections {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }

        .profile-section {
            background: #F9F7ED;
            border-radius: 15px;
            padding: 25px;
            border: 2px solid #E6D7A2;
        }

        .section-title {
            color: #B68A35;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-icon {
            font-size: 24px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #E6D7A2;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #6C4527;
            font-weight: 600;
            font-size: 14px;
        }

        .info-value {
            color: #92722A;
            font-size: 14px;
            text-align: right;
            max-width: 60%;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        .status-terminated {
            background: #fff3cd;
            color: #856404;
        }

        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }

            .profile-sections {
                grid-template-columns: 1fr;
            }

            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .info-value {
                text-align: left;
                max-width: 100%;
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
                <div class="nav-links">
                    <a href="Dashboard.aspx" class="nav-link">Dashboard</a>
                    <a href="EmployeeView.aspx" class="nav-link active">My Profile</a>
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn-logout" OnClick="btnLogout_Click"
                        Text="Logout"></asp:LinkButton>
                </div>
            </div>
        </div>

        <div class="main-content">
            <h1 class="page-title">My Employee Profile</h1>

            <!-- Alert Messages -->
            <asp:Panel ID="alertPanel" runat="server" Visible="false" CssClass="alert">
                <asp:Label ID="alertMessage" runat="server"></asp:Label>
            </asp:Panel>

            <div class="profile-card">
                <div class="profile-header">
                    <div class="profile-avatar">
                        <asp:Literal ID="litAvatar" runat="server"></asp:Literal>
                    </div>
                    <h2 class="profile-name">
                        <asp:Literal ID="litFullName" runat="server"></asp:Literal>
                    </h2>
                    <p class="profile-position">
                        <asp:Literal ID="litPosition" runat="server"></asp:Literal>
                    </p>
                    <p class="profile-department">
                        <asp:Literal ID="litDepartment" runat="server"></asp:Literal>
                    </p>
                </div>

                <div class="profile-sections">
                    <!-- Personal Information -->
                    <div class="profile-section">
                        <h3 class="section-title">
                            <span class="section-icon">👤</span>
                            Personal Information
                        </h3>
                        <div class="info-row">
                            <span class="info-label">Emirates ID:</span>
                            <span class="info-value">
                                <asp:Literal ID="litEmiratesId" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Passport Number:</span>
                            <span class="info-value">
                                <asp:Literal ID="litPassportNumber" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Nationality:</span>
                            <span class="info-value">
                                <asp:Literal ID="litNationality" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Date of Birth:</span>
                            <span class="info-value">
                                <asp:Literal ID="litDateOfBirth" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Gender:</span>
                            <span class="info-value">
                                <asp:Literal ID="litGender" runat="server"></asp:Literal>
                            </span>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <div class="profile-section">
                        <h3 class="section-title">
                            <span class="section-icon">📧</span>
                            Contact Information
                        </h3>
                        <div class="info-row">
                            <span class="info-label">Work Email:</span>
                            <span class="info-value">
                                <asp:Literal ID="litWorkEmail" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Personal Email:</span>
                            <span class="info-value">
                                <asp:Literal ID="litPersonalEmail" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Work Phone:</span>
                            <span class="info-value">
                                <asp:Literal ID="litWorkPhone" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Personal Phone:</span>
                            <span class="info-value">
                                <asp:Literal ID="litPersonalPhone" runat="server"></asp:Literal>
                            </span>
                        </div>
                    </div>

                    <!-- Address Information -->
                    <div class="profile-section">
                        <h3 class="section-title">
                            <span class="section-icon">📍</span>
                            Address Information
                        </h3>
                        <div class="info-row">
                            <span class="info-label">Emirates:</span>
                            <span class="info-value">
                                <asp:Literal ID="litEmirates" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">City:</span>
                            <span class="info-value">
                                <asp:Literal ID="litCity" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">District:</span>
                            <span class="info-value">
                                <asp:Literal ID="litDistrict" runat="server"></asp:Literal>
                            </span>
                        </div>
                    </div>

                    <!-- Employment Information -->
                    <div class="profile-section">
                        <h3 class="section-title">
                            <span class="section-icon">💼</span>
                            Employment Information
                        </h3>
                        <div class="info-row">
                            <span class="info-label">Hire Date:</span>
                            <span class="info-value">
                                <asp:Literal ID="litHireDate" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Contract Type:</span>
                            <span class="info-value">
                                <asp:Literal ID="litContractType" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Employment Status:</span>
                            <span class="info-value">
                                <asp:Literal ID="litEmploymentStatus" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Salary Grade:</span>
                            <span class="info-value">
                                <asp:Literal ID="litSalaryGrade" runat="server"></asp:Literal>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Manager:</span>
                            <span class="info-value">
                                <asp:Literal ID="litManager" runat="server"></asp:Literal>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>