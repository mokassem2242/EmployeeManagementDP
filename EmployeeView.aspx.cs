using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                // Set basic information
                employeeName.InnerText = string.Format("{0} {1}", row["FirstName"], row["LastName"]);
                employeePosition.InnerText = row["PositionTitle"].ToString();
                employeeDepartment.InnerText = row["DepartmentName"].ToString();

                // Personal Information
                employeeId.InnerText = row["EmployeeID"].ToString();
                fullName.InnerText = string.Format("{0} {1}", row["FirstName"], row["LastName"]);
                email.InnerText = row["WorkEmail"].ToString();
                phone.InnerText = row["WorkPhone"].ToString();
                
                // Address
                string address = string.Format("{0}, {1}, {2}", row["Emirates"], row["City"], row["District"]);
                this.address.InnerText = address;
                
                if (row["DateOfBirth"] != DBNull.Value)
                {
                    dateOfBirth.InnerText = Convert.ToDateTime(row["DateOfBirth"]).ToString("MMMM dd, yyyy");
                }
                else
                {
                    dateOfBirth.InnerText = "Not specified";
                }

                // Employment Information
                department.InnerText = row["DepartmentName"].ToString();
                position.InnerText = row["PositionTitle"].ToString();
                
                if (row["HireDate"] != DBNull.Value)
                {
                    hireDate.InnerText = Convert.ToDateTime(row["HireDate"]).ToString("MMMM dd, yyyy");
                }
                else
                {
                    hireDate.InnerText = "Not specified";
                }
                
                employmentStatus.InnerText = row["EmploymentStatus"].ToString();
                salary.InnerText = row["SalaryGrade"].ToString();
                manager.InnerText = row["ManagerName"].ToString();

                // Additional Information
                emergencyContact.InnerText = row["EmergencyContact"].ToString();
                emergencyPhone.InnerText = row["EmergencyPhone"].ToString();
                bloodType.InnerText = row["BloodType"].ToString();
                nationality.InnerText = row["Nationality"].ToString();
            }
            catch (Exception ex)
            {
                ShowAlert("Error populating profile: " + ex.Message, "danger");
            }
        }

        protected void btnEditProfile_Click(object sender, EventArgs e)
        {
            // Show message that edit profile is not implemented yet
            ShowAlert("Edit Profile feature is not implemented yet. Please contact your administrator.", "info");
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            // Show message that change password is not implemented yet
            ShowAlert("Change Password feature is not implemented yet. Please contact your administrator.", "info");
        }

        protected void btnPrintProfile_Click(object sender, EventArgs e)
        {
            // Open print dialog
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PrintScript", 
                "window.print();", true);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        private void ShowAlert(string message, string type)
        {
            // For now, we'll use JavaScript alert since we don't have an alert panel
            ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertScript", 
                string.Format("alert('{0}');", message), true);
        }
    }
} 