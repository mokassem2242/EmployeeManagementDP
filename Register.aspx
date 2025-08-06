<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="EmployeService.Register" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>Register - UAE Government Employee Management</title>
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
                padding: 20px;
            }

            .register-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(182, 138, 53, 0.1);
                padding: 40px;
                width: 100%;
                max-width: 500px;
                position: relative;
                overflow: hidden;
            }

            .register-container::before {
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

            .form-row {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .form-group {
                flex: 1;
            }

            .form-group.full-width {
                flex: none;
                width: 100%;
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

            .password-strength {
                margin-top: 5px;
                font-size: 12px;
                padding: 5px 10px;
                border-radius: 5px;
                display: none;
            }

            .strength-weak {
                background: #F2ECCF;
                color: #6C4527;
                border: 1px solid #D7BC6D;
            }

            .strength-medium {
                background: #E6D7A2;
                color: #5D3B26;
                border: 1px solid #CBA344;
            }

            .strength-strong {
                background: #D7BC6D;
                color: white;
                border: 1px solid #B68A35;
            }

            .btn-register {
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

            .btn-register:hover {
                background: linear-gradient(135deg, #92722A 0%, #B68A35 100%);
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(182, 138, 53, 0.3);
            }

            .btn-register:active {
                transform: translateY(0);
            }

            .btn-register:disabled {
                background: #E6D7A2;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
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

            .requirements {
                background: #F9F7ED;
                border: 1px solid #E6D7A2;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 20px;
                font-size: 12px;
                color: #6C4527;
            }

            .requirements h4 {
                margin-bottom: 8px;
                color: #B68A35;
                font-size: 14px;
            }

            .requirements ul {
                margin: 0;
                padding-left: 20px;
            }

            .requirements li {
                margin-bottom: 3px;
            }

            @media (max-width: 600px) {
                .register-container {
                    margin: 10px;
                    padding: 30px 20px;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="register-container">
                <div class="logo">
                    <h1>UAE Government</h1>
                    <p>Employee Management System - Registration</p>
                </div>

                <div id="errorMessage" class="error-message" runat="server"></div>
                <div id="successMessage" class="success-message" runat="server"></div>

                <div class="requirements">
                    <h4>Password Requirements:</h4>
                    <ul>
                        <li>Minimum 8 characters</li>
                        <li>At least one uppercase letter</li>
                        <li>At least one lowercase letter</li>
                        <li>At least one number</li>
                    </ul>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="txtFirstName">First Name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"
                            placeholder="Enter first name" required="required"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtLastName">Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"
                            placeholder="Enter last name" required="required"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtUsername">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a username"
                        required="required"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtEmail">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control"
                        placeholder="Enter your email" required="required"></asp:TextBox>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"
                            placeholder="Enter password" required="required" onkeyup="checkPasswordStrength()">
                        </asp:TextBox>
                        <div id="passwordStrength" class="password-strength"></div>
                    </div>
                    <div class="form-group">
                        <label for="txtConfirmPassword">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"
                            placeholder="Confirm password" required="required"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="ddlRole">Role</label>
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control" required="required">
                        <asp:ListItem Text="Select a role" Value="" />
                    </asp:DropDownList>
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-register"
                    OnClick="btnRegister_Click" />

                <div class="loading" id="loadingDiv">
                    <div class="spinner"></div>
                    <span style="margin-left: 10px; color: #92722A;">Creating account...</span>
                </div>

                <div class="links">
                    <a href="Login.aspx">Already have an account? Login here</a>
                </div>
            </div>
        </form>

        <script type="text/javascript">
            function checkPasswordStrength() {
                var password = document.getElementById('<%= txtPassword.ClientID %>').value;
                var strengthDiv = document.getElementById('passwordStrength');

                if (password.length === 0) {
                    strengthDiv.style.display = 'none';
                    return;
                }

                var strength = 0;
                var feedback = '';

                // Check length
                if (password.length >= 8) strength++;
                else feedback += 'At least 8 characters. ';

                // Check for uppercase
                if (/[A-Z]/.test(password)) strength++;
                else feedback += 'One uppercase letter. ';

                // Check for lowercase
                if (/[a-z]/.test(password)) strength++;
                else feedback += 'One lowercase letter. ';

                // Check for numbers
                if (/[0-9]/.test(password)) strength++;
                else feedback += 'One number. ';

                strengthDiv.style.display = 'block';
                strengthDiv.className = 'password-strength';

                if (strength <= 2) {
                    strengthDiv.classList.add('strength-weak');
                    strengthDiv.textContent = 'Weak: ' + feedback;
                } else if (strength === 3) {
                    strengthDiv.classList.add('strength-medium');
                    strengthDiv.textContent = 'Medium: ' + feedback;
                } else {
                    strengthDiv.classList.add('strength-strong');
                    strengthDiv.textContent = 'Strong password!';
                }
            }

            function showLoading() {
                document.getElementById('loadingDiv').style.display = 'block';
                document.getElementById('btnRegister').disabled = true;
            }

            function hideLoading() {
                document.getElementById('loadingDiv').style.display = 'none';
                document.getElementById('btnRegister').disabled = false;
            }

            // Show loading when form is submitted
            document.getElementById('form1').addEventListener('submit', function () {
                showLoading();
            });
        </script>
    </body>

    </html>