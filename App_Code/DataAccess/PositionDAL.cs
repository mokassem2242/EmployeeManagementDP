using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using EmployeService.Models;

namespace EmployeService.DataAccess
{
    public class PositionDAL
    {
        private readonly string _connectionString;

        public PositionDAL()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"] != null ? ConfigurationManager.ConnectionStrings["UAE_EmployeeDB"].ConnectionString : null;
            if (string.IsNullOrEmpty(_connectionString))
                throw new Exception("Connection string 'UAE_EmployeeDB' not found in Web.config");
        }

        /// <summary>
        /// Get all active positions
        /// </summary>
        public DataTable GetAllPositions()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Position_GetAll", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Positions");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// Get position by ID
        /// </summary>
        public DataTable GetPositionById(int positionId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Position_GetById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@PositionID", positionId);
                    
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable("Positions");
                    adapter.Fill(dataTable);
                    
                    return dataTable;
                }
            }
        }

        /// <summary>
        /// Insert new position
        /// </summary>
        public int InsertPosition(Position position)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Position_Insert", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    command.Parameters.AddWithValue("@PositionTitle", position.PositionTitle);
                    command.Parameters.AddWithValue("@PositionCode", (object)position.PositionCode ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Description", (object)position.Description ?? DBNull.Value);
                    command.Parameters.AddWithValue("@IsActive", position.IsActive);
                    
                    connection.Open();
                    object result = command.ExecuteScalar();
                    return Convert.ToInt32(result);
                }
            }
        }

        /// <summary>
        /// Update existing position
        /// </summary>
        public bool UpdatePosition(Position position)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Position_Update", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    
                    command.Parameters.AddWithValue("@PositionID", position.PositionID);
                    command.Parameters.AddWithValue("@PositionTitle", position.PositionTitle);
                    command.Parameters.AddWithValue("@PositionCode", (object)position.PositionCode ?? DBNull.Value);
                    command.Parameters.AddWithValue("@Description", (object)position.Description ?? DBNull.Value);
                    command.Parameters.AddWithValue("@IsActive", position.IsActive);
                    
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        /// <summary>
        /// Delete position by ID
        /// </summary>
        public bool DeletePosition(int positionId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("sp_Position_Delete", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@PositionID", positionId);
                    
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }
    }
} 