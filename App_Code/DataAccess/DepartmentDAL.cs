using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using EmployeService.Models;

namespace EmployeService.DataAccess
{
    public class DepartmentDAL
    {
        private readonly string _connectionString;

        public DepartmentDAL()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"]?.ConnectionString;
            if (string.IsNullOrEmpty(_connectionString))
                throw new Exception("Connection string 'UAE_EmployeeDB' not found in Web.config");
        }

        /// <summary>
        /// Get all active departments
        /// </summary>
        public DataTable GetAllDepartments()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Department_GetAll", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Departments");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// Get department by ID
        /// </summary>
        public DataTable GetDepartmentById(int departmentId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Department_GetById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@DepartmentID", departmentId);
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Departments");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// Insert new department
        /// </summary>
        public int InsertDepartment(Department department)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Department_Insert", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    command.Parameters.AddWithValue("@DepartmentName", department.DepartmentName);
                    command.Parameters.AddWithValue("@DepartmentCode", (object)department.DepartmentCode ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Description", (object)department.Description ?? DBNull.Value);
                    command.Parameters.AddWithValue("@IsActive", department.IsActive);
                    
                    connection.Open();
                    object result = command.ExecuteScalar();
                    return Convert.ToInt32(result);
                }
            }
        }

        /// <summary>
        /// Update existing department
        /// </summary>
        public bool UpdateDepartment(Department department)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Department_Update", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    command.Parameters.AddWithValue("@DepartmentID", department.DepartmentID);
                    command.Parameters.AddWithValue("@DepartmentName", department.DepartmentName);
                    command.Parameters.AddWithValue("@DepartmentCode", (object)department.DepartmentCode ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Description", (object)department.Description ?? DBNull.Value);
                    command.Parameters.AddWithValue("@IsActive", department.IsActive);
                    
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        /// <summary>
        /// Delete department by ID
        /// </summary>
        public bool DeleteDepartment(int departmentId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Department_Delete", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@DepartmentID", departmentId);
                    
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }
    }
} 