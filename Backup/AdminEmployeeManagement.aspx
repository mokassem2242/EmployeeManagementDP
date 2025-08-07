<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminEmployeeManagement.aspx.cs"
    Inherits="EmployeService.AdminEmployeeManagement" MasterPageFile="~/Site.Master" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <title>Employee Management - Admin Panel</title>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
            <!-- Employee Management Content -->
            <div class="employee-management-section">
                <div class="section-header">
                    <h2>Employee Operations</h2>
                    <p>Add, edit, and manage employee records</p>
                </div>

                <!-- Search and Filter Section -->
                <div class="search-section">
                    <div class="search-form">
                        <div class="form-group">
                            <label for="txtSearch">Search Employees:</label>
                            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                                placeholder="Enter employee name, ID, or email..."></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="ddlDepartment">Filter by Department:</label>
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control">
                                <asp:ListItem Text="All Departments" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="ddlPosition">Filter by Position:</label>
                            <asp:DropDownList ID="ddlPosition" runat="server" CssClass="form-control">
                                <asp:ListItem Text="All Positions" Value="" />
                            </asp:DropDownList>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary"
                                OnClick="btnSearch_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary"
                                OnClick="btnClear_Click" />
                            <asp:Button ID="btnAddNew" runat="server" Text="Add New Employee" CssClass="btn btn-success"
                                OnClick="btnAddNew_Click" />
                        </div>
                    </div>
                </div>

                <!-- Employee Grid -->
                <div class="employee-grid-section">
                    <asp:GridView ID="gvEmployees" runat="server" CssClass="employee-grid" AutoGenerateColumns="False"
                        AllowPaging="True" PageSize="10" OnRowCommand="gvEmployees_RowCommand"
                        OnPageIndexChanging="gvEmployees_PageIndexChanging" DataKeyNames="EmployeeID">
                        <Columns>
                            <asp:BoundField DataField="EmployeeID" HeaderText="ID" />
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Phone" HeaderText="Phone" />
                            <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                            <asp:BoundField DataField="PositionName" HeaderText="Position" />
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
            </div>

            <!-- Employee Form Modal -->
            <div class="modal" id="employeeModal" runat="server" visible="false">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 id="modalTitle" runat="server">Add New Employee</h3>
                        <span class="close" onclick="closeModal()">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtFirstName">First Name:</label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"
                                    required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtLastName">Last Name:</label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"
                                    required="required"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtEmail">Email:</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"
                                    required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtPhone">Phone:</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" required="required">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="ddlDepartmentModal">Department:</label>
                                <asp:DropDownList ID="ddlDepartmentModal" runat="server" CssClass="form-control"
                                    required="required"></asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label for="ddlPositionModal">Position:</label>
                                <asp:DropDownList ID="ddlPositionModal" runat="server" CssClass="form-control"
                                    required="required"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtHireDate">Hire Date:</label>
                                <asp:TextBox ID="txtHireDate" runat="server" CssClass="form-control" TextMode="Date"
                                    required="required"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtSalary">Salary:</label>
                                <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" TextMode="Number"
                                    Step="0.01"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtAddress">Address:</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"
                                Rows="3"></asp:TextBox>
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
        </div>
    </asp:Content>