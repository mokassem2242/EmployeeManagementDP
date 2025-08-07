using System;

namespace EmployeService.Models
{
    public class User
    {
        public int UserID { get; set; }
        public string Username { get; set; }
        public string PasswordHash { get; set; }
        public string Email { get; set; }
        public int? RoleID { get; set; }
        public bool IsActive { get; set; }
        public DateTime? LastLoginDate { get; set; }
        public DateTime? CreatedDate { get; set; }

        // Navigation property
        public string RoleName { get; set; }

        public User()
        {
            IsActive = true;
        }
    }
} 