using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using EmployeService.Models;

namespace EmployeService.DataAccess
{
    public class EmployeeDAL
    {
        private readonly string _connectionString;

        public EmployeeDAL()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"] != null ? ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"].ConnectionString : null;
            if (string.IsNullOrEmpty(_connectionString))
                throw new Exception("Connection string 'UAE_EmployeeDB' not found in Web.config");
        }

        /// <summary>
        /// Get all employees with department and position information
        /// </summary>
        public DataTable GetAllEmployees()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_GetAll", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Employees");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// Get employee by ID
        /// </summary>
        public DataTable GetEmployeeById(int employeeId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_GetById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@EmployeeID", employeeId);
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Employees");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// Insert new employee
        /// </summary>
        public int InsertEmployee(Employee employee)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_Insert", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    // Add parameters
                    command.Parameters.AddWithValue("@EmiratesID", employee.EmiratesID);
                    command.Parameters.AddWithValue("@PassportNumber", (object)employee.PassportNumber ?? DBNull.Value);
                    command.Parameters.AddWithValue("@FirstName", employee.FirstName);
                    command.Parameters.AddWithValue("@LastName", employee.LastName);
                    command.Parameters.AddWithValue("@Nationality", (object)employee.Nationality ?? DBNull.Value);
                    command.Parameters.AddWithValue("@DateOfBirth", (object)employee.DateOfBirth ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Gender", (object)employee.Gender ?? DBNull.Value);
                    command.Parameters.AddWithValue("@WorkEmail", (object)employee.WorkEmail ?? DBNull.Value);
                    command.Parameters.AddWithValue("@PersonalEmail", (object)employee.PersonalEmail ?? DBNull.Value);
                    command.Parameters.AddWithValue("@WorkPhone", (object)employee.WorkPhone ?? DBNull.Value);
                    command.Parameters.AddWithValue("@PersonalPhone", (object)employee.PersonalPhone ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Emirates", (object)employee.Emirates ?? DBNull.Value);
                    command.Parameters.AddWithValue("@City", (object)employee.City ?? DBNull.Value);
                    command.Parameters.AddWithValue("@District", (object)employee.District ?? DBNull.Value);
                    command.Parameters.AddWithValue("@HireDate", (object)employee.HireDate ?? DBNull.Value);
                    command.Parameters.AddWithValue("@ContractType", (object)employee.ContractType ?? DBNull.Value);
                    command.Parameters.AddWithValue("@EmploymentStatus", employee.EmploymentStatus ?? "Active");
                    command.Parameters.AddWithValue("@DepartmentID", (object)employee.DepartmentID ?? DBNull.Value);
                    command.Parameters.AddWithValue("@PositionID", (object)employee.PositionID ?? DBNull.Value);
                    command.Parameters.AddWithValue("@ManagerID", (object)employee.ManagerID ?? DBNull.Value);
                    command.Parameters.AddWithValue("@SalaryGrade", (object)employee.SalaryGrade ?? DBNull.Value);
                    command.Parameters.AddWithValue("@CreatedBy", employee.CreatedBy);
                    
                    connection.Open();
                    object result = command.ExecuteScalar();
                    return Convert.ToInt32(result);
                }
            }
        }

        /// <summary>
        /// Update existing employee
        /// </summary>
        public bool UpdateEmployee(Employee employee)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_Update", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    // Add parameters
                    command.Parameters.AddWithValue("@EmployeeID", employee.EmployeeID);
                    command.Parameters.AddWithValue("@EmiratesID", employee.EmiratesID);
                    command.Parameters.AddWithValue("@PassportNumber", (object)employee.PassportNumber ?? DBNull.Value);
                    command.Parameters.AddWithValue("@FirstName", employee.FirstName);
                    command.Parameters.AddWithValue("@LastName", employee.LastName);
                    command.Parameters.AddWithValue("@Nationality", (object)employee.Nationality ?? DBNull.Value);
                    command.Parameters.AddWithValue("@DateOfBirth", (object)employee.DateOfBirth ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Gender", (object)employee.Gender ?? DBNull.Value);
                    command.Parameters.AddWithValue("@WorkEmail", (object)employee.WorkEmail ?? DBNull.Value);
                    command.Parameters.AddWithValue("@PersonalEmail", (object)employee.PersonalEmail ?? DBNull.Value);
                    command.Parameters.AddWithValue("@WorkPhone", (object)employee.WorkPhone ?? DBNull.Value);
                    command.Parameters.AddWithValue("@PersonalPhone", (object)employee.PersonalPhone ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Emirates", (object)employee.Emirates ?? DBNull.Value);
                    command.Parameters.AddWithValue("@City", (object)employee.City ?? DBNull.Value);
                    command.Parameters.AddWithValue("@District", (object)employee.District ?? DBNull.Value);
                    command.Parameters.AddWithValue("@HireDate", (object)employee.HireDate ?? DBNull.Value);
                    command.Parameters.AddWithValue("@ContractType", (object)employee.ContractType ?? DBNull.Value);
                    command.Parameters.AddWithValue("@EmploymentStatus", employee.EmploymentStatus ?? "Active");
                    command.Parameters.AddWithValue("@DepartmentID", (object)employee.DepartmentID ?? DBNull.Value);
                    command.Parameters.AddWithValue("@PositionID", (object)employee.PositionID ?? DBNull.Value);
                    command.Parameters.AddWithValue("@ManagerID", (object)employee.ManagerID ?? DBNull.Value);
                    command.Parameters.AddWithValue("@SalaryGrade", (object)employee.SalaryGrade ?? DBNull.Value);
                    command.Parameters.AddWithValue("@ModifiedBy", employee.ModifiedBy);
                    
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        /// <summary>
        /// Delete employee by ID
        /// </summary>
        public bool DeleteEmployee(int employeeId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_Delete", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@EmployeeID", employeeId);
                    
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        /// <summary>
        /// Search employees with filters
        /// </summary>
        public DataTable SearchEmployees(string searchTerm = null, int? departmentId = null, string employmentStatus = null)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_Search", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    command.Parameters.AddWithValue("@SearchTerm", (object)searchTerm ?? DBNull.Value);
                    command.Parameters.AddWithValue("@DepartmentID", (object)departmentId ?? DBNull.Value);
                    command.Parameters.AddWithValue("@EmploymentStatus", (object)employmentStatus ?? DBNull.Value);
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Employees");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// Get employees by department
        /// </summary>
        public DataTable GetEmployeesByDepartment(int departmentId)
        {
            return SearchEmployees(null, departmentId, null);
        }

        /// <summary>
        /// Get employees by employment status
        /// </summary>
        public DataTable GetEmployeesByStatus(string employmentStatus)
        {
            return SearchEmployees(null, null, employmentStatus);
        }
    }
} 