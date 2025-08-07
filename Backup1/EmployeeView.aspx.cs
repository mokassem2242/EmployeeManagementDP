using System;
using System.Data;
using System.Web.UI;

namespace EmployeService
{
    public partial class EmployeeView : System.Web.UI.Page
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
                LoadEmployeeProfile();
            }
        }

        private void LoadEmployeeProfile()
        {
            try
            {
                // Get current user ID
                int userId = Convert.ToInt32(Session["UserID"]);

                // Get employee data for the current user
                var employeeDAL = new DataAccess.EmployeeDAL();
                DataTable employeeData = employeeDAL.GetEmployeeByUserId(userId);

                if (employeeData.Rows.Count > 0)
                {
                    DataRow row = employeeData.Rows[0];
                    PopulateProfile(row);
                }
                else
                {
                    ShowAlert("Employee profile not found. Please contact your administrator.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Error loading employee profile: " + ex.Message, "danger");
            }
        }

        private void PopulateProfile(DataRow row)
        {
            try
            {
                // Set avatar (first letter of first name)
                string firstName = row["FirstName"].ToString();
                if (!string.IsNullOrEmpty(firstName))
                {
                    litAvatar.Text = firstName.Substring(0, 1).ToUpper();
                }
                else
                {
                    litAvatar.Text = "👤";
                }

                // Set basic information
                litFullName.Text = $"{row["FirstName"]} {row["LastName"]}";
                litPosition.Text = row["PositionTitle"].ToString();
                litDepartment.Text = row["DepartmentName"].ToString();

                // Personal Information
                litEmiratesId.Text = row["EmiratesID"].ToString();
                litPassportNumber.Text = row["PassportNumber"].ToString();
                litNationality.Text = row["Nationality"].ToString();
                
                if (row["DateOfBirth"] != DBNull.Value)
                {
                    litDateOfBirth.Text = Convert.ToDateTime(row["DateOfBirth"]).ToString("MMMM dd, yyyy");
                }
                else
                {
                    litDateOfBirth.Text = "Not specified";
                }
                
                litGender.Text = row["Gender"].ToString();

                // Contact Information
                litWorkEmail.Text = row["WorkEmail"].ToString();
                litPersonalEmail.Text = row["PersonalEmail"].ToString();
                litWorkPhone.Text = row["WorkPhone"].ToString();
                litPersonalPhone.Text = row["PersonalPhone"].ToString();

                // Address Information
                litEmirates.Text = row["Emirates"].ToString();
                litCity.Text = row["City"].ToString();
                litDistrict.Text = row["District"].ToString();

                // Employment Information
                if (row["HireDate"] != DBNull.Value)
                {
                    litHireDate.Text = Convert.ToDateTime(row["HireDate"]).ToString("MMMM dd, yyyy");
                }
                else
                {
                    litHireDate.Text = "Not specified";
                }
                
                litContractType.Text = row["ContractType"].ToString();
                
                // Employment status with styling
                string status = row["EmploymentStatus"].ToString();
                litEmploymentStatus.Text = $"<span class='status-badge status-{status.ToLower()}'>{status}</span>";
                
                litSalaryGrade.Text = row["SalaryGrade"].ToString();
                litManager.Text = row["ManagerName"].ToString();
            }
            catch (Exception ex)
            {
                ShowAlert("Error populating profile: " + ex.Message, "danger");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        private void ShowAlert(string message, string type)
        {
            alertPanel.Visible = true;
            alertMessage.Text = message;
            alertPanel.CssClass = "alert alert-" + type;
        }
    }
} 