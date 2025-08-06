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
                background: #f8f9fa;
                min-height: 100vh;
            }

            .header {
                background: white;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                padding: 20px 0;
                border-bottom: 2px solid #4CAF50;
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
                color: #4CAF50;
                font-size: 24px;
                font-weight: 600;
            }

            .nav-links {
                display: flex;
                gap: 20px;
                align-items: center;
            }

            .nav-link {
                color: #2E7D32;
                text-decoration: none;
                font-weight: 500;
                padding: 8px 16px;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .nav-link:hover {
                background: #E8F5E8;
                color: #4CAF50;
            }

            .nav-link.active {
                background: #4CAF50;
                color: white;
            }

            .btn-logout {
                background: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-logout:hover {
                background: #388E3C;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .main-content {
                max-width: 1400px;
                margin: 30px auto;
                padding: 0 20px;
            }

            .page-title {
                color: #4CAF50;
                font-size: 28px;
                font-weight: 600;
                margin-bottom: 30px;
                text-align: center;
            }

            .search-section {
                background: white;
                border-radius: 6px;
                padding: 25px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                border: 1px solid #e9ecef;
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
                color: #2E7D32;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .form-control {
                padding: 10px 12px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                font-size: 14px;
                transition: border-color 0.2s ease;
                background: white;
            }

            .form-control:focus {
                outline: none;
                border-color: #4CAF50;
                box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
            }

            .btn {
                padding: 10px 16px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }

            .btn-primary {
                background: #4CAF50;
                color: white;
            }

            .btn-primary:hover {
                background: #388E3C;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .btn-success {
                background: #28a745;
                color: white;
            }

            .btn-success:hover {
                background: #218838;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .btn-warning {
                background: #ffc107;
                color: #212529;
            }

            .btn-warning:hover {
                background: #e0a800;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .btn-danger {
                background: #dc3545;
                color: white;
            }

            .btn-danger:hover {
                background: #c82333;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background: #5a6268;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .employees-section {
                background: white;
                border-radius: 6px;
                padding: 25px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                border: 1px solid #e9ecef;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
            }

            .section-title {
                color: #4CAF50;
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
                background: #4CAF50;
                color: white;
                padding: 12px 10px;
                text-align: left;
                font-weight: 500;
                font-size: 14px;
            }

            .gridview td {
                padding: 10px;
                border-bottom: 1px solid #dee2e6;
                font-size: 14px;
                color: #495057;
            }

            .gridview tr:hover {
                background: #f8f9fa;
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
                border-radius: 6px;
                width: 90%;
                max-width: 800px;
                max-height: 90vh;
                overflow-y: auto;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                border: 1px solid #e9ecef;
            }

            .modal-header {
                background: #4CAF50;
                color: white;
                padding: 20px 25px;
                border-radius: 6px 6px 0 0;
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
                color: #4CAF50;
            }

            .search-loading {
                display: none;
                text-align: center;
                padding: 10px;
                color: #4CAF50;
                font-size: 12px;
            }

            .spinner {
                border: 2px solid #e9ecef;
                border-top: 2px solid #4CAF50;
                border-radius: 50%;
                width: 24px;
                height: 24px;
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
                                placeholder="Search by name, Emirates ID, or email..." AutoPostBack="true"
                                OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Department</label>
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                                <asp:ListItem Text="All Departments" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Text="All Status" Value="" />
                                <asp:ListItem Text="Active" Value="Active" />
                                <asp:ListItem Text="Inactive" Value="Inactive" />
                                <asp:ListItem Text="Terminated" Value="Terminated" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                OnClick="btnSearch_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary"
                                OnClick="btnClear_Click" Style="margin-left: 10px;" />
                            <asp:Button ID="btnTestSearch" runat="server" Text="Test Search" CssClass="btn btn-info"
                                OnClick="btnTestSearch_Click" Style="margin-left: 10px;" />
                        </div>
                    </div>
                    <div class="search-loading" id="searchLoadingDiv">
                        <div class="spinner" style="width: 16px; height: 16px; border-width: 1px;"></div>
                        <span>Searching...</span>
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
            // var searchTimeout; // Temporarily disabled

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

            // Debounced search function (temporarily disabled)
            // function debounceSearch() {
            //     console.log('debounceSearch called');
            //     clearTimeout(searchTimeout);
            //     searchTimeout = setTimeout(function () {
            //         console.log('debounceSearch timeout triggered');
            //         // Show search loading
            //         var searchLoading = document.getElementById('searchLoadingDiv');
            //         if (searchLoading) {
            //             searchLoading.style.display = 'block';
            //         }

            //         // Trigger the search using hidden button
            //         // Note: btnHiddenSearch control was removed - search functionality handled by server-side events
            //     }, 500); // 500ms delay
            // }

            function hideSearchLoading() {
                var searchLoading = document.getElementById('searchLoadingDiv');
                if (searchLoading) {
                    searchLoading.style.display = 'none';
                }
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

            // Temporarily disabled JavaScript debouncing to test AutoPostBack
            // document.addEventListener('DOMContentLoaded', function () {
            //     console.log('DOMContentLoaded event fired');
            //     var searchBox = document.getElementById('<%= txtSearch.ClientID %>');
            //     if (searchBox) {
            //         console.log('Search box found, adding input listener');
            //         searchBox.addEventListener('input', debounceSearch);
            //     } else {
            //         console.log('Search box not found');
            //     }
            // });
        </script>
    </body>

    </html>