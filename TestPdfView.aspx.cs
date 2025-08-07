using System;
using System.Data;
using System.Text;
using System.Web.UI;

namespace EmployeService
{
    public partial class TestPdfView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize page
            }
        }

        protected void btnGenerateView_Click(object sender, EventArgs e)
        {
            try
            {
                // Create sample data
                DataTable sampleData = CreateSampleData();
                
                // Generate the HTML content that would be used for PDF
                string htmlContent = GeneratePdfHtml(sampleData);
                
                // Display the HTML content
                pdfContent.InnerHtml = htmlContent;
            }
            catch (Exception ex)
            {
                pdfContent.InnerHtml = "<p style='color: red;'>Error: " + ex.Message + "</p>";
            }
        }

        private string GeneratePdfHtml(DataTable employees)
        {
            StringBuilder html = new StringBuilder();
            
            html.AppendLine("<style>");
            html.AppendLine("@page { size: A4; margin: 1cm; }");
            html.AppendLine("body { font-family: Arial, sans-serif; margin: 0; padding: 20px; font-size: 12px; }");
            html.AppendLine(".header { text-align: center; margin-bottom: 30px; border-bottom: 2px solid #333; padding-bottom: 10px; }");
            html.AppendLine(".header h1 { color: #2c3e50; margin: 0; font-size: 20px; }");
            html.AppendLine(".header p { color: #7f8c8d; margin: 5px 0; font-size: 12px; }");
            html.AppendLine("table { width: 100%; border-collapse: collapse; margin-top: 20px; page-break-inside: auto; }");
            html.AppendLine("thead { display: table-header-group; }");
            html.AppendLine("tr { page-break-inside: avoid; page-break-after: auto; }");
            html.AppendLine("th, td { border: 1px solid #ddd; padding: 6px; text-align: left; font-size: 10px; }");
            html.AppendLine("th { background-color: #f2f2f2; font-weight: bold; color: #333; }");
            html.AppendLine("tr:nth-child(even) { background-color: #f9f9f9; }");
            html.AppendLine(".footer { margin-top: 30px; text-align: center; font-size: 10px; color: #7f8c8d; border-top: 1px solid #ddd; padding-top: 10px; }");
            html.AppendLine(".summary { background-color: #ecf0f1; padding: 10px; margin-bottom: 20px; border-radius: 3px; }");
            html.AppendLine(".summary h3 { margin: 0 0 8px 0; color: #2c3e50; font-size: 14px; }");
            html.AppendLine(".summary p { margin: 3px 0; font-size: 11px; }");
            html.AppendLine("</style>");
            
            // Header
            html.AppendLine("<div class='header'>");
            html.AppendLine("<h1>UAE Government Employee Management System</h1>");
            html.AppendLine("<p>Employee Report</p>");
            html.AppendLine("<p>Generated on: " + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "</p>");
            html.AppendLine("</div>");
            
            // Summary
            html.AppendLine("<div class='summary'>");
            html.AppendLine("<h3>Report Summary</h3>");
            html.AppendLine("<p><strong>Total Employees:</strong> " + employees.Rows.Count + "</p>");
            html.AppendLine("<p><strong>Report Date:</strong> " + DateTime.Now.ToString("MMMM dd, yyyy") + "</p>");
            html.AppendLine("</div>");
            
            // Table
            html.AppendLine("<table>");
            html.AppendLine("<thead>");
            html.AppendLine("<tr>");
            html.AppendLine("<th>ID</th>");
            html.AppendLine("<th>Name</th>");
            html.AppendLine("<th>Emirates ID</th>");
            html.AppendLine("<th>Work Email</th>");
            html.AppendLine("<th>Work Phone</th>");
            html.AppendLine("<th>Department</th>");
            html.AppendLine("<th>Position</th>");
            html.AppendLine("<th>Status</th>");
            html.AppendLine("<th>Hire Date</th>");
            html.AppendLine("</tr>");
            html.AppendLine("</thead>");
            html.AppendLine("<tbody>");
            
            // Add data rows
            foreach (DataRow row in employees.Rows)
            {
                string hireDate = "";
                if (row["HireDate"] != DBNull.Value)
                {
                    hireDate = Convert.ToDateTime(row["HireDate"]).ToString("MM/dd/yyyy");
                }
                
                html.AppendLine("<tr>");
                html.AppendLine("<td>" + GetSafeString(row["EmployeeID"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["FirstName"]) + " " + GetSafeString(row["LastName"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["EmiratesID"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["WorkEmail"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["WorkPhone"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["DepartmentName"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["PositionTitle"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["EmploymentStatus"]) + "</td>");
                html.AppendLine("<td>" + hireDate + "</td>");
                html.AppendLine("</tr>");
            }
            
            html.AppendLine("</tbody>");
            html.AppendLine("</table>");
            
            // Footer
            html.AppendLine("<div class='footer'>");
            html.AppendLine("<p>This report was generated by the UAE Government Employee Management System</p>");
            html.AppendLine("<p>For any questions, please contact the system administrator</p>");
            html.AppendLine("</div>");
            
            return html.ToString();
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

        private string GetSafeString(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "";
            }
            return value.ToString();
        }
    }
}
