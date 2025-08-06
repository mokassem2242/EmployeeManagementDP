using System;

namespace EmployeService
{
    public partial class TestPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblResult.Text = "Page loaded successfully";
            }
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {
            lblResult.Text = "Button clicked at: " + DateTime.Now.ToString();
        }
    }
} 