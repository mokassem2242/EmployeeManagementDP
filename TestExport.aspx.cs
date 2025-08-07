using System;
using System.Data;
using System.Web.UI;

namespace EmployeService
{
    public partial class TestExport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "Ready to test export functionality.";
            }
        }

        protected void btnTestPdf_Click(object sender, EventArgs e)
        {
            try
            {
                // Create sample data
                DataTable sampleData = CreateSampleData();
                
                // Create export service and export
                ExportService exportService = new ExportService();
                string fileName = string.Format("TestExport_{0:yyyyMMdd_HHmmss}", DateTime.Now);
                exportService.ExportEmployees(sampleData, ExportService.ExportFormat.PDF, ExportService.ExportScope.All, fileName);
                
                lblMessage.Text = "PDF export test completed successfully!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error during PDF export: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnTestExcel_Click(object sender, EventArgs e)
        {
            try
            {
                // Create sample data
                DataTable sampleData = CreateSampleData();
                
                // Create export service and export
                ExportService exportService = new ExportService();
                string fileName = string.Format("TestExport_{0:yyyyMMdd_HHmmss}", DateTime.Now);
                exportService.ExportEmployees(sampleData, ExportService.ExportFormat.Excel, ExportService.ExportScope.All, fileName);
                
                lblMessage.Text = "Excel export test completed successfully!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error during Excel export: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnTestCsv_Click(object sender, EventArgs e)
        {
            try
            {
                // Create sample data
                DataTable sampleData = CreateSampleData();
                
                // Create export service and export
                ExportService exportService = new ExportService();
                string fileName = string.Format("TestExport_{0:yyyyMMdd_HHmmss}", DateTime.Now);
                exportService.ExportEmployees(sampleData, ExportService.ExportFormat.CSV, ExportService.ExportScope.All, fileName);
                
                lblMessage.Text = "CSV export test completed successfully!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error during CSV export: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private DataTable CreateSampleData()
        {
            DataTable dt = new DataTable();
            
            // Add columns that match the expected structure
            dt.Columns.Add("EmployeeID", typeof(int));
            dt.Columns.Add("EmiratesID", typeof(string));
            dt.Columns.Add("PassportNumber", typeof(string));
            dt.Columns.Add("FirstName", typeof(string));
            dt.Columns.Add("LastName", typeof(string));
            dt.Columns.Add("FullName", typeof(string));
            dt.Columns.Add("Nationality", typeof(string));
            dt.Columns.Add("DateOfBirth", typeof(DateTime));
            dt.Columns.Add("Gender", typeof(string));
            dt.Columns.Add("WorkEmail", typeof(string));
            dt.Columns.Add("PersonalEmail", typeof(string));
            dt.Columns.Add("WorkPhone", typeof(string));
            dt.Columns.Add("PersonalPhone", typeof(string));
            dt.Columns.Add("Emirates", typeof(string));
            dt.Columns.Add("City", typeof(string));
            dt.Columns.Add("District", typeof(string));
            dt.Columns.Add("HireDate", typeof(DateTime));
            dt.Columns.Add("ContractType", typeof(string));
            dt.Columns.Add("EmploymentStatus", typeof(string));
            dt.Columns.Add("DepartmentID", typeof(int));
            dt.Columns.Add("PositionID", typeof(int));
            dt.Columns.Add("ManagerID", typeof(int));
            dt.Columns.Add("SalaryGrade", typeof(string));
            dt.Columns.Add("CreatedDate", typeof(DateTime));
            dt.Columns.Add("ModifiedDate", typeof(DateTime));
            dt.Columns.Add("CreatedBy", typeof(int));
            dt.Columns.Add("ModifiedBy", typeof(int));
            dt.Columns.Add("DepartmentName", typeof(string));
            dt.Columns.Add("PositionTitle", typeof(string));
            dt.Columns.Add("ManagerName", typeof(string));
            
            // Add sample data
            dt.Rows.Add(
                1, "784-1985-1234567-8", "A12345678", "Ahmed", "Al Mansouri", "Ahmed Al Mansouri", 
                "UAE", new DateTime(1985, 5, 15), "Male", "ahmed.mansouri@uae.gov.ae", "ahmed.mansouri@email.com",
                "+971-50-123-4567", "+971-50-123-4568", "Dubai", "Dubai", "Business Bay",
                new DateTime(2020, 3, 1), "Full-time", "Active", 1, 1, null, "Grade 5",
                new DateTime(2020, 3, 1), new DateTime(2020, 3, 1), 1, 1, "Information Technology", "Software Engineer", ""
            );
            
            dt.Rows.Add(
                2, "784-1990-9876543-2", "B87654321", "Fatima", "Al Zahra", "Fatima Al Zahra",
                "UAE", new DateTime(1990, 8, 22), "Female", "fatima.zahra@uae.gov.ae", "fatima.zahra@email.com",
                "+971-50-987-6543", "+971-50-987-6544", "Abu Dhabi", "Abu Dhabi", "Al Reem Island",
                new DateTime(2019, 7, 15), "Full-time", "Active", 2, 2, 1, "Grade 4",
                new DateTime(2019, 7, 15), new DateTime(2019, 7, 15), 1, 1, "Human Resources", "HR Manager", "Ahmed Al Mansouri"
            );
            
            dt.Rows.Add(
                3, "784-1988-5555555-5", "C55555555", "Omar", "Al Rashid", "Omar Al Rashid",
                "UAE", new DateTime(1988, 12, 10), "Male", "omar.rashid@uae.gov.ae", "omar.rashid@email.com",
                "+971-50-555-5555", "+971-50-555-5556", "Sharjah", "Sharjah", "Al Khan",
                new DateTime(2021, 1, 10), "Full-time", "Active", 3, 3, 1, "Grade 6",
                new DateTime(2021, 1, 10), new DateTime(2021, 1, 10), 1, 1, "Finance", "Financial Analyst", "Ahmed Al Mansouri"
            );
            
            return dt;
        }
    }
}
