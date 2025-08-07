using System;
using System.Web.UI;

namespace EmployeService
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set user information if available in session
                if (Session["UserName"] != null)
                {
                    userName.InnerText = Session["UserName"].ToString();
                }
                else
                {
                    userName.InnerText = "Welcome";
                }

                if (Session["UserRole"] != null)
                {
                    userRole.InnerText = Session["UserRole"].ToString();
                }
                else
                {
                    userRole.InnerText = "User";
                }
            }
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