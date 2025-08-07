using System;

namespace EmployeService
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated
            if (Session["UserName"] != null)
            {
                // Redirect authenticated users to Dashboard
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                // Redirect non-authenticated users to Login
                Response.Redirect("Login.aspx");
            }
        }
    }
} 