using System;

namespace EmployeService.Models
{
    public class Position
    {
        public int PositionID { get; set; }
        public string PositionTitle { get; set; }
        public string PositionCode { get; set; }
        public string Description { get; set; }
        public bool IsActive { get; set; }

        public Position()
        {
            IsActive = true;
        }
    }
} 