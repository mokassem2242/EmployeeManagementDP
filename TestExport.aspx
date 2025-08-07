<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestExport.aspx.cs" Inherits="EmployeService.TestExport" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Test Export</title>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <h2>Test Export Functionality</h2>
                <p>This page tests the PDF export functionality with sample data.</p>

                <asp:Button ID="btnTestPdf" runat="server" Text="Test PDF Export" OnClick="btnTestPdf_Click" />
                <asp:Button ID="btnTestExcel" runat="server" Text="Test Excel Export" OnClick="btnTestExcel_Click" />
                <asp:Button ID="btnTestCsv" runat="server" Text="Test CSV Export" OnClick="btnTestCsv_Click" />

                <br /><br />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
            </div>
        </form>
    </body>

    </html>