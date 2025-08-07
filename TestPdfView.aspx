<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestPdfView.aspx.cs" Inherits="EmployeService.TestPdfView" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Test PDF View</title>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <h2>Test PDF Content View</h2>
                <p>This page shows how the PDF content will look:</p>

                <asp:Button ID="btnGenerateView" runat="server" Text="Generate PDF View"
                    OnClick="btnGenerateView_Click" />

                <br /><br />
                <div id="pdfContent" runat="server">
                    <p>Click the button above to generate the PDF content view.</p>
                </div>
            </div>
        </form>
    </body>

    </html>