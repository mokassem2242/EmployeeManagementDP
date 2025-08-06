<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestPage.aspx.cs" Inherits="EmployeService.TestPage" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Test Page</title>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <h1>Test Page</h1>
                <asp:Button ID="btnTest" runat="server" Text="Test Button" OnClick="btnTest_Click" />
                <br />
                <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>
            </div>
        </form>
    </body>

    </html>