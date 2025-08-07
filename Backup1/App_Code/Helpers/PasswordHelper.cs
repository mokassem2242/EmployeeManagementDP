using System;
using System.Security.Cryptography;
using System.Text;

namespace EmployeService.Helpers
{
    public static class PasswordHelper
    {
        /// <summary>
        /// Hash a password using SHA256
        /// </summary>
        public static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        /// <summary>
        /// Verify a password against a hash
        /// </summary>
        public static bool VerifyPassword(string password, string hash)
        {
            string hashedPassword = HashPassword(password);
            return hashedPassword == hash;
        }

        /// <summary>
        /// Generate a random password
        /// </summary>
        public static string GenerateRandomPassword(int length = 8)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var random = new Random();
            var password = new StringBuilder(length);

            for (int i = 0; i < length; i++)
            {
                password.Append(chars[random.Next(chars.Length)]);
            }

            return password.ToString();
        }
    }
} 