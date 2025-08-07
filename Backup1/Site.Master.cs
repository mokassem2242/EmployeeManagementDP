using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EmployeService
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is authenticated
                if (Session["UserName"] == null)
                {
                    // Redirect to login if not authenticated
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Set user information
                userName.InnerText = Session["UserName"].ToString();
                userRole.InnerText = Session["UserRole"]?.ToString() ?? "User";

                // Set active navigation item
                SetActiveNavigationItem();

                // Show/hide navigation items based on user role
                ConfigureNavigationByRole();
            }
        }

        private void SetActiveNavigationItem()
        {
            string currentPage = Request.Url.Segments[Request.Url.Segments.Length - 1];
            
            // Remove .aspx extension for comparison
            currentPage = currentPage.Replace(".aspx", "");

            // Set active class based on current page
            switch (currentPage.ToLower())
            {
                case "dashboard":
                    navDashboard.Attributes["class"] = "nav-item active";
                    break;
                case "adminemployeemanagement":
                    navEmployeeManagement.Attributes["class"] = "nav-item active";
                    break;
                case "employeeview":
                    navEmployeeView.Attributes["class"] = "nav-item active";
                    break;
                case "register":
                    navRegister.Attributes["class"] = "nav-item active";
                    break;
                case "login":
                    navLogin.Attributes["class"] = "nav-item active";
                    break;
                case "authservice":
                    navAuthService.Attributes["class"] = "nav-item active";
                    break;
                case "employeeservice":
                    navEmployeeService.Attributes["class"] = "nav-item active";
                    break;
                case "departmentservice":
                    navDepartmentService.Attributes["class"] = "nav-item active";
                    break;
                case "positionservice":
                    navPositionService.Attributes["class"] = "nav-item active";
                    break;
            }
        }

        private void ConfigureNavigationByRole()
        {
            string userRole = Session["UserRole"]?.ToString() ?? "";

            // Hide admin-only features for non-admin users
            if (userRole.ToLower() != "admin")
            {
                // Hide admin-only navigation items
                navRegister.Visible = false;
                navEmployeeManagement.Visible = false;
            }

            // Hide login link for authenticated users
            navLogin.Visible = false;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            Session.Abandon();
            
            // Redirect to login page
            Response.Redirect("Login.aspx");
        }
    }
} 