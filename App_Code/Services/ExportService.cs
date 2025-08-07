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
            
            // Add headers with ALL database columns
            csv.AppendLine("Employee ID,Emirates ID,Passport Number,First Name,Last Name,Full Name,Nationality,Date of Birth,Gender,Work Email,Personal Email,Work Phone,Personal Phone,Emirates,City,District,Hire Date,Contract Type,Employment Status,Department ID,Position ID,Manager ID,Salary Grade,Created Date,Modified Date,Created By,Modified By,Department Name,Position Title,Manager Name");
            
            // Add data rows with ALL columns
            foreach (DataRow row in employees.Rows)
            {
                string dateOfBirth = "";
                if (row["DateOfBirth"] != DBNull.Value)
                {
                    dateOfBirth = Convert.ToDateTime(row["DateOfBirth"]).ToString("MM/dd/yyyy");
                }
                
                string hireDate = "";
                if (row["HireDate"] != DBNull.Value)
                {
                    hireDate = Convert.ToDateTime(row["HireDate"]).ToString("MM/dd/yyyy");
                }
                
                string createdDate = "";
                if (row["CreatedDate"] != DBNull.Value)
                {
                    createdDate = Convert.ToDateTime(row["CreatedDate"]).ToString("MM/dd/yyyy");
                }
                
                string modifiedDate = "";
                if (row["ModifiedDate"] != DBNull.Value)
                {
                    modifiedDate = Convert.ToDateTime(row["ModifiedDate"]).ToString("MM/dd/yyyy");
                }
                
                csv.AppendLine(string.Format("{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10},{11},{12},{13},{14},{15},{16},{17},{18},{19},{20},{21},{22},{23},{24},{25},{26},{27},{28},{29}",
                    EscapeCsvField(GetSafeString(row["EmployeeID"])),
                    EscapeCsvField(GetSafeString(row["EmiratesID"])),
                    EscapeCsvField(GetSafeString(row["PassportNumber"])),
                    EscapeCsvField(GetSafeString(row["FirstName"])),
                    EscapeCsvField(GetSafeString(row["LastName"])),
                    EscapeCsvField(GetSafeString(row["FullName"])),
                    EscapeCsvField(GetSafeString(row["Nationality"])),
                    EscapeCsvField(dateOfBirth),
                    EscapeCsvField(GetSafeString(row["Gender"])),
                    EscapeCsvField(GetSafeString(row["WorkEmail"])),
                    EscapeCsvField(GetSafeString(row["PersonalEmail"])),
                    EscapeCsvField(GetSafeString(row["WorkPhone"])),
                    EscapeCsvField(GetSafeString(row["PersonalPhone"])),
                    EscapeCsvField(GetSafeString(row["Emirates"])),
                    EscapeCsvField(GetSafeString(row["City"])),
                    EscapeCsvField(GetSafeString(row["District"])),
                    EscapeCsvField(hireDate),
                    EscapeCsvField(GetSafeString(row["ContractType"])),
                    EscapeCsvField(GetSafeString(row["EmploymentStatus"])),
                    EscapeCsvField(GetSafeString(row["DepartmentID"])),
                    EscapeCsvField(GetSafeString(row["PositionID"])),
                    EscapeCsvField(GetSafeString(row["ManagerID"])),
                    EscapeCsvField(GetSafeString(row["SalaryGrade"])),
                    EscapeCsvField(createdDate),
                    EscapeCsvField(modifiedDate),
                    EscapeCsvField(GetSafeString(row["CreatedBy"])),
                    EscapeCsvField(GetSafeString(row["ModifiedBy"])),
                    EscapeCsvField(GetSafeString(row["DepartmentName"])),
                    EscapeCsvField(GetSafeString(row["PositionTitle"])),
                    EscapeCsvField(GetSafeString(row["ManagerName"]))
                ));
            }

            // Send to browser
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = "text/csv";
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.csv", fileName));
            HttpContext.Current.Response.Write(csv.ToString());
            HttpContext.Current.Response.End();
        }

        private string GetSafeString(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "";
            }
            return value.ToString();
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