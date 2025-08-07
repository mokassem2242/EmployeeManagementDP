using System;
using System.Data;
using System.IO;
using System.Web;
using System.Drawing;
using System.Text;

namespace EmployeService.Services
{
    public class ExportService
    {
        public enum ExportFormat
        {
            PDF,
            Excel,
            CSV
        }

        public enum ExportScope
        {
            All,
            CurrentPage,
            SearchResults,
            Selected
        }

        public void ExportEmployees(DataTable employees, ExportFormat format, ExportScope scope, string fileName = null)
        {
            if (fileName == null)
            {
                fileName = string.Format("EmployeeExport_{0:yyyyMMdd_HHmmss}", DateTime.Now);
            }

            switch (format)
            {
                case ExportFormat.PDF:
                    ExportToCsv(employees, fileName + "_pdf_fallback"); // Fallback to CSV for now
                    break;
                case ExportFormat.Excel:
                    ExportToCsv(employees, fileName + "_excel_fallback"); // Fallback to CSV for now
                    break;
                case ExportFormat.CSV:
                    ExportToCsv(employees, fileName);
                    break;
            }
        }

        private void ExportToCsv(DataTable employees, string fileName)
        {
            StringBuilder csv = new StringBuilder();
            
            // Add headers
            csv.AppendLine("ID,First Name,Last Name,Work Email,Work Phone,Emirates ID,Status,Hire Date,Department,Position");
            
            // Add data rows
            foreach (DataRow row in employees.Rows)
            {
                string hireDate = "";
                if (row["HireDate"] != DBNull.Value)
                {
                    hireDate = Convert.ToDateTime(row["HireDate"]).ToString("MM/dd/yyyy");
                }
                
                csv.AppendLine(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9}",
                    EscapeCsvField(row["EmployeeID"].ToString()),
                    EscapeCsvField(row["FirstName"].ToString()),
                    EscapeCsvField(row["LastName"].ToString()),
                    EscapeCsvField(row["WorkEmail"].ToString()),
                    EscapeCsvField(row["WorkPhone"].ToString()),
                    EscapeCsvField(row["EmiratesID"].ToString()),
                    EscapeCsvField(row["EmploymentStatus"].ToString()),
                    EscapeCsvField(hireDate),
                    EscapeCsvField(row["DepartmentName"].ToString()),
                    EscapeCsvField(row["PositionTitle"].ToString())
                ));
            }

            // Send to browser
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = "text/csv";
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.csv", fileName));
            HttpContext.Current.Response.Write(csv.ToString());
            HttpContext.Current.Response.End();
        }

        private string EscapeCsvField(string field)
        {
            if (field.Contains(",") || field.Contains("\"") || field.Contains("\n"))
            {
                return "\"" + field.Replace("\"", "\"\"") + "\"";
            }
            return field;
        }
    }
} 