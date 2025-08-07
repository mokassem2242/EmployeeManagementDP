using System;
using System.Data;
using System.Web.Services;
using System.Web.Services.Protocols;
using EmployeService.DataAccess;
using EmployeService.Models;

namespace EmployeService.Services
{
    /// <summary>
    /// Department Web Service for UAE Government Employee Management
    /// </summary>
    [WebService(Namespace = "http://uae.gov.ae/DepartmentService/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class DepartmentService : System.Web.Services.WebService
    {
        private readonly DepartmentDAL _departmentDAL;

        public DepartmentService()
        {
            _departmentDAL = new DepartmentDAL();
        }

        /// <summary>
        /// Get all active departments
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
        /// Get department by ID
        /// </summary>
        [WebMethod]
        public DataTable GetDepartmentById(int departmentId)
        {
            try
            {
                if (departmentId <= 0)
                    throw new ArgumentException("Department ID must be greater than 0");

                return _departmentDAL.GetDepartmentById(departmentId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving department: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Create new department
        /// </summary>
        [WebMethod]
        public int CreateDepartment(string departmentName, string departmentCode, string description)
        {
            try
            {
                if (string.IsNullOrEmpty(departmentName))
                    throw new ArgumentException("Department name is required");

                var department = new Department
                {
                    DepartmentName = departmentName,
                    DepartmentCode = departmentCode,
                    Description = description,
                    IsActive = true
                };

                return _departmentDAL.InsertDepartment(department);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error creating department: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Update existing department
        /// </summary>
        [WebMethod]
        public bool UpdateDepartment(int departmentId, string departmentName, string departmentCode, string description, bool isActive)
        {
            try
            {
                if (departmentId <= 0)
                    throw new ArgumentException("Department ID must be greater than 0");
                if (string.IsNullOrEmpty(departmentName))
                    throw new ArgumentException("Department name is required");

                var department = new Department
                {
                    DepartmentID = departmentId,
                    DepartmentName = departmentName,
                    DepartmentCode = departmentCode,
                    Description = description,
                    IsActive = isActive
                };

                return _departmentDAL.UpdateDepartment(department);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error updating department: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Delete department by ID
        /// </summary>
        [WebMethod]
        public bool DeleteDepartment(int departmentId)
        {
            try
            {
                if (departmentId <= 0)
                    throw new ArgumentException("Department ID must be greater than 0");

                return _departmentDAL.DeleteDepartment(departmentId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error deleting department: " + ex.Message, SoapException.ServerFaultCode);
            }
        }
    }
} 