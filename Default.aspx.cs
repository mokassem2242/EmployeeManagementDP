using System;
using System.Web.UI;

namespace EmployeService
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is already authenticated
            if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            // If not authenticated, redirect to login page
            if (!IsPostBack)
            {
                // The page will auto-redirect via JavaScript, but we can also do it server-side
                // Response.Redirect("Login.aspx");
            }
        }
    }
} 