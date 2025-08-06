<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminEmployeeManagement.aspx.cs"
    Inherits="EmployeService.AdminEmployeeManagement" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Employee Management - Admin Panel</title>
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
                max-width: 1400px;
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
                max-width: 1400px;
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

            .search-section {
                background: white;
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 10px 30px rgba(182, 138, 53, 0.1);
                margin-bottom: 30px;
            }

            .search-row {
                display: grid;
                grid-template-columns: 1fr 1fr 1fr auto;
                gap: 20px;
                align-items: end;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-label {
                color: #6C4527;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .form-control {
                padding: 12px 16px;
                border: 2px solid #E6D7A2;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s ease;
                background: white;
            }

            .form-control:focus {
                outline: none;
                border-color: #B68A35;
                box-shadow: 0 0 0 3px rgba(182, 138, 53, 0.1);
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }

            .btn-primary {
                background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
                color: white;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #92722A 0%, #B68A35 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(182, 138, 53, 0.3);
            }

            .btn-success {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
            }

            .btn-success:hover {
                background: linear-gradient(135deg, #218838 0%, #1ea085 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
            }

            .btn-warning {
                background: linear-gradient(135deg, #ffc107 0%, #ffca2c 100%);
                color: #212529;
            }

            .btn-warning:hover {
                background: linear-gradient(135deg, #e0a800 0%, #e6b800 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3);
            }

            .btn-danger {
                background: linear-gradient(135deg, #dc3545 0%, #e74c3c 100%);
                color: white;
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #c82333 0%, #c0392b 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
            }

            .btn-secondary {
                background: linear-gradient(135deg, #6c757d 0%, #868e96 100%);
                color: white;
            }

            .btn-secondary:hover {
                background: linear-gradient(135deg, #5a6268 0%, #6c757d 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
            }

            .employees-section {
                background: white;
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 10px 30px rgba(182, 138, 53, 0.1);
                margin-bottom: 30px;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .section-title {
                color: #B68A35;
                font-size: 20px;
                font-weight: 600;
            }

            .gridview-container {
                overflow-x: auto;
            }

            .gridview {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .gridview th {
                background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-weight: 600;
                font-size: 14px;
            }

            .gridview td {
                padding: 12px;
                border-bottom: 1px solid #E6D7A2;
                font-size: 14px;
                color: #6C4527;
            }

            .gridview tr:hover {
                background: #F9F7ED;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
            }

            .btn-sm {
                padding: 6px 12px;
                font-size: 12px;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
            }

            .modal-content {
                background: white;
                margin: 5% auto;
                padding: 0;
                border-radius: 15px;
                width: 90%;
                max-width: 800px;
                max-height: 90vh;
                overflow-y: auto;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            }

            .modal-header {
                background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
                color: white;
                padding: 20px 25px;
                border-radius: 15px 15px 0 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-title {
                font-size: 20px;
                font-weight: 600;
            }

            .close {
                color: white;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
                background: none;
                border: none;
            }

            .close:hover {
                opacity: 0.7;
            }

            .modal-body {
                padding: 25px;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-row.full {
                grid-template-columns: 1fr;
            }

            .alert {
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-weight: 500;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .alert-danger {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .alert-info {
                background: #d1ecf1;
                color: #0c5460;
                border: 1px solid #bee5eb;
            }

            .loading {
                display: none;
                text-align: center;
                padding: 20px;
                color: #B68A35;
            }

            .spinner {
                border: 3px solid #E6D7A2;
                border-top: 3px solid #B68A35;
                border-radius: 50%;
                width: 30px;
                height: 30px;
                animation: spin 1s linear infinite;
                margin: 0 auto 10px;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
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

                .search-row {
                    grid-template-columns: 1fr;
                }

                .form-row {
                    grid-template-columns: 1fr;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .modal-content {
                    width: 95%;
                    margin: 10% auto;
                }
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div class="header">
                <div class="header-content">
                    <div class="logo">
                        <h1>UAE Government</h1>
                    </div>
                    <div class="nav-links">
                        <a href="Dashboard.aspx" class="nav-link">Dashboard</a>
                        <a href="AdminEmployeeManagement.aspx" class="nav-link active">Employee Management</a>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn-logout" OnClick="btnLogout_Click"
                            Text="Logout"></asp:LinkButton>
                    </div>
                </div>
            </div>

            <div class="main-content">
                <h1 class="page-title">Employee Management</h1>

                <!-- Alert Messages -->
                <asp:Panel ID="alertPanel" runat="server" Visible="false" CssClass="alert">
                    <asp:Label ID="alertMessage" runat="server"></asp:Label>
                </asp:Panel>

                <!-- Search Section -->
                <div class="search-section">
                    <div class="search-row">
                        <div class="form-group">
                            <label class="form-label">Search Employee</label>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                placeholder="Search by name, Emirates ID, or email..."
                                OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Department</label>
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control">
                                <asp:ListItem Text="All Departments" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Text="All Status" Value="" />
                                <asp:ListItem Text="Active" Value="Active" />
                                <asp:ListItem Text="Inactive" Value="Inactive" />
                                <asp:ListItem Text="Terminated" Value="Terminated" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>

                <!-- Employees Section -->
                <div class="employees-section">
                    <div class="section-header">
                        <h2 class="section-title">Employees</h2>
                        <asp:Button ID="btnAddNew" runat="server" Text="+ Add New Employee" CssClass="btn btn-success"
                            OnClick="btnAddNew_Click" />
                    </div>

                    <div class="loading" id="loadingDiv">
                        <div class="spinner"></div>
                        <p>Loading employees...</p>
                    </div>

                    <div class="gridview-container">
                        <asp:GridView ID="gvEmployees" runat="server" CssClass="gridview" AutoGenerateColumns="false"
                            OnRowCommand="gvEmployees_RowCommand" OnRowDataBound="gvEmployees_RowDataBound"
                            AllowPaging="true" PageSize="10" OnPageIndexChanging="gvEmployees_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="EmployeeID" HeaderText="ID" />
                                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                                <asp:BoundField DataField="EmiratesID" HeaderText="Emirates ID" />
                                <asp:BoundField DataField="WorkEmail" HeaderText="Work Email" />
                                <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                                <asp:BoundField DataField="PositionTitle" HeaderText="Position" />
                                <asp:BoundField DataField="EmploymentStatus" HeaderText="Status" />
                                <asp:BoundField DataField="HireDate" HeaderText="Hire Date"
                                    DataFormatString="{0:MM/dd/yyyy}" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <div class="action-buttons">
                                            <asp:LinkButton ID="btnView" runat="server" CommandName="ViewEmployee"
                                                CommandArgument='<%# Eval("EmployeeID") %>'
                                                CssClass="btn btn-primary btn-sm" Text="View" />
                                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditEmployee"
                                                CommandArgument='<%# Eval("EmployeeID") %>'
                                                CssClass="btn btn-warning btn-sm" Text="Edit" />
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteEmployee"
                                                CommandArgument='<%# Eval("EmployeeID") %>'
                                                CssClass="btn btn-danger btn-sm" Text="Delete"
                                                OnClientClick="return confirm('Are you sure you want to delete this employee?');" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="pager" />
                        </asp:GridView>
                    </div>
                </div>
            </div>

            <!-- Employee Modal -->
            <div id="employeeModal" class="modal" runat="server">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title" id="modalTitle" runat="server">Add New Employee</h3>
                        <button type="button" class="close" onclick="closeModal()">&times;</button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hdnEmployeeId" runat="server" />

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Emirates ID *</label>
                                <asp:TextBox ID="txtEmiratesId" runat="server" CssClass="form-control"
                                    required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Passport Number</label>
                                <asp:TextBox ID="txtPassportNumber" runat="server" CssClass="form-control">
                                </asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">First Name *</label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"
                                    required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Last Name *</label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"
                                    required="required"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Nationality</label>
                                <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Date of Birth</label>
                                <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control" TextMode="Date">
                                </asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Gender</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Gender" Value="" />
                                    <asp:ListItem Text="Male" Value="Male" />
                                    <asp:ListItem Text="Female" Value="Female" />
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Hire Date</label>
                                <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control" TextMode="Date">
                                </asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Work Email</label>
                                <asp:TextBox ID="txtWorkEmail" runat="server" CssClass="form-control" TextMode="Email">
                                </asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Personal Email</label>
                                <asp:TextBox ID="txtPersonalEmail" runat="server" CssClass="form-control"
                                    TextMode="Email"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Work Phone</label>
                                <asp:TextBox ID="txtWorkPhone" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Personal Phone</label>
                                <asp:TextBox ID="txtPersonalPhone" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Emirates</label>
                                <asp:TextBox ID="txtEmirates" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">District</label>
                                <asp:TextBox ID="txtDistrict" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Contract Type</label>
                                <asp:DropDownList ID="ddlContractType" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Contract Type" Value="" />
                                    <asp:ListItem Text="Full Time" Value="Full Time" />
                                    <asp:ListItem Text="Part Time" Value="Part Time" />
                                    <asp:ListItem Text="Contract" Value="Contract" />
                                    <asp:ListItem Text="Temporary" Value="Temporary" />
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Employment Status</label>
                                <asp:DropDownList ID="ddlEmploymentStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Active" Value="Active" />
                                    <asp:ListItem Text="Inactive" Value="Inactive" />
                                    <asp:ListItem Text="Terminated" Value="Terminated" />
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Salary Grade</label>
                                <asp:TextBox ID="txtSalaryGrade" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Department *</label>
                                <asp:DropDownList ID="ddlDepartmentModal" runat="server" CssClass="form-control"
                                    required="required">
                                    <asp:ListItem Text="Select Department" Value="" />
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Position *</label>
                                <asp:DropDownList ID="ddlPositionModal" runat="server" CssClass="form-control"
                                    required="required">
                                    <asp:ListItem Text="Select Position" Value="" />
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Manager</label>
                                <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Manager" Value="" />
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-row" style="margin-top: 30px;">
                            <div class="form-group" style="display: flex; gap: 15px; justify-content: flex-end;">
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary"
                                    OnClick="btnCancel_Click" />
                                <asp:Button ID="btnSave" runat="server" Text="Save Employee" CssClass="btn btn-success"
                                    OnClick="btnSave_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <script type="text/javascript">
            function showModal() {
                document.getElementById('employeeModal').style.display = 'block';
            }

            function closeModal() {
                document.getElementById('employeeModal').style.display = 'none';
            }

            function showLoading() {
                document.getElementById('loadingDiv').style.display = 'block';
            }

            function hideLoading() {
                document.getElementById('loadingDiv').style.display = 'none';
            }

            // Close modal when clicking outside
            window.onclick = function (event) {
                var modal = document.getElementById('employeeModal');
                if (event.target == modal) {
                    closeModal();
                }
            }

            // Auto-hide alerts after 5 seconds
            setTimeout(function () {
                var alerts = document.querySelectorAll('.alert');
                alerts.forEach(function (alert) {
                    alert.style.display = 'none';
                });
            }, 5000);
        </script>
    </body>

    </html>