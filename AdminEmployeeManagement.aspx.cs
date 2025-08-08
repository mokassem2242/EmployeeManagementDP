using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;
using EmployeService.DataAccess;
using EmployeService.Models;
using EmployeService.Services;

namespace EmployeService
{
    public partial class AdminEmployeeManagement : System.Web.UI.Page
    {
        private readonly EmployeeDAL _employeeDAL;
        private readonly DepartmentDAL _departmentDAL;
        private readonly PositionDAL _positionDAL;

        public AdminEmployeeManagement()
        {
            _employeeDAL = new EmployeeDAL();
            _departmentDAL = new DepartmentDAL();
            _positionDAL = new PositionDAL();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated and is admin
            if (Session["IsAuthenticated"] == null || !(bool)Session["IsAuthenticated"])
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Check if user has admin role
            if (Session["RoleName"] == null || Session["RoleName"].ToString() != "Admin")
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadInitialData();
            }
        }

        private void LoadInitialData()
        {
            try
            {
                // Load departments for search dropdown
                DataTable departments = _departmentDAL.GetAllDepartments();
                ddlDepartment.DataSource = departments;
                ddlDepartment.DataTextField = "DepartmentName";
                ddlDepartment.DataValueField = "DepartmentID";
                ddlDepartment.DataBind();

                // Load departments for modal
                ddlDepartmentModal.DataSource = departments;
                ddlDepartmentModal.DataTextField = "DepartmentName";
                ddlDepartmentModal.DataValueField = "DepartmentID";
                ddlDepartmentModal.DataBind();

                // Load positions for modal
                DataTable positions = _positionDAL.GetAllPositions();
                ddlPositionModal.DataSource = positions;
                ddlPositionModal.DataTextField = "PositionTitle";
                ddlPositionModal.DataValueField = "PositionID";
                ddlPositionModal.DataBind();

                // Load managers for modal
                DataTable managers = _employeeDAL.GetAllEmployees();
                ddlManager.DataSource = managers;
                ddlManager.DataTextField = "FullName";
                ddlManager.DataValueField = "EmployeeID";
                ddlManager.DataBind();

                // Load all employees
                LoadEmployees();
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading data: " + ex.Message, "danger");
            }
        }

        private void LoadEmployees()
        {
            try
            {
                DataTable employees = _employeeDAL.GetAllEmployees();
                gvEmployees.DataSource = employees;
                gvEmployees.DataBind();
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading employees: " + ex.Message, "danger");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string searchTerm = txtSearch.Text.Trim();
                int? departmentId = null;
                if (int.TryParse(ddlDepartment.SelectedValue, out int parsedDeptId))
                {
                    departmentId = parsedDeptId;
                }
                string status = ddlStatus.SelectedValue;

                // Log search parameters for debugging
                System.Diagnostics.Debug.WriteLine($"Search Term: '{searchTerm}'");
                System.Diagnostics.Debug.WriteLine($"Department ID: {ddlDepartment.SelectedValue}");
                System.Diagnostics.Debug.WriteLine($"Status: '{status}'");

                if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue))
                {
                    departmentId = Convert.ToInt32(ddlDepartment.SelectedValue);
                }

                // Call the search method with conditional logic
                // If searchTerm is provided, it overrides department and status filters
                // If searchTerm is null, both department and status filters are applied together
                DataTable employees = _employeeDAL.SearchEmployees(searchTerm, departmentId, status);
                
                // Log results for debugging
                System.Diagnostics.Debug.WriteLine($"Search returned {employees.Rows.Count} results");

                gvEmployees.DataSource = employees;
                gvEmployees.DataBind();

                if (employees.Rows.Count == 0)
                {
                    ShowAlert("No employees found matching your search criteria.", "info");
                }
                else
                {
                    ShowAlert($"Found {employees.Rows.Count} employee(s) matching your search criteria.", "success");
                }
                
                // Update the UpdatePanels
                UpdatePanel1.Update();
                UpdatePanel2.Update();
            }
            catch (Exception ex)
            {
                ShowAlert("Error searching employees: " + ex.Message, "danger");
                System.Diagnostics.Debug.WriteLine($"Search error: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
            }
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear form
                ClearForm();
                modalTitle.Text = "Add New Employee";
                hdnEmployeeId.Value = "";
                
                // Set default values
                ddlEmploymentStatus.SelectedValue = "Active";
                txtHireDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                
                // Show modal
                ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showModal();", true);
                
                // Update the UpdatePanels
                UpdatePanel1.Update();
                UpdatePanel2.Update();
                UpdatePanel3.Update();
            }
            catch (Exception ex)
            {
                ShowAlert("Error preparing form: " + ex.Message, "danger");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate required fields
                if (string.IsNullOrEmpty(txtEmiratesId.Text.Trim()))
                {
                    ShowAlert("Emirates ID is required.", "danger");
                    return;
                }

                if (string.IsNullOrEmpty(txtFirstName.Text.Trim()))
                {
                    ShowAlert("First Name is required.", "danger");
                    return;
                }

                if (string.IsNullOrEmpty(txtLastName.Text.Trim()))
                {
                    ShowAlert("Last Name is required.", "danger");
                    return;
                }

                if (string.IsNullOrEmpty(ddlDepartmentModal.SelectedValue))
                {
                    ShowAlert("Department is required.", "danger");
                    return;
                }

                if (string.IsNullOrEmpty(ddlPositionModal.SelectedValue))
                {
                    ShowAlert("Position is required.", "danger");
                    return;
                }

                // Get current user ID for audit
                int currentUserId = Convert.ToInt32(Session["UserID"]);

                if (string.IsNullOrEmpty(hdnEmployeeId.Value))
                {
                    // Insert new employee
                    var employee = new Employee
                    {
                        EmiratesID = txtEmiratesId.Text.Trim(),
                        PassportNumber = txtPassportNumber.Text.Trim(),
                        FirstName = txtFirstName.Text.Trim(),
                        LastName = txtLastName.Text.Trim(),
                        Nationality = txtNationality.Text.Trim(),
                        DateOfBirth = !string.IsNullOrEmpty(txtDateOfBirth.Text) ? Convert.ToDateTime(txtDateOfBirth.Text) : (DateTime?)null,
                        Gender = ddlGender.SelectedValue,
                        WorkEmail = txtWorkEmail.Text.Trim(),
                        PersonalEmail = txtPersonalEmail.Text.Trim(),
                        WorkPhone = txtWorkPhone.Text.Trim(),
                        PersonalPhone = txtPersonalPhone.Text.Trim(),
                        Emirates = txtEmirates.Text.Trim(),
                        City = txtCity.Text.Trim(),
                        District = txtDistrict.Text.Trim(),
                        HireDate = !string.IsNullOrEmpty(txtHireDate.Text) ? Convert.ToDateTime(txtHireDate.Text) : (DateTime?)null,
                        ContractType = ddlContractType.SelectedValue,
                        EmploymentStatus = ddlEmploymentStatus.SelectedValue,
                        DepartmentID = Convert.ToInt32(ddlDepartmentModal.SelectedValue),
                        PositionID = Convert.ToInt32(ddlPositionModal.SelectedValue),
                        ManagerID = !string.IsNullOrEmpty(ddlManager.SelectedValue) ? Convert.ToInt32(ddlManager.SelectedValue) : (int?)null,
                        SalaryGrade = txtSalaryGrade.Text.Trim(),
                        CreatedBy = currentUserId
                    };

                    int employeeId = _employeeDAL.InsertEmployee(employee);
                    ShowAlert("Employee added successfully!", "success");
                }
                else
                {
                    // Update existing employee
                    var employee = new Employee
                    {
                        EmployeeID = Convert.ToInt32(hdnEmployeeId.Value),
                        EmiratesID = txtEmiratesId.Text.Trim(),
                        PassportNumber = txtPassportNumber.Text.Trim(),
                        FirstName = txtFirstName.Text.Trim(),
                        LastName = txtLastName.Text.Trim(),
                        Nationality = txtNationality.Text.Trim(),
                        DateOfBirth = !string.IsNullOrEmpty(txtDateOfBirth.Text) ? Convert.ToDateTime(txtDateOfBirth.Text) : (DateTime?)null,
                        Gender = ddlGender.SelectedValue,
                        WorkEmail = txtWorkEmail.Text.Trim(),
                        PersonalEmail = txtPersonalEmail.Text.Trim(),
                        WorkPhone = txtWorkPhone.Text.Trim(),
                        PersonalPhone = txtPersonalPhone.Text.Trim(),
                        Emirates = txtEmirates.Text.Trim(),
                        City = txtCity.Text.Trim(),
                        District = txtDistrict.Text.Trim(),
                        HireDate = !string.IsNullOrEmpty(txtHireDate.Text) ? Convert.ToDateTime(txtHireDate.Text) : (DateTime?)null,
                        ContractType = ddlContractType.SelectedValue,
                        EmploymentStatus = ddlEmploymentStatus.SelectedValue,
                        DepartmentID = Convert.ToInt32(ddlDepartmentModal.SelectedValue),
                        PositionID = Convert.ToInt32(ddlPositionModal.SelectedValue),
                        ManagerID = !string.IsNullOrEmpty(ddlManager.SelectedValue) ? Convert.ToInt32(ddlManager.SelectedValue) : (int?)null,
                        SalaryGrade = txtSalaryGrade.Text.Trim(),
                        ModifiedBy = currentUserId
                    };

                    bool success = _employeeDAL.UpdateEmployee(employee);
                    if (success)
                    {
                        ShowAlert("Employee updated successfully!", "success");
                    }
                    else
                    {
                        ShowAlert("Error updating employee.", "danger");
                    }
                }

                // Close modal and reload data
                ScriptManager.RegisterStartupScript(this, GetType(), "closeModal", "closeModal();", true);
                LoadEmployees();
                
                // Update the UpdatePanels
                UpdatePanel1.Update();
                UpdatePanel2.Update();
                UpdatePanel3.Update();
            }
            catch (Exception ex)
            {
                ShowAlert("Error saving employee: " + ex.Message, "danger");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "closeModal", "closeModal();", true);
            
            // Update the UpdatePanels
            UpdatePanel1.Update();
            UpdatePanel2.Update();
            UpdatePanel3.Update();
        }

        protected void gvEmployees_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int employeeId = Convert.ToInt32(e.CommandArgument);

                switch (e.CommandName)
                {
                    case "ViewEmployee":
                        ViewEmployee(employeeId);
                        break;
                    case "EditEmployee":
                        EditEmployee(employeeId);
                        break;
                    case "DeleteEmployee":
                        DeleteEmployee(employeeId);
                        break;
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error processing command: " + ex.Message, "danger");
            }
        }

        private void ViewEmployee(int employeeId)
        {
            try
            {
                DataTable employeeData = _employeeDAL.GetEmployeeById(employeeId);
                if (employeeData.Rows.Count > 0)
                {
                    DataRow row = employeeData.Rows[0];
                    
                    // Populate form for view-only mode
                    PopulateForm(row);
                    
                    // Disable all form controls
                    DisableFormControls();
                    
                    modalTitle.Text = "View Employee Details";
                    btnSave.Visible = false;
                    btnCancel.Text = "Close";
                    
                    ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showModal();", true);
                    
                    // Update the UpdatePanels
                    UpdatePanel1.Update();
                    UpdatePanel2.Update();
                    UpdatePanel3.Update();
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading employee details: " + ex.Message, "danger");
            }
        }

        private void EditEmployee(int employeeId)
        {
            try
            {
                DataTable employeeData = _employeeDAL.GetEmployeeById(employeeId);
                if (employeeData.Rows.Count > 0)
                {
                    DataRow row = employeeData.Rows[0];
                    
                    // Populate form
                    PopulateForm(row);
                    
                    // Enable all form controls
                    EnableFormControls();
                    
                    modalTitle.Text = "Edit Employee";
                    hdnEmployeeId.Value = employeeId.ToString();
                    btnSave.Visible = true;
                    btnCancel.Text = "Cancel";
                    
                    ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showModal();", true);
                    
                    // Update the UpdatePanels
                    UpdatePanel1.Update();
                    UpdatePanel2.Update();
                    UpdatePanel3.Update();
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading employee for editing: " + ex.Message, "danger");
            }
        }

        private void DeleteEmployee(int employeeId)
        {
            try
            {
                bool success = _employeeDAL.DeleteEmployee(employeeId);
                if (success)
                {
                    ShowAlert("Employee deleted successfully!", "success");
                    LoadEmployees();
                    
                    // Update the UpdatePanels
                    UpdatePanel1.Update();
                    UpdatePanel2.Update();
                }
                else
                {
                    ShowAlert("Error deleting employee.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error deleting employee: " + ex.Message, "danger");
            }
        }

        private void PopulateForm(DataRow row)
        {
            txtEmiratesId.Text = row["EmiratesID"].ToString();
            txtPassportNumber.Text = row["PassportNumber"].ToString();
            txtFirstName.Text = row["FirstName"].ToString();
            txtLastName.Text = row["LastName"].ToString();
            txtNationality.Text = row["Nationality"].ToString();
            
            if (row["DateOfBirth"] != DBNull.Value)
            {
                txtDateOfBirth.Text = Convert.ToDateTime(row["DateOfBirth"]).ToString("yyyy-MM-dd");
            }
            
            ddlGender.SelectedValue = row["Gender"].ToString();
            txtWorkEmail.Text = row["WorkEmail"].ToString();
            txtPersonalEmail.Text = row["PersonalEmail"].ToString();
            txtWorkPhone.Text = row["WorkPhone"].ToString();
            txtPersonalPhone.Text = row["PersonalPhone"].ToString();
            txtEmirates.Text = row["Emirates"].ToString();
            txtCity.Text = row["City"].ToString();
            txtDistrict.Text = row["District"].ToString();
            
            if (row["HireDate"] != DBNull.Value)
            {
                txtHireDate.Text = Convert.ToDateTime(row["HireDate"]).ToString("yyyy-MM-dd");
            }
            
            ddlContractType.SelectedValue = row["ContractType"].ToString();
            ddlEmploymentStatus.SelectedValue = row["EmploymentStatus"].ToString();
            txtSalaryGrade.Text = row["SalaryGrade"].ToString();
            
            if (row["DepartmentID"] != DBNull.Value)
            {
                ddlDepartmentModal.SelectedValue = row["DepartmentID"].ToString();
            }
            
            if (row["PositionID"] != DBNull.Value)
            {
                ddlPositionModal.SelectedValue = row["PositionID"].ToString();
            }
            
            if (row["ManagerID"] != DBNull.Value)
            {
                ddlManager.SelectedValue = row["ManagerID"].ToString();
            }
        }

        private void ClearForm()
        {
            txtEmiratesId.Text = "";
            txtPassportNumber.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtNationality.Text = "";
            txtDateOfBirth.Text = "";
            ddlGender.SelectedIndex = 0;
            txtWorkEmail.Text = "";
            txtPersonalEmail.Text = "";
            txtWorkPhone.Text = "";
            txtPersonalPhone.Text = "";
            txtEmirates.Text = "";
            txtCity.Text = "";
            txtDistrict.Text = "";
            txtHireDate.Text = "";
            ddlContractType.SelectedIndex = 0;
            ddlEmploymentStatus.SelectedValue = "Active";
            txtSalaryGrade.Text = "";
            ddlDepartmentModal.SelectedIndex = 0;
            ddlPositionModal.SelectedIndex = 0;
            ddlManager.SelectedIndex = 0;
        }

        private void DisableFormControls()
        {
            txtEmiratesId.Enabled = false;
            txtPassportNumber.Enabled = false;
            txtFirstName.Enabled = false;
            txtLastName.Enabled = false;
            txtNationality.Enabled = false;
            txtDateOfBirth.Enabled = false;
            ddlGender.Enabled = false;
            txtWorkEmail.Enabled = false;
            txtPersonalEmail.Enabled = false;
            txtWorkPhone.Enabled = false;
            txtPersonalPhone.Enabled = false;
            txtEmirates.Enabled = false;
            txtCity.Enabled = false;
            txtDistrict.Enabled = false;
            txtHireDate.Enabled = false;
            ddlContractType.Enabled = false;
            ddlEmploymentStatus.Enabled = false;
            txtSalaryGrade.Enabled = false;
            ddlDepartmentModal.Enabled = false;
            ddlPositionModal.Enabled = false;
            ddlManager.Enabled = false;
        }

        private void EnableFormControls()
        {
            txtEmiratesId.Enabled = true;
            txtPassportNumber.Enabled = true;
            txtFirstName.Enabled = true;
            txtLastName.Enabled = true;
            txtNationality.Enabled = true;
            txtDateOfBirth.Enabled = true;
            ddlGender.Enabled = true;
            txtWorkEmail.Enabled = true;
            txtPersonalEmail.Enabled = true;
            txtWorkPhone.Enabled = true;
            txtPersonalPhone.Enabled = true;
            txtEmirates.Enabled = true;
            txtCity.Enabled = true;
            txtDistrict.Enabled = true;
            txtHireDate.Enabled = true;
            ddlContractType.Enabled = true;
            ddlEmploymentStatus.Enabled = true;
            txtSalaryGrade.Enabled = true;
            ddlDepartmentModal.Enabled = true;
            ddlPositionModal.Enabled = true;
            ddlManager.Enabled = true;
        }

        protected void gvEmployees_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Show/hide export selected button based on whether any rows are selected
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
                if (chkSelect != null)
                {
                    chkSelect.Attributes.Add("onclick", "updateExportSelectedButton();");
                }
            }
        }

        protected void gvEmployees_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvEmployees.PageIndex = e.NewPageIndex;
            LoadEmployees();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        private void ShowAlert(string message, string type)
        {
            if (alertPanel != null)
            {
                alertPanel.Visible = true;
                alertMessage.Text = message;
                alertPanel.CssClass = "alert alert-" + type;
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            try
            {
                string searchTerm = txtSearch.Text.Trim();
                
                // Only search if there's a search term or if the field is cleared
                if (!string.IsNullOrEmpty(searchTerm) || string.IsNullOrEmpty(txtSearch.Text))
                {
                    // Get current filter values
                    int? departmentId = null;
                    string status = ddlStatus.SelectedValue;

                    if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue))
                    {
                        departmentId = Convert.ToInt32(ddlDepartment.SelectedValue);
                    }

                    // Perform search
                    DataTable employees = _employeeDAL.SearchEmployees(searchTerm, departmentId, status);
                    gvEmployees.DataSource = employees;
                    gvEmployees.DataBind();

                    if (employees.Rows.Count == 0 && !string.IsNullOrEmpty(searchTerm))
                    {
                        ShowAlert("No employees found matching your search criteria.", "info");
                    }
                    else if (employees.Rows.Count > 0)
                    {
                        ShowAlert($"Found {employees.Rows.Count} employee(s) matching your search criteria.", "success");
                    }
                }
                
                // Update the UpdatePanels
                UpdatePanel1.Update();
                UpdatePanel2.Update();
            }
            catch (Exception ex)
            {
                ShowAlert("Error during search: " + ex.Message, "danger");
            }
        }

        protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                // Get current search term and status
                string searchTerm = txtSearch.Text.Trim();
                string status = ddlStatus.SelectedValue;
                int? departmentId = null;

                if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue))
                {
                    departmentId = Convert.ToInt32(ddlDepartment.SelectedValue);
                }

                // Use the search method to combine all filters
                DataTable employees = _employeeDAL.SearchEmployees(searchTerm, departmentId, status);
                gvEmployees.DataSource = employees;
                gvEmployees.DataBind();

                if (employees.Rows.Count == 0)
                {
                    ShowAlert("No employees found matching your filter criteria.", "info");
                }
                else
                {
                    ShowAlert($"Found {employees.Rows.Count} employee(s) matching your filter criteria.", "success");
                }
                
                // Update the UpdatePanels
                UpdatePanel1.Update();
                UpdatePanel2.Update();
            }
            catch (Exception ex)
            {
                ShowAlert("Error filtering by department: " + ex.Message, "danger");
            }
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                // Get current search term and department
                string searchTerm = txtSearch.Text.Trim();
                string status = ddlStatus.SelectedValue;
                int? departmentId = null;

                if (!string.IsNullOrEmpty(ddlDepartment.SelectedValue))
                {
                    departmentId = Convert.ToInt32(ddlDepartment.SelectedValue);
                }

                // Use the search method to combine all filters
                DataTable employees = _employeeDAL.SearchEmployees(searchTerm, departmentId, status);
                gvEmployees.DataSource = employees;
                gvEmployees.DataBind();

                if (employees.Rows.Count == 0)
                {
                    ShowAlert("No employees found matching your filter criteria.", "info");
                }
                else
                {
                    ShowAlert($"Found {employees.Rows.Count} employee(s) matching your filter criteria.", "success");
                }
                
                // Update the UpdatePanels
                UpdatePanel1.Update();
                UpdatePanel2.Update();
            }
            catch (Exception ex)
            {
                ShowAlert("Error filtering by status: " + ex.Message, "danger");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear search fields
                txtSearch.Text = "";
                ddlDepartment.SelectedIndex = 0;
                ddlStatus.SelectedIndex = 0;
                
                // Reload all employees
                LoadEmployees();
                
                // Update the UpdatePanels
                UpdatePanel1.Update();
                UpdatePanel2.Update();
                
                ShowAlert("Search criteria cleared.", "info");
            }
            catch (Exception ex)
            {
                ShowAlert("Error clearing search: " + ex.Message, "danger");
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate export format
                if (string.IsNullOrEmpty(ddlExportFormat.SelectedValue))
                {
                    ShowAlert("Please select an export format.", "warning");
                    return;
                }

                // Get export parameters
                ExportService.ExportFormat format = (ExportService.ExportFormat)Enum.Parse(typeof(ExportService.ExportFormat), ddlExportFormat.SelectedValue);
                ExportService.ExportScope scope = (ExportService.ExportScope)Enum.Parse(typeof(ExportService.ExportScope), ddlExportScope.SelectedValue);

                // Get data based on scope
                DataTable employees = GetEmployeesForExport(scope);

                if (employees.Rows.Count == 0)
                {
                    ShowAlert("No employees found to export.", "warning");
                    return;
                }

                // Create export service and export
                ExportService exportService = new ExportService();
                string fileName = string.Format("EmployeeExport_{0:yyyyMMdd_HHmmss}", DateTime.Now);
                exportService.ExportEmployees(employees, format, scope, fileName);

                ShowAlert(string.Format("Export completed successfully. {0} employees exported.", employees.Rows.Count), "success");
            }
            catch (Exception ex)
            {
                ShowAlert("Error during export: " + ex.Message, "danger");
            }
        }

        protected void btnExportSelected_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate export format
                if (string.IsNullOrEmpty(ddlExportFormat.SelectedValue))
                {
                    ShowAlert("Please select an export format.", "warning");
                    return;
                }

                // Get selected employee IDs
                List<int> selectedEmployeeIds = GetSelectedEmployeeIds();

                if (selectedEmployeeIds.Count == 0)
                {
                    ShowAlert("Please select at least one employee to export.", "warning");
                    return;
                }

                // Get data for selected employees
                DataTable employees = _employeeDAL.GetEmployeesByIds(selectedEmployeeIds);

                if (employees.Rows.Count == 0)
                {
                    ShowAlert("No employees found to export.", "warning");
                    return;
                }

                // Create export service and export
                ExportService exportService = new ExportService();
                ExportService.ExportFormat format = (ExportService.ExportFormat)Enum.Parse(typeof(ExportService.ExportFormat), ddlExportFormat.SelectedValue);
                string fileName = string.Format("SelectedEmployees_{0:yyyyMMdd_HHmmss}", DateTime.Now);
                exportService.ExportEmployees(employees, format, ExportService.ExportScope.Selected, fileName);

                ShowAlert(string.Format("Export completed successfully. {0} selected employees exported.", employees.Rows.Count), "success");
            }
            catch (Exception ex)
            {
                ShowAlert("Error during export: " + ex.Message, "danger");
            }
        }

        private DataTable GetEmployeesForExport(ExportService.ExportScope scope)
        {
            switch (scope)
            {
                case ExportService.ExportScope.All:
                    return _employeeDAL.GetAllEmployees();
                
                case ExportService.ExportScope.CurrentPage:
                    // For current page, we need to get the current page data
                    // This is a simplified implementation - in a real scenario, you might want to store the current data
                    return _employeeDAL.GetAllEmployees();
                
                case ExportService.ExportScope.SearchResults:
                    // Get employees based on current search criteria
                    return GetEmployeesBySearchCriteria();
                
                default:
                    return _employeeDAL.GetAllEmployees();
            }
        }

        private DataTable GetEmployeesBySearchCriteria()
        {
            string searchTerm = txtSearch.Text.Trim();
            string departmentId = ddlDepartment.SelectedValue;
            string status = ddlStatus.SelectedValue;

            // Build search criteria
            if (!string.IsNullOrEmpty(searchTerm) || !string.IsNullOrEmpty(status))
            {
                int? deptId = null;
                if (!string.IsNullOrEmpty(departmentId))
                {
                    deptId = int.Parse(departmentId);
                }
                return _employeeDAL.SearchEmployees(searchTerm, deptId, status);
            }
            else
            {
                return _employeeDAL.GetAllEmployees();
            }
        }

        private List<int> GetSelectedEmployeeIds()
        {
            List<int> selectedIds = new List<int>();

            foreach (GridViewRow row in gvEmployees.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    int employeeId = Convert.ToInt32(gvEmployees.DataKeys[row.RowIndex].Value);
                    selectedIds.Add(employeeId);
                }
            }

            return selectedIds;
        }




    }
} 