<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EmployeService.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <title>UAE Government Employee Management</title>
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

            .redirect-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(182, 138, 53, 0.1);
                padding: 40px;
                text-align: center;
                max-width: 400px;
                position: relative;
                overflow: hidden;
            }

            .redirect-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #B68A35, #CBA344, #D7BC6D);
            }

            .logo h1 {
                color: #B68A35;
                font-size: 24px;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .logo p {
                color: #92722A;
                font-size: 14px;
                margin-bottom: 30px;
            }

            .spinner {
                border: 3px solid #E6D7A2;
                border-top: 3px solid #B68A35;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                animation: spin 1s linear infinite;
                margin: 20px auto;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }

            .redirect-text {
                color: #6C4527;
                font-size: 16px;
                margin-bottom: 20px;
            }

            .login-link {
                background: linear-gradient(135deg, #B68A35 0%, #CBA344 100%);
                color: white;
                text-decoration: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 600;
                display: inline-block;
                transition: all 0.3s ease;
            }

            .login-link:hover {
                background: linear-gradient(135deg, #92722A 0%, #B68A35 100%);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(182, 138, 53, 0.3);
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="redirect-container">
                <div class="logo">
                    <h1>UAE Government</h1>
                    <p>Employee Management System</p>
                </div>

                <div class="spinner"></div>

                <div class="redirect-text">
                    Redirecting to login page...
                </div>

                <a href="Login.aspx" class="login-link">Go to Login</a>
            </div>
        </form>

        <script type="text/javascript">
            // Auto-redirect after 3 seconds
            setTimeout(function () {
                window.location.href = 'Login.aspx';
            }, 3000);
        </script>
    </body>

    </html>