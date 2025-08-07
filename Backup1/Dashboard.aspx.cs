using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace EmployeService
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is authenticated
            if (Session["IsAuthenticated"] == null || !(bool)Session["IsAuthenticated"])
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserInformation();
            }
        }

        private void LoadUserInformation()
        {
            try
            {
                // Display user information
                if (Session["Username"] != null)
                {
                    userName.InnerText = "Welcome, " + Session["Username"].ToString();
                }

                if (Session["RoleName"] != null)
                {
                    userRole.InnerText = "Role: " + Session["RoleName"].ToString();
                }

                // Display login time
                if (Session["LoginTime"] != null)
                {
                    DateTime loginDateTime = (DateTime)Session["LoginTime"];
                    loginTime.InnerText = "Login Time: " + loginDateTime.ToString("MMMM dd, yyyy 'at' hh:mm tt");
                }
            }
            catch (Exception ex)
            {
                // Log error (in a real application, you'd want to log this properly)
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            
            // Redirect to login page
            Response.Redirect("Login.aspx");
        }
    }
} 