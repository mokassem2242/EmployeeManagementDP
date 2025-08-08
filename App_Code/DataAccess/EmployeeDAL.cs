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
        /// When searchTerm is provided, it overrides department and employment status filters
        /// When searchTerm is null, both department and employment status filters are applied together
        /// </summary>
        public DataTable SearchEmployees(string searchTerm = null, int? departmentId = null, string employmentStatus = null)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    using (SqlCommand command = new SqlCommand("sp_Employee_Search", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Add parameters with proper null handling
                        command.Parameters.AddWithValue("@SearchTerm",((object)searchTerm)=="" ? DBNull.Value: (object)searchTerm);
                        command.Parameters.AddWithValue("@DepartmentID", (object)departmentId ?? DBNull.Value);
                        command.Parameters.AddWithValue("@EmploymentStatus", (object)employmentStatus=="" ? DBNull.Value : (object)employmentStatus);

                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable("Employees");
                        adapter.Fill(dataTable);

                        return dataTable;
                    }
                }
            }
            catch (Exception ex)
            {
                // Log or handle the exception
                // throw new Exception($"Error searching employees: {ex.Message}", ex);

                // Return an empty DataTable to satisfy method return type
                return new DataTable("Employees");
            }
        }


        public DataTable GetEmployeesByDepartment(int departmentId)
        {
            // Return employees filtered by department only
            return SearchEmployees(null, departmentId, null);
        }

     
        public DataTable GetEmployeesByStatus(string employmentStatus)
        {
            return SearchEmployees(null, null, employmentStatus);
        }

       
        public DataTable GetEmployeeByUserId(int userId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_GetByUserId", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@UserID", userId);
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Employees");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

      
        public DataTable GetEmployeesByIds(List<int> employeeIds)
        {
            if (employeeIds == null || employeeIds.Count == 0)
                return new DataTable("Employees");

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Employee_GetByIds", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    // Create a table-valued parameter for the employee IDs
                    DataTable idTable = new DataTable();
                    idTable.Columns.Add("EmployeeID", typeof(int));
                    foreach (int id in employeeIds)
                    {
                        idTable.Rows.Add(id);
                    }
                    
                    SqlParameter parameter = command.Parameters.AddWithValue("@EmployeeIDs", idTable);
                    parameter.SqlDbType = SqlDbType.Structured;
                    parameter.TypeName = "IntList";
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Employees");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }
    }
} 