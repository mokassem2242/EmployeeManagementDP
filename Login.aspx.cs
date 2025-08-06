using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EmployeService.Services;

namespace EmployeService
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Clear any existing session
                Session.Clear();
                
                // Hide any existing messages
                errorMessage.Style["display"] = "none";
                successMessage.Style["display"] = "none";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                // Hide any existing messages
                errorMessage.Style["display"] = "none";
                successMessage.Style["display"] = "none";

                // Validate input
                if (string.IsNullOrEmpty(txtUsername.Text.Trim()))
                {
                    ShowError("Please enter your username.");
                    return;
                }

                if (string.IsNullOrEmpty(txtPassword.Text))
                {
                    ShowError("Please enter your password.");
                    return;
                }

                // Create AuthService instance
                var authService = new AuthService();

                // Authenticate user
                DataTable userData = authService.AuthenticateUser(txtUsername.Text.Trim(), txtPassword.Text);

                if (userData != null && userData.Rows.Count > 0)
                {
                    // Get user information
                    DataRow userRow = userData.Rows[0];
                    int userId = Convert.ToInt32(userRow["UserID"]);
                    string username = userRow["Username"].ToString();
                    string email = userRow["Email"] != null ? userRow["Email"].ToString() : "";
                    int roleId = Convert.ToInt32(userRow["RoleID"]);
                    string roleName = userRow["RoleName"] != null ? userRow["RoleName"].ToString() : "";
                    bool isActive = Convert.ToBoolean(userRow["IsActive"]);

                    // Check if user is active
                    if (!isActive)
                    {
                        ShowError("Your account has been deactivated. Please contact the administrator.");
                        return;
                    }

                    // Update last login date
                    authService.UpdateLastLoginDate(userId);

                    // Store user information in session
                    Session["UserID"] = userId;
                    Session["Username"] = username;
                    Session["Email"] = email;
                    Session["RoleID"] = roleId;
                    Session["RoleName"] = roleName;
                    Session["IsAuthenticated"] = true;
                    Session["LoginTime"] = DateTime.Now;

                    // Show success message
                    ShowSuccess("Login successful! Redirecting...");

                    // Redirect to dashboard or appropriate page
                    Response.AddHeader("Refresh", "2;url=Dashboard.aspx");
                }
                else
                {
                    ShowError("Invalid username or password. Please try again.");
                }
            }
            catch (Exception ex)
            {
                // Log the error (in a real application, you'd want to log this properly)
                ShowError("An error occurred during login. Please try again.");
                
                // For debugging purposes, you can uncomment the line below
                // ShowError("Error: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            errorMessage.InnerText = message;
            errorMessage.Style["display"] = "block";
        }

        private void ShowSuccess(string message)
        {
            successMessage.InnerText = message;
            successMessage.Style["display"] = "block";
        }
    }
} 