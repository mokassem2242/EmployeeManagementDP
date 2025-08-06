using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using EmployeService.Services;

namespace EmployeService
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Hide any existing messages
                errorMessage.Style["display"] = "none";
                successMessage.Style["display"] = "none";
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // Hide any existing messages
                errorMessage.Style["display"] = "none";
                successMessage.Style["display"] = "none";

                // Validate input
                if (string.IsNullOrEmpty(txtFirstName.Text.Trim()))
                {
                    ShowError("Please enter your first name.");
                    return;
                }

                if (string.IsNullOrEmpty(txtLastName.Text.Trim()))
                {
                    ShowError("Please enter your last name.");
                    return;
                }

                if (string.IsNullOrEmpty(txtUsername.Text.Trim()))
                {
                    ShowError("Please enter a username.");
                    return;
                }

                if (string.IsNullOrEmpty(txtEmail.Text.Trim()))
                {
                    ShowError("Please enter your email address.");
                    return;
                }

                if (string.IsNullOrEmpty(txtPassword.Text))
                {
                    ShowError("Please enter a password.");
                    return;
                }

                if (string.IsNullOrEmpty(txtConfirmPassword.Text))
                {
                    ShowError("Please confirm your password.");
                    return;
                }

                // Validate email format
                if (!IsValidEmail(txtEmail.Text.Trim()))
                {
                    ShowError("Please enter a valid email address.");
                    return;
                }

                // Validate password match
                if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    ShowError("Passwords do not match.");
                    return;
                }

                // Validate password strength
                var authService = new AuthService();
                if (!authService.IsPasswordStrong(txtPassword.Text))
                {
                    ShowError("Password does not meet the requirements. Please ensure it has at least 8 characters, one uppercase letter, one lowercase letter, and one number.");
                    return;
                }

                // Create user
                int roleId = 3; // Default role ID for new registrations
                int userId = authService.CreateUser(
                    txtUsername.Text.Trim(),
                    txtPassword.Text,
                    txtEmail.Text.Trim(),
                    roleId
                );

                if (userId > 0)
                {
                    ShowSuccess("Account created successfully! You can now login with your credentials.");
                    
                    // Clear form
                    ClearForm();
                    
                    // Redirect to login page after 3 seconds
                    Response.AddHeader("Refresh", "3;url=Login.aspx");
                }
                else
                {
                    ShowError("Failed to create account. Please try again.");
                }
            }
            catch (Exception ex)
            {
                // Check for specific error messages
                if (ex.Message.Contains("Username") && ex.Message.Contains("already exists"))
                {
                    ShowError("Username already exists. Please choose a different username.");
                }
                else if (ex.Message.Contains("Email") && ex.Message.Contains("already exists"))
                {
                    ShowError("Email address already exists. Please use a different email.");
                }
                else
                {
                    ShowError("An error occurred during registration. Please try again.");
                }
                
                // For debugging purposes, you can uncomment the line below
                // ShowError("Error: " + ex.Message);
            }
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private void ClearForm()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtUsername.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
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