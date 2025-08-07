using System;
using System.Data;
using System.IO;
using System.Web;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;

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
                    ExportToPdf(employees, fileName);
                    break;
                case ExportFormat.Excel:
                    ExportToExcel(employees, fileName);
                    break;
                case ExportFormat.CSV:
                    ExportToCsv(employees, fileName);
                    break;
            }
        }

        private void ExportToPdf(DataTable employees, string fileName)
        {
            try
            {
                // Try to use iTextSharp for proper PDF generation
                ExportToPdfWithITextSharp(employees, fileName);
            }
            catch (Exception ex)
            {
                // Fallback to HTML approach if iTextSharp fails
                System.Diagnostics.Debug.WriteLine(string.Format("iTextSharp PDF generation failed: {0}", ex.Message));
                ExportToPdfAsHtml(employees, fileName);
            }
        }

        private void ExportToPdfWithITextSharp(DataTable employees, string fileName)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                Document document = new Document(PageSize.A4, 25, 25, 30, 30);
                PdfWriter writer = PdfWriter.GetInstance(document, ms);

                // Add document metadata
                document.AddTitle("Employee Report");
                document.AddAuthor("UAE Government Employee Management System");
                document.AddCreator("UAE Government Employee Management System");

                document.Open();

                // Add header
                Font headerFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 18);
                Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 14);
                Font normalFont = FontFactory.GetFont(FontFactory.HELVETICA, 10);
                Font smallFont = FontFactory.GetFont(FontFactory.HELVETICA, 8);

                Paragraph header = new Paragraph("UAE Government Employee Management System", headerFont);
                header.Alignment = Element.ALIGN_CENTER;
                document.Add(header);

                Paragraph subtitle = new Paragraph("Employee Report - " + DateTime.Now.ToString("MM/dd/yyyy HH:mm"), titleFont);
                subtitle.Alignment = Element.ALIGN_CENTER;
                subtitle.SpacingAfter = 20f;
                document.Add(subtitle);

                // Add summary
                Paragraph summary = new Paragraph(string.Format("Total Employees: {0} | Report Date: {1}", employees.Rows.Count, DateTime.Now.ToString("MMMM dd, yyyy")), normalFont);
                summary.Alignment = Element.ALIGN_CENTER;
                summary.SpacingAfter = 20f;
                document.Add(summary);

                // Create table
                PdfPTable table = new PdfPTable(9); // Number of columns
                table.WidthPercentage = 100;

                // Add headers
                string[] headers = { "ID", "Name", "Emirates ID", "Work Email", "Work Phone", "Department", "Position", "Status", "Hire Date" };
                foreach (string headerText in headers)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(headerText, FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 9)));
                    cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                    cell.Padding = 5f;
                    table.AddCell(cell);
                }

                // Add data rows
                foreach (DataRow row in employees.Rows)
                {
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["EmployeeID"]), smallFont)) { Padding = 3f });
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["FirstName"]) + " " + GetSafeString(row["LastName"]), smallFont)) { Padding = 3f });
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["EmiratesID"]), smallFont)) { Padding = 3f });
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["WorkEmail"]), smallFont)) { Padding = 3f });
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["WorkPhone"]), smallFont)) { Padding = 3f });
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["DepartmentName"]), smallFont)) { Padding = 3f });
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["PositionTitle"]), smallFont)) { Padding = 3f });
                    table.AddCell(new PdfPCell(new Phrase(GetSafeString(row["EmploymentStatus"]), smallFont)) { Padding = 3f });
                    
                    string hireDate = "";
                    if (row["HireDate"] != DBNull.Value)
                    {
                        hireDate = Convert.ToDateTime(row["HireDate"]).ToString("MM/dd/yyyy");
                    }
                    table.AddCell(new PdfPCell(new Phrase(hireDate, smallFont)) { Padding = 3f });
                }

                document.Add(table);

                // Add footer
                Paragraph footer = new Paragraph(string.Format("Generated on: {0} | UAE Government Employee Management System", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss")), smallFont);
                footer.Alignment = Element.ALIGN_CENTER;
                footer.SpacingBefore = 20f;
                document.Add(footer);

                document.Close();

                // Send to browser
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/pdf";
                HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.pdf", fileName));
                HttpContext.Current.Response.BinaryWrite(ms.ToArray());
                HttpContext.Current.Response.End();
            }
        }

        private void ExportToPdfAsHtml(DataTable employees, string fileName)
        {
            // Create HTML that can be printed as PDF
            StringBuilder html = new StringBuilder();
            
            html.AppendLine("<!DOCTYPE html>");
            html.AppendLine("<html>");
            html.AppendLine("<head>");
            html.AppendLine("<meta charset='utf-8'>");
            html.AppendLine("<title>Employee Report</title>");
            html.AppendLine("<style>");
            html.AppendLine("@media print {");
            html.AppendLine("  @page { size: A4; margin: 1cm; }");
            html.AppendLine("  body { font-family: Arial, sans-serif; margin: 0; padding: 20px; font-size: 12px; }");
            html.AppendLine("  .header { text-align: center; margin-bottom: 30px; border-bottom: 2px solid #333; padding-bottom: 10px; }");
            html.AppendLine("  .header h1 { color: #2c3e50; margin: 0; font-size: 20px; }");
            html.AppendLine("  .header p { color: #7f8c8d; margin: 5px 0; font-size: 12px; }");
            html.AppendLine("  table { width: 100%; border-collapse: collapse; margin-top: 20px; page-break-inside: auto; }");
            html.AppendLine("  thead { display: table-header-group; }");
            html.AppendLine("  tr { page-break-inside: avoid; page-break-after: auto; }");
            html.AppendLine("  th, td { border: 1px solid #ddd; padding: 6px; text-align: left; font-size: 10px; }");
            html.AppendLine("  th { background-color: #f2f2f2; font-weight: bold; color: #333; }");
            html.AppendLine("  tr:nth-child(even) { background-color: #f9f9f9; }");
            html.AppendLine("  .footer { margin-top: 30px; text-align: center; font-size: 10px; color: #7f8c8d; border-top: 1px solid #ddd; padding-top: 10px; }");
            html.AppendLine("  .summary { background-color: #ecf0f1; padding: 10px; margin-bottom: 20px; border-radius: 3px; }");
            html.AppendLine("  .summary h3 { margin: 0 0 8px 0; color: #2c3e50; font-size: 14px; }");
            html.AppendLine("  .summary p { margin: 3px 0; font-size: 11px; }");
            html.AppendLine("  .print-button { display: none; }");
            html.AppendLine("}");
            html.AppendLine("body { font-family: Arial, sans-serif; margin: 0; padding: 20px; font-size: 12px; }");
            html.AppendLine(".header { text-align: center; margin-bottom: 30px; border-bottom: 2px solid #333; padding-bottom: 10px; }");
            html.AppendLine(".header h1 { color: #2c3e50; margin: 0; font-size: 20px; }");
            html.AppendLine(".header p { color: #7f8c8d; margin: 5px 0; font-size: 12px; }");
            html.AppendLine("table { width: 100%; border-collapse: collapse; margin-top: 20px; }");
            html.AppendLine("th, td { border: 1px solid #ddd; padding: 6px; text-align: left; font-size: 10px; }");
            html.AppendLine("th { background-color: #f2f2f2; font-weight: bold; color: #333; }");
            html.AppendLine("tr:nth-child(even) { background-color: #f9f9f9; }");
            html.AppendLine(".footer { margin-top: 30px; text-align: center; font-size: 10px; color: #7f8c8d; border-top: 1px solid #ddd; padding-top: 10px; }");
            html.AppendLine(".summary { background-color: #ecf0f1; padding: 10px; margin-bottom: 20px; border-radius: 3px; }");
            html.AppendLine(".summary h3 { margin: 0 0 8px 0; color: #2c3e50; font-size: 14px; }");
            html.AppendLine(".summary p { margin: 3px 0; font-size: 11px; }");
            html.AppendLine(".print-button { margin: 20px 0; text-align: center; }");
            html.AppendLine(".print-button button { padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; }");
            html.AppendLine(".print-button button:hover { background-color: #0056b3; }");
            html.AppendLine("</style>");
            html.AppendLine("</head>");
            html.AppendLine("<body>");
            
            // Print button
            html.AppendLine("<div class='print-button'>");
            html.AppendLine("<button onclick='window.print()'>Print as PDF</button>");
            html.AppendLine("<p>Click the button above to print this report as PDF</p>");
            html.AppendLine("</div>");
            
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
            
            html.AppendLine("</body>");
            html.AppendLine("</html>");

            // Send as HTML file that can be printed as PDF
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = "text/html";
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.html", fileName));
            HttpContext.Current.Response.Write(html.ToString());
            HttpContext.Current.Response.End();
        }

        private void ExportToExcel(DataTable employees, string fileName)
        {
            // Create HTML that Excel can open
            StringBuilder html = new StringBuilder();
            
            html.AppendLine("<!DOCTYPE html>");
            html.AppendLine("<html>");
            html.AppendLine("<head>");
            html.AppendLine("<meta charset='utf-8'>");
            html.AppendLine("<title>Employee Report</title>");
            html.AppendLine("</head>");
            html.AppendLine("<body>");
            
            html.AppendLine("<table border='1'>");
            html.AppendLine("<thead>");
            html.AppendLine("<tr>");
            html.AppendLine("<th>Employee ID</th>");
            html.AppendLine("<th>Emirates ID</th>");
            html.AppendLine("<th>Passport Number</th>");
            html.AppendLine("<th>First Name</th>");
            html.AppendLine("<th>Last Name</th>");
            html.AppendLine("<th>Full Name</th>");
            html.AppendLine("<th>Nationality</th>");
            html.AppendLine("<th>Date of Birth</th>");
            html.AppendLine("<th>Gender</th>");
            html.AppendLine("<th>Work Email</th>");
            html.AppendLine("<th>Personal Email</th>");
            html.AppendLine("<th>Work Phone</th>");
            html.AppendLine("<th>Personal Phone</th>");
            html.AppendLine("<th>Emirates</th>");
            html.AppendLine("<th>City</th>");
            html.AppendLine("<th>District</th>");
            html.AppendLine("<th>Hire Date</th>");
            html.AppendLine("<th>Contract Type</th>");
            html.AppendLine("<th>Employment Status</th>");
            html.AppendLine("<th>Department ID</th>");
            html.AppendLine("<th>Position ID</th>");
            html.AppendLine("<th>Manager ID</th>");
            html.AppendLine("<th>Salary Grade</th>");
            html.AppendLine("<th>Created Date</th>");
            html.AppendLine("<th>Modified Date</th>");
            html.AppendLine("<th>Created By</th>");
            html.AppendLine("<th>Modified By</th>");
            html.AppendLine("<th>Department Name</th>");
            html.AppendLine("<th>Position Title</th>");
            html.AppendLine("<th>Manager Name</th>");
            html.AppendLine("</tr>");
            html.AppendLine("</thead>");
            html.AppendLine("<tbody>");
            
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
                
                html.AppendLine("<tr>");
                html.AppendLine("<td>" + GetSafeString(row["EmployeeID"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["EmiratesID"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["PassportNumber"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["FirstName"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["LastName"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["FullName"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["Nationality"]) + "</td>");
                html.AppendLine("<td>" + dateOfBirth + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["Gender"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["WorkEmail"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["PersonalEmail"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["WorkPhone"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["PersonalPhone"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["Emirates"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["City"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["District"]) + "</td>");
                html.AppendLine("<td>" + hireDate + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["ContractType"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["EmploymentStatus"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["DepartmentID"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["PositionID"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["ManagerID"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["SalaryGrade"]) + "</td>");
                html.AppendLine("<td>" + createdDate + "</td>");
                html.AppendLine("<td>" + modifiedDate + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["CreatedBy"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["ModifiedBy"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["DepartmentName"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["PositionTitle"]) + "</td>");
                html.AppendLine("<td>" + GetSafeString(row["ManagerName"]) + "</td>");
                html.AppendLine("</tr>");
            }
            
            html.AppendLine("</tbody>");
            html.AppendLine("</table>");
            html.AppendLine("</body>");
            html.AppendLine("</html>");

            // Send HTML as Excel
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.xls", fileName));
            HttpContext.Current.Response.Write(html.ToString());
            HttpContext.Current.Response.End();
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