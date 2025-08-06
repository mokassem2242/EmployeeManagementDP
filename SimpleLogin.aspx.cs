using System;

namespace EmployeService
{
    public partial class SimpleLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "Page loaded at: " + DateTime.Now.ToString();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "Button clicked at: " + DateTime.Now.ToString() + 
                             " - Username: " + txtUsername.Text + 
                             " - Password: " + txtPassword.Text;
        }
    }
} 