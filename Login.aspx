<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EmployeService.Login" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Login - UAE Government Employee Management</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #F9F7ED 0%, #F2ECCF 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .login-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(182, 138, 53, 0.1);
                padding: 40px;
                width: 100%;
                max-width: 400px;
                position: relative;
                overflow: hidden;
            }

            .login-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #B68A35, #CBA344, #D7BC6D);
            }

            .logo {
                text-align: center;
                margin-bottom: 30px;
            }

            .logo h1 {
                color: #B68A35;
                font-size: 24px;
                font-weight: 600;
                margin-bottom: 5px;
            }

            .logo p {
                color: #92722A;
                font-size: 14px;
                opacity: 0.8;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #6C4527;
                font-weight: 500;
                font-size: 14px;
            }

            .form-control {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #E6D7A2;
                border-radius: 10px;
                font-size: 16px;
                transition: all 0.3s ease;
                background: #F9F7ED;
            }

            .form-control:focus {
                outline: none;
                border-color: #B68A35;
                background: white;
                box-shadow: 0 0 0 3px rgba(182, 138, 53, 0.1);
            }

            .btn-login {
                width: 100%;
                padding: 14px;
                background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 10px;
            }

            .btn-login:hover {
                background: linear-gradient(135deg, #92722A 0%, #B68A35 100%);
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(182, 138, 53, 0.3);
            }

            .btn-login:active {
                transform: translateY(0);
            }

            .links {
                text-align: center;
                margin-top: 20px;
            }

            .links a {
                color: #B68A35;
                text-decoration: none;
                font-size: 14px;
                transition: color 0.3s ease;
            }

            .links a:hover {
                color: #92722A;
                text-decoration: underline;
            }

            .error-message {
                background: #F2ECCF;
                border: 1px solid #D7BC6D;
                color: #6C4527;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
                display: none;
            }

            .success-message {
                background: #F9F7ED;
                border: 1px solid #E6D7A2;
                color: #5D3B26;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
                display: none;
            }

            .loading {
                display: none;
                text-align: center;
                margin-top: 10px;
            }

            .spinner {
                border: 2px solid #E6D7A2;
                border-top: 2px solid #B68A35;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                animation: spin 1s linear infinite;
                display: inline-block;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }

            @media (max-width: 480px) {
                .login-container {
                    margin: 20px;
                    padding: 30px 20px;
                }
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="login-container">
                <div class="logo">
                    <h1>UAE Government</h1>
                    <p>Employee Management System</p>
                </div>

                <div id="errorMessage" class="error-message" runat="server"></div>
                <div id="successMessage" class="success-message" runat="server"></div>

                <div class="form-group">
                    <label for="txtUsername">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"
                        placeholder="Enter your username" required="required"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"
                        placeholder="Enter your password" required="required"></asp:TextBox>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />

                <div class="loading" id="loadingDiv">
                    <div class="spinner"></div>
                    <span style="margin-left: 10px; color: #92722A;">Logging in...</span>
                </div>

                <div class="links">
                    <a href="Register.aspx">Don't have an account? Register here</a>
                </div>
            </div>
        </form>

        <script type="text/javascript">
            function showLoading() {
                document.getElementById('loadingDiv').style.display = 'block';
                document.getElementById('btnLogin').disabled = true;
            }

            function hideLoading() {
                document.getElementById('loadingDiv').style.display = 'none';
                document.getElementById('btnLogin').disabled = false;
            }

            // Show loading when form is submitted
            document.getElementById('form1').addEventListener('submit', function () {
                showLoading();
            });
        </script>
    </body>

    </html>