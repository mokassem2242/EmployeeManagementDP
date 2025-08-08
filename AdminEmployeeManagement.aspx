<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminEmployeeManagement.aspx.cs"
    Inherits="EmployeService.AdminEmployeeManagement" MasterPageFile="~/Site.Master" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <title>Employee Management - Admin Panel</title>
        <script type="text/javascript">
            function showModal() {
                var modal = document.getElementById('<%= employeeModal.ClientID %>');
                if (modal) {
                    modal.style.display = 'block';
                    modal.classList.add('show');
                }
            }

            function closeModal() {
                var modal = document.getElementById('<%= employeeModal.ClientID %>');
                if (modal) {
                    modal.style.display = 'none';
                    modal.classList.remove('show');
                }
            }

            // Close modal when clicking outside of it
            window.onclick = function (event) {
                var modal = document.getElementById('<%= employeeModal.ClientID %>');
                if (event.target == modal) {
                    closeModal();
                }
            }

            function updateExportSelectedButton() {
                var checkboxes = document.querySelectorAll('input[type="checkbox"][id*="chkSelect"]');
                var selectedCount = 0;

                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].checked) {
                        selectedCount++;
                    }
                }

                var exportSelectedBtn = document.getElementById('<%= btnExportSelected.ClientID %>');
                if (exportSelectedBtn) {
                    exportSelectedBtn.style.display = selectedCount > 0 ? 'inline-block' : 'none';
                }
            }

            // Search functionality improvements
            function clearSearch() {
                var searchBox = document.getElementById('<%= txtSearch.ClientID %>');
                if (searchBox) {
                    searchBox.value = '';
                }

                var departmentDropdown = document.getElementById('<%= ddlDepartment.ClientID %>');
                if (departmentDropdown) {
                    departmentDropdown.selectedIndex = 0;
                }

                var statusDropdown = document.getElementById('<%= ddlStatus.ClientID %>');
                if (statusDropdown) {
                    statusDropdown.selectedIndex = 0;
                }
            }

            // Add search tips
            function showSearchTips() {
                var searchBox = document.getElementById('<%= txtSearch.ClientID %>');
                if (searchBox && searchBox.value === '') {
                    searchBox.placeholder = 'Enter employee name, ID, or email...';
                }
            }

            // Initialize search tips on page load
            window.onload = function () {
                showSearchTips();
            };
        </script>
        <style>
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }

            .modal.show {
                display: block;
            }

            .modal-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 0;
                border: 1px solid #888;
                width: 80%;
                max-width: 800px;
                border-radius: 5px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                padding: 15px 20px;
                background-color: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
                border-radius: 5px 5px 0 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .modal-body {
                padding: 20px;
                max-height: 70vh;
                overflow-y: auto;
            }

            .modal-footer {
                padding: 15px 20px;
                background-color: #f8f9fa;
                border-top: 1px solid #dee2e6;
                border-radius: 0 0 5px 5px;
                text-align: right;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
            }

            /* Search improvements */
            .search-section {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                border: 1px solid #dee2e6;
            }

            .search-form {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                align-items: end;
            }

            .form-group {
                flex: 1;
                min-width: 200px;
            }

            .form-actions {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            /* Search results styling */
            .search-results-info {
                background: #e7f3ff;
                border: 1px solid #b3d9ff;
                border-radius: 4px;
                padding: 10px;
                margin-bottom: 15px;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
            }

            .form-section {
                margin-bottom: 30px;
            }

            .form-section h4 {
                color: #333;
                border-bottom: 2px solid #007bff;
                padding-bottom: 5px;
                margin-bottom: 20px;
            }

            .form-row {
                display: flex;
                gap: 15px;
                margin-bottom: 15px;
            }

            .form-group {
                flex: 1;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
                color: #333;
            }

            .form-control {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            .form-control:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
            }

            .export-section {
                margin-top: 20px;
                padding: 15px;
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 5px;
            }

            .export-section h4 {
                color: #495057;
                margin-bottom: 15px;
                font-size: 16px;
            }

            .export-controls {
                display: flex;
                gap: 15px;
                align-items: end;
                flex-wrap: wrap;
            }

            .export-controls .form-group {
                flex: 1;
                min-width: 200px;
            }

            .export-controls .form-actions {
                display: flex;
                gap: 10px;
                flex-shrink: 0;
            }

            .btn-info {
                background-color: #17a2b8;
                border-color: #17a2b8;
            }

            .btn-info:hover {
                background-color: #138496;
                border-color: #117a8b;
            }

            .btn-warning {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #212529;
            }

            .btn-warning:hover {
                background-color: #e0a800;
                border-color: #d39e00;
                color: #212529;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="breadcrumb">
            <a href="Dashboard.aspx"><i class="fas fa-home"></i> Home</a>
            <i class="fas fa-chevron-right"></i>
            <span>Employee Management</span>
        </div>

        <div class="page-header">
            <h1 class="page-title">Employee Management</h1>
            <p class="page-subtitle">Manage employee information and data</p>
        </div>

        <div class="content-area">
            <!-- Alert Panel -->
            <asp:Panel ID="alertPanel" runat="server" CssClass="alert" Visible="false">
                <asp:Label ID="alertMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Employee Management Content -->
            <div class="employee-management-section">
                <div class="section-header">
                    <h2>Employee Operations</h2>
                    <p>Add, edit, and manage employee records</p>
                </div>

                <!-- Search and Filter Section -->
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="search-section">
                            <div class="search-form">
                                <div class="form-group">
                                    <label for="txtSearch">Search Employees:</label>
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                        placeholder="Enter employee name, ID, or email..." AutoPostBack="true"
                                        OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                                    <small class="form-text text-muted">Search by name, Emirates ID, work email, or
                                        personal email</small>
                                </div>
                                <div class="form-group">
                                    <label for="ddlDepartment">Filter by Department:</label>
                                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label for="ddlStatus">Filter by Status:</label>
                                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                                <div class="form-actions">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                        OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary"
                                        OnClick="btnClear_Click" />
                                    <asp:Button ID="btnAddNew" runat="server" Text="Add New Employee"
                                        CssClass="btn btn-success" OnClick="btnAddNew_Click" />
                                </div>

                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <!-- Export Section - Outside UpdatePanel for file downloads -->
                <div class="export-section">
                    <h4>Export Options</h4>
                    <div class="export-controls">
                        <div class="form-group">
                            <label for="ddlExportFormat">Export Format:</label>
                            <asp:DropDownList ID="ddlExportFormat" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Format" Value="" />
                                <asp:ListItem Text="PDF" Value="PDF" />
                                <asp:ListItem Text="Excel" Value="Excel" />
                                <asp:ListItem Text="CSV" Value="CSV" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="ddlExportScope">Export Scope:</label>
                            <asp:DropDownList ID="ddlExportScope" runat="server" CssClass="form-control">
                                <asp:ListItem Text="All Employees" Value="All" />
                                <asp:ListItem Text="Current Page" Value="CurrentPage" />
                                <asp:ListItem Text="Search Results" Value="SearchResults" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnExport" runat="server" Text="Export" CssClass="btn btn-info"
                                OnClick="btnExport_Click" />
                            <asp:Button ID="btnExportSelected" runat="server" Text="Export Selected"
                                CssClass="btn btn-warning" OnClick="btnExportSelected_Click" Visible="false" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </ContentTemplate>
        </asp:UpdatePanel>

        <!-- Employee Grid -->
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="employee-grid-section">
                    <asp:GridView ID="gvEmployees" runat="server" CssClass="employee-grid" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnRowCommand="gvEmployees_RowCommand"
                        OnPageIndexChanging="gvEmployees_PageIndexChanging" DataKeyNames="EmployeeID">
                        <Columns>
                            <asp:TemplateField HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="EmployeeID" HeaderText="ID" />
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                            <asp:BoundField DataField="WorkEmail" HeaderText="Work Email" />
                            <asp:BoundField DataField="WorkPhone" HeaderText="Work Phone" />
                            <asp:BoundField DataField="EmiratesID" HeaderText="Emirates ID" />
                            <asp:BoundField DataField="EmploymentStatus" HeaderText="Status" />
                            <asp:BoundField DataField="HireDate" HeaderText="Hire Date"
                                DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditEmployee"
                                        CommandArgument='<%# Eval("EmployeeID") %>' CssClass="btn btn-sm btn-primary">
                                        <i class="fas fa-edit"></i> Edit
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteEmployee"
                                        CommandArgument='<%# Eval("EmployeeID") %>' CssClass="btn btn-sm btn-danger"
                                        OnClientClick="return confirm('Are you sure you want to delete this employee?');">
                                        <i class="fas fa-trash"></i> Delete
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pager-style" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>

        <!-- Employee Form Modal -->
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <div class="modal" id="employeeModal" runat="server">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3>
                                <asp:Label ID="modalTitle" runat="server" Text="Add New Employee"></asp:Label>
                            </h3>
                            <span class="close" onclick="closeModal()">&times;</span>
                        </div>
                        <div class="modal-body">
                            <asp:HiddenField ID="hdnEmployeeId" runat="server" />

                            <!-- Personal Information -->
                            <div class="form-section">
                                <h4>Personal Information</h4>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtEmiratesId">Emirates ID:</label>
                                        <asp:TextBox ID="txtEmiratesId" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtPassportNumber">Passport Number:</label>
                                        <asp:TextBox ID="txtPassportNumber" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtFirstName">First Name:</label>
                                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtLastName">Last Name:</label>
                                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtNationality">Nationality:</label>
                                        <asp:TextBox ID="txtNationality" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtDateOfBirth">Date of Birth:</label>
                                        <asp:TextBox ID="txtDateOfBirth" runat="server" CssClass="form-control"
                                            TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="ddlGender">Gender:</label>
                                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Select Gender" Value="" />
                                            <asp:ListItem Text="Male" Value="Male" />
                                            <asp:ListItem Text="Female" Value="Female" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <!-- Contact Information -->
                            <div class="form-section">
                                <h4>Contact Information</h4>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtWorkEmail">Work Email:</label>
                                        <asp:TextBox ID="txtWorkEmail" runat="server" CssClass="form-control"
                                            TextMode="Email"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtPersonalEmail">Personal Email:</label>
                                        <asp:TextBox ID="txtPersonalEmail" runat="server" CssClass="form-control"
                                            TextMode="Email"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtWorkPhone">Work Phone:</label>
                                        <asp:TextBox ID="txtWorkPhone" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtPersonalPhone">Personal Phone:</label>
                                        <asp:TextBox ID="txtPersonalPhone" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!-- Address Information -->
                            <div class="form-section">
                                <h4>Address Information</h4>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtEmirates">Emirates:</label>
                                        <asp:TextBox ID="txtEmirates" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtCity">City:</label>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtDistrict">District:</label>
                                        <asp:TextBox ID="txtDistrict" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!-- Employment Information -->
                            <div class="form-section">
                                <h4>Employment Information</h4>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="txtHireDate">Hire Date:</label>
                                        <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control"
                                            TextMode="Date"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <label for="ddlContractType">Contract Type:</label>
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
                                        <label for="ddlEmploymentStatus">Employment Status:</label>
                                        <asp:DropDownList ID="ddlEmploymentStatus" runat="server"
                                            CssClass="form-control">
                                            <asp:ListItem Text="Active" Value="Active" />
                                            <asp:ListItem Text="Inactive" Value="Inactive" />
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label for="txtSalaryGrade">Salary Grade:</label>
                                        <asp:TextBox ID="txtSalaryGrade" runat="server" CssClass="form-control">
                                        </asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="ddlDepartmentModal">Department:</label>
                                        <asp:DropDownList ID="ddlDepartmentModal" runat="server"
                                            CssClass="form-control"></asp:DropDownList>
                                    </div>
                                    <div class="form-group">
                                        <label for="ddlPositionModal">Position:</label>
                                        <asp:DropDownList ID="ddlPositionModal" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="ddlManager">Manager:</label>
                                        <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Select Manager" Value="" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary"
                                OnClick="btnSave_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary"
                                OnClick="btnCancel_Click" />
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
    </asp:Content>