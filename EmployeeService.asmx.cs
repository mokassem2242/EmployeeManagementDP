using EmployeService.DataAccess;
using EmployeService.Models;
using System;
using System.Data;
using System.Web.Services;
using System.Web.Services.Protocols;

namespace EmployeService.Services
{
    /// <summary>
    /// Employee Web Service for UAE Government Employee Management
    /// </summary>
    [WebService(Namespace = "http://uae.gov.ae/EmployeeService/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class EmployeeService : System.Web.Services.WebService
    {
        private readonly EmployeeDAL _employeeDAL;
        private readonly DepartmentDAL _departmentDAL;
        private readonly PositionDAL _positionDAL;

        public EmployeeService()
        {
            _employeeDAL = new EmployeeDAL();
            _departmentDAL = new DepartmentDAL();
            _positionDAL = new PositionDAL();
        }

        /// <summary>
        /// Get all employees with department and position information
        /// </summary>
        [WebMethod]
        public DataTable GetAllEmployees()
        {
            try
            {
                return _employeeDAL.GetAllEmployees();
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving employees: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Get employee by ID
        /// </summary>
        [WebMethod]
        public DataTable GetEmployeeById(int employeeId)
        {
            try
            {
                if (employeeId <= 0)
                    throw new ArgumentException("Employee ID must be greater than 0");

                return _employeeDAL.GetEmployeeById(employeeId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving employee: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Insert new employee
        /// </summary>
        [WebMethod]
        public int InsertEmployee(string emiratesId, string passportNumber, string firstName, string lastName,
            string nationality, DateTime? dateOfBirth, string gender, string workEmail, string personalEmail,
            string workPhone, string personalPhone, string emirates, string city, string district,
            DateTime? hireDate, string contractType, string employmentStatus, int? departmentId, int? positionId,
            int? managerId, string salaryGrade, int createdBy)
        {
            try
            {
                // Validate required fields
                if (string.IsNullOrEmpty(emiratesId))
                    throw new ArgumentException("Emirates ID is required");
                if (string.IsNullOrEmpty(firstName))
                    throw new ArgumentException("First Name is required");
                if (string.IsNullOrEmpty(lastName))
                    throw new ArgumentException("Last Name is required");

                var employee = new Employee
                {
                    EmiratesID = emiratesId,
                    PassportNumber = passportNumber,
                    FirstName = firstName,
                    LastName = lastName,
                    Nationality = nationality,
                    DateOfBirth = dateOfBirth,
                    Gender = gender,
                    WorkEmail = workEmail,
                    PersonalEmail = personalEmail,
                    WorkPhone = workPhone,
                    PersonalPhone = personalPhone,
                    Emirates = emirates,
                    City = city,
                    District = district,
                    HireDate = hireDate,
                    ContractType = contractType,
                    EmploymentStatus = employmentStatus ?? "Active",
                    DepartmentID = departmentId,
                    PositionID = positionId,
                    ManagerID = managerId,
                    SalaryGrade = salaryGrade,
                    CreatedBy = createdBy
                };

                return _employeeDAL.InsertEmployee(employee);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error inserting employee: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Update existing employee
        /// </summary>
        [WebMethod]
        public bool UpdateEmployee(int employeeId, string emiratesId, string passportNumber, string firstName, string lastName,
            string nationality, DateTime? dateOfBirth, string gender, string workEmail, string personalEmail,
            string workPhone, string personalPhone, string emirates, string city, string district,
            DateTime? hireDate, string contractType, string employmentStatus, int? departmentId, int? positionId,
            int? managerId, string salaryGrade, int modifiedBy)
        {
            try
            {
                // Validate required fields
                if (employeeId <= 0)
                    throw new ArgumentException("Employee ID must be greater than 0");
                if (string.IsNullOrEmpty(emiratesId))
                    throw new ArgumentException("Emirates ID is required");
                if (string.IsNullOrEmpty(firstName))
                    throw new ArgumentException("First Name is required");
                if (string.IsNullOrEmpty(lastName))
                    throw new ArgumentException("Last Name is required");

                var employee = new Employee
                {
                    EmployeeID = employeeId,
                    EmiratesID = emiratesId,
                    PassportNumber = passportNumber,
                    FirstName = firstName,
                    LastName = lastName,
                    Nationality = nationality,
                    DateOfBirth = dateOfBirth,
                    Gender = gender,
                    WorkEmail = workEmail,
                    PersonalEmail = personalEmail,
                    WorkPhone = workPhone,
                    PersonalPhone = personalPhone,
                    Emirates = emirates,
                    City = city,
                    District = district,
                    HireDate = hireDate,
                    ContractType = contractType,
                    EmploymentStatus = employmentStatus ?? "Active",
                    DepartmentID = departmentId,
                    PositionID = positionId,
                    ManagerID = managerId,
                    SalaryGrade = salaryGrade,
                    ModifiedBy = modifiedBy
                };

                return _employeeDAL.UpdateEmployee(employee);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error updating employee: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Delete employee by ID
        /// </summary>
        [WebMethod]
        public bool DeleteEmployee(int employeeId)
        {
            try
            {
                if (employeeId <= 0)
                    throw new ArgumentException("Employee ID must be greater than 0");

                return _employeeDAL.DeleteEmployee(employeeId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error deleting employee: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Search employees with filters
        /// </summary>
        [WebMethod]
        public DataTable SearchEmployees(string searchTerm, int? departmentId, string employmentStatus)
        {
            try
            {
                return _employeeDAL.SearchEmployees(searchTerm, employmentStatus);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error searching employees: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Get employees by department
        /// </summary>
        [WebMethod]
        public DataTable GetEmployeesByDepartment(int departmentId)
        {
            try
            {
                if (departmentId <= 0)
                    throw new ArgumentException("Department ID must be greater than 0");

                return _employeeDAL.GetEmployeesByDepartment(departmentId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving employees by department: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Get employees by employment status
        /// </summary>
        [WebMethod]
        public DataTable GetEmployeesByStatus(string employmentStatus)
        {
            try
            {
                if (string.IsNullOrEmpty(employmentStatus))
                    throw new ArgumentException("Employment status is required");

                return _employeeDAL.GetEmployeesByStatus(employmentStatus);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving employees by status: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Get all departments for dropdown
        /// </summary>
        [WebMethod]
        public DataTable GetAllDepartments()
        {
            try
            {
                return _departmentDAL.GetAllDepartments();
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving departments: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Get all positions for dropdown
        /// </summary>
        [WebMethod]
        public DataTable GetAllPositions()
        {
            try
            {
                return _positionDAL.GetAllPositions();
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving positions: " + ex.Message, SoapException.ServerFaultCode);
            }
        }
    }
} 