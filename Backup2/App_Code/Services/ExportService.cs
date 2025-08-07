using System;
using System.Data;
using System.IO;
using System.Web;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using System.Drawing;
using System.Linq;

namespace EmployeService.Services
{
    public class ExportService
    {
        public enum ExportFormat
        {
            PDF,
            Excel
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
                fileName = $"EmployeeExport_{DateTime.Now:yyyyMMdd_HHmmss}";
            }

            switch (format)
            {
                case ExportFormat.PDF:
                    ExportToPdf(employees, fileName);
                    break;
                case ExportFormat.Excel:
                    ExportToExcel(employees, fileName);
                    break;
            }
        }

        private void ExportToPdf(DataTable employees, string fileName)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                Document document = new Document(PageSize.A4, 25, 25, 30, 30);
                PdfWriter writer = PdfWriter.GetInstance(document, ms);

                // Add company header
                document.AddTitle("Employee Report");
                document.AddAuthor("Employee Management System");
                document.AddCreator("Employee Management System");

                document.Open();

                // Add header
                Font headerFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 18);
                Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 14);
                Font normalFont = FontFactory.GetFont(FontFactory.HELVETICA, 10);

                Paragraph header = new Paragraph("Employee Management System", headerFont);
                header.Alignment = Element.ALIGN_CENTER;
                document.Add(header);

                Paragraph subtitle = new Paragraph("Employee Report - " + DateTime.Now.ToString("MM/dd/yyyy HH:mm"), titleFont);
                subtitle.Alignment = Element.ALIGN_CENTER;
                subtitle.SpacingAfter = 20f;
                document.Add(subtitle);

                // Create table
                PdfPTable table = new PdfPTable(8); // Number of columns
                table.WidthPercentage = 100;

                // Add headers
                string[] headers = { "ID", "First Name", "Last Name", "Work Email", "Work Phone", "Emirates ID", "Status", "Hire Date" };
                foreach (string headerText in headers)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(headerText, FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 10)));
                    cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                    cell.Padding = 5f;
                    table.AddCell(cell);
                }

                // Add data rows
                foreach (DataRow row in employees.Rows)
                {
                    table.AddCell(new PdfPCell(new Phrase(row["EmployeeID"].ToString(), normalFont)) { Padding = 5f });
                    table.AddCell(new PdfPCell(new Phrase(row["FirstName"].ToString(), normalFont)) { Padding = 5f });
                    table.AddCell(new PdfPCell(new Phrase(row["LastName"].ToString(), normalFont)) { Padding = 5f });
                    table.AddCell(new PdfPCell(new Phrase(row["WorkEmail"].ToString(), normalFont)) { Padding = 5f });
                    table.AddCell(new PdfPCell(new Phrase(row["WorkPhone"].ToString(), normalFont)) { Padding = 5f });
                    table.AddCell(new PdfPCell(new Phrase(row["EmiratesID"].ToString(), normalFont)) { Padding = 5f });
                    table.AddCell(new PdfPCell(new Phrase(row["EmploymentStatus"].ToString(), normalFont)) { Padding = 5f });
                    
                    string hireDate = "";
                    if (row["HireDate"] != DBNull.Value)
                    {
                        hireDate = Convert.ToDateTime(row["HireDate"]).ToString("MM/dd/yyyy");
                    }
                    table.AddCell(new PdfPCell(new Phrase(hireDate, normalFont)) { Padding = 5f });
                }

                document.Add(table);

                // Add footer
                Paragraph footer = new Paragraph($"Total Employees: {employees.Rows.Count} | Generated on: {DateTime.Now:MM/dd/yyyy HH:mm:ss}", normalFont);
                footer.Alignment = Element.ALIGN_CENTER;
                footer.SpacingBefore = 20f;
                document.Add(footer);

                document.Close();

                // Send to browser
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/pdf";
                HttpContext.Current.Response.AddHeader("content-disposition", $"attachment;filename={fileName}.pdf");
                HttpContext.Current.Response.BinaryWrite(ms.ToArray());
                HttpContext.Current.Response.End();
            }
        }

        private void ExportToExcel(DataTable employees, string fileName)
        {
            // Set EPPlus license context
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            using (ExcelPackage package = new ExcelPackage())
            {
                // Create main worksheet
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Employees");

                // Add headers
                string[] headers = { "ID", "First Name", "Last Name", "Work Email", "Work Phone", "Emirates ID", "Status", "Hire Date", "Department", "Position" };
                for (int i = 0; i < headers.Length; i++)
                {
                    worksheet.Cells[1, i + 1].Value = headers[i];
                    worksheet.Cells[1, i + 1].Style.Font.Bold = true;
                    worksheet.Cells[1, i + 1].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                    worksheet.Cells[1, i + 1].Style.Fill.BackgroundColor.SetColor(Color.LightGray);
                }

                // Add data
                int row = 2;
                foreach (DataRow dataRow in employees.Rows)
                {
                    worksheet.Cells[row, 1].Value = dataRow["EmployeeID"];
                    worksheet.Cells[row, 2].Value = dataRow["FirstName"];
                    worksheet.Cells[row, 3].Value = dataRow["LastName"];
                    worksheet.Cells[row, 4].Value = dataRow["WorkEmail"];
                    worksheet.Cells[row, 5].Value = dataRow["WorkPhone"];
                    worksheet.Cells[row, 6].Value = dataRow["EmiratesID"];
                    worksheet.Cells[row, 7].Value = dataRow["EmploymentStatus"];
                    
                    if (dataRow["HireDate"] != DBNull.Value)
                    {
                        worksheet.Cells[row, 8].Value = Convert.ToDateTime(dataRow["HireDate"]);
                        worksheet.Cells[row, 8].Style.Numberformat.Format = "mm/dd/yyyy";
                    }
                    
                    worksheet.Cells[row, 9].Value = dataRow["DepartmentName"];
                    worksheet.Cells[row, 10].Value = dataRow["PositionTitle"];
                    row++;
                }

                // Auto-fit columns
                worksheet.Cells.AutoFitColumns();

                // Create summary worksheet
                ExcelWorksheet summarySheet = package.Workbook.Worksheets.Add("Summary");
                
                // Add summary information
                summarySheet.Cells[1, 1].Value = "Employee Report Summary";
                summarySheet.Cells[1, 1].Style.Font.Bold = true;
                summarySheet.Cells[1, 1].Style.Font.Size = 16;

                summarySheet.Cells[3, 1].Value = "Total Employees:";
                summarySheet.Cells[3, 2].Value = employees.Rows.Count;

                summarySheet.Cells[4, 1].Value = "Report Generated:";
                summarySheet.Cells[4, 2].Value = DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");

                // Add status summary
                summarySheet.Cells[6, 1].Value = "Status Summary";
                summarySheet.Cells[6, 1].Style.Font.Bold = true;

                var statusGroups = employees.AsEnumerable()
                    .GroupBy(r => r.Field<string>("EmploymentStatus"))
                    .Select(g => new { Status = g.Key, Count = g.Count() });

                int summaryRow = 7;
                foreach (var group in statusGroups)
                {
                    summarySheet.Cells[summaryRow, 1].Value = group.Status;
                    summarySheet.Cells[summaryRow, 2].Value = group.Count;
                    summaryRow++;
                }

                summarySheet.Cells.AutoFitColumns();

                // Send to browser
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                HttpContext.Current.Response.AddHeader("content-disposition", $"attachment;filename={fileName}.xlsx");
                HttpContext.Current.Response.BinaryWrite(package.GetAsByteArray());
                HttpContext.Current.Response.End();
            }
        }
    }
} 