using System;
using System.Data;
using System.Linq;
using System.Web.Services;
using System.Web.Services.Protocols;
using EmployeService.DataAccess;
using EmployeService.Models;
using EmployeService.Helpers;

namespace EmployeService.Services
{
    /// <summary>
    /// Authentication Web Service for UAE Government Employee Management
    /// </summary>
    [WebService(Namespace = "http://uae.gov.ae/AuthService/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class AuthService : System.Web.Services.WebService
    {
        private readonly UserDAL _userDAL;

        public AuthService()
        {
            _userDAL = new UserDAL();
        }

        /// <summary>
        /// Authenticate user with username and password
        /// </summary>
        [WebMethod]
        public DataTable AuthenticateUser(string username, string password)
        {
            try
            {
                if (string.IsNullOrEmpty(username))
                    throw new ArgumentException("Username is required");
                if (string.IsNullOrEmpty(password))
                    throw new ArgumentException("Password is required");

                // Hash the password before authentication
                string hashedPassword = PasswordHelper.HashPassword(password);
                
                return _userDAL.AuthenticateUser(username, hashedPassword);
            }
            catch (Exception ex)
            {
                throw new SoapException("Authentication failed: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Get user by ID
        /// </summary>
        [WebMethod]
        public DataTable GetUserById(int userId)
        {
            try
            {
                if (userId <= 0)
                    throw new ArgumentException("User ID must be greater than 0");

                return _userDAL.GetUserById(userId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving user: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Create new user
        /// </summary>
        [WebMethod]
        public int CreateUser(string username, string password, string email, int roleId)
        {
            try
            {
                if (string.IsNullOrEmpty(username))
                    throw new ArgumentException("Username is required");
                if (string.IsNullOrEmpty(password))
                    throw new ArgumentException("Password is required");
                if (roleId <= 0)
                    throw new ArgumentException("Role ID must be greater than 0");

                // Hash the password
                string hashedPassword = PasswordHelper.HashPassword(password);

                var user = new User
                {
                    Username = username,
                    PasswordHash = hashedPassword,
                    Email = email,
                    RoleID = roleId,
                    IsActive = true
                };

                return _userDAL.InsertUser(user);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error creating user: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Update user password
        /// </summary>
        [WebMethod]
        public bool UpdateUserPassword(int userId, string newPassword)
        {
            try
            {
                if (userId <= 0)
                    throw new ArgumentException("User ID must be greater than 0");
                if (string.IsNullOrEmpty(newPassword))
                    throw new ArgumentException("New password is required");

                // Get current user
                DataTable userData = _userDAL.GetUserById(userId);
                if (userData.Rows.Count == 0)
                    throw new ArgumentException("User not found");

                // Hash the new password
                string hashedPassword = PasswordHelper.HashPassword(newPassword);

                var user = new User
                {
                    UserID = userId,
                    Username = userData.Rows[0]["Username"].ToString(),
                    PasswordHash = hashedPassword,
                    Email = userData.Rows[0]["Email"] != null ? userData.Rows[0]["Email"].ToString() : null,
                    RoleID = Convert.ToInt32(userData.Rows[0]["RoleID"]),
                    IsActive = Convert.ToBoolean(userData.Rows[0]["IsActive"])
                };

                return _userDAL.UpdateUser(user);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error updating password: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Update user's last login date
        /// </summary>
        [WebMethod]
        public bool UpdateLastLoginDate(int userId)
        {
            try
            {
                if (userId <= 0)
                    throw new ArgumentException("User ID must be greater than 0");

                return _userDAL.UpdateLastLoginDate(userId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error updating last login date: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Get all roles
        /// </summary>
        [WebMethod]
        public DataTable GetAllRoles()
        {
            try
            {
                return _userDAL.GetAllRoles();
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving roles: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Verify password strength
        /// </summary>
        [WebMethod]
        public bool IsPasswordStrong(string password)
        {
            try
            {
                if (string.IsNullOrEmpty(password))
                    return false;

                // Check minimum length
                if (password.Length < 8)
                    return false;

                // Check for at least one uppercase letter
                if (!password.Any(char.IsUpper))
                    return false;

                // Check for at least one lowercase letter
                if (!password.Any(char.IsLower))
                    return false;

                // Check for at least one digit
                if (!password.Any(char.IsDigit))
                    return false;

                return true;
            }
            catch (Exception ex)
            {
                throw new SoapException("Error checking password strength: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Generate random password
        /// </summary>
        [WebMethod]
        public string GenerateRandomPassword(int length = 8)
        {
            try
            {
                if (length < 6)
                    length = 6;
                if (length > 20)
                    length = 20;

                return PasswordHelper.GenerateRandomPassword(length);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error generating password: " + ex.Message, SoapException.ServerFaultCode);
            }
        }
    }
} 