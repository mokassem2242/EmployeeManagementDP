<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SimpleLogin.aspx.cs" Inherits="EmployeService.SimpleLogin" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Simple Login Test</title>
    </head>

    <body>
        <form id="form1" runat="server">
            <div>
                <h1>Simple Login Test</h1>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Username"></asp:TextBox>
                <br />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                <br />
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
                <br />
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </div>
        </form>
    </body>

    </html>