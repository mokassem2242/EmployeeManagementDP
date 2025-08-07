using System;
using System.Data;
using System.Web.Services;
using System.Web.Services.Protocols;
using EmployeService.DataAccess;
using EmployeService.Models;

namespace EmployeService.Services
{
    /// <summary>
    /// Position Web Service for UAE Government Employee Management
    /// </summary>
    [WebService(Namespace = "http://uae.gov.ae/PositionService/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class PositionService : System.Web.Services.WebService
    {
        private readonly PositionDAL _positionDAL;

        public PositionService()
        {
            _positionDAL = new PositionDAL();
        }

        /// <summary>
        /// Get all active positions
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

        /// <summary>
        /// Get position by ID
        /// </summary>
        [WebMethod]
        public DataTable GetPositionById(int positionId)
        {
            try
            {
                if (positionId <= 0)
                    throw new ArgumentException("Position ID must be greater than 0");

                return _positionDAL.GetPositionById(positionId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error retrieving position: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Create new position
        /// </summary>
        [WebMethod]
        public int CreatePosition(string positionTitle, string positionCode, string description)
        {
            try
            {
                if (string.IsNullOrEmpty(positionTitle))
                    throw new ArgumentException("Position title is required");

                var position = new Position
                {
                    PositionTitle = positionTitle,
                    PositionCode = positionCode,
                    Description = description,
                    IsActive = true
                };

                return _positionDAL.InsertPosition(position);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error creating position: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Update existing position
        /// </summary>
        [WebMethod]
        public bool UpdatePosition(int positionId, string positionTitle, string positionCode, string description, bool isActive)
        {
            try
            {
                if (positionId <= 0)
                    throw new ArgumentException("Position ID must be greater than 0");
                if (string.IsNullOrEmpty(positionTitle))
                    throw new ArgumentException("Position title is required");

                var position = new Position
                {
                    PositionID = positionId,
                    PositionTitle = positionTitle,
                    PositionCode = positionCode,
                    Description = description,
                    IsActive = isActive
                };

                return _positionDAL.UpdatePosition(position);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error updating position: " + ex.Message, SoapException.ServerFaultCode);
            }
        }

        /// <summary>
        /// Delete position by ID
        /// </summary>
        [WebMethod]
        public bool DeletePosition(int positionId)
        {
            try
            {
                if (positionId <= 0)
                    throw new ArgumentException("Position ID must be greater than 0");

                return _positionDAL.DeletePosition(positionId);
            }
            catch (Exception ex)
            {
                throw new SoapException("Error deleting position: " + ex.Message, SoapException.ServerFaultCode);
            }
        }
    }
} 