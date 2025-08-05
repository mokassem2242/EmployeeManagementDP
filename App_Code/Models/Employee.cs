using System;

namespace EmployeService.Models
{
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string EmiratesID { get; set; }
        public string PassportNumber { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FullName { get; set; }
        public string Nationality { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string Gender { get; set; }
        public string WorkEmail { get; set; }
        public string PersonalEmail { get; set; }
        public string WorkPhone { get; set; }
        public string PersonalPhone { get; set; }
        public string Emirates { get; set; }
        public string City { get; set; }
        public string District { get; set; }
        public DateTime? HireDate { get; set; }
        public string ContractType { get; set; }
        public string EmploymentStatus { get; set; }
        public int? DepartmentID { get; set; }
        public int? PositionID { get; set; }
        public int? ManagerID { get; set; }
        public string SalaryGrade { get; set; }
        public DateTime? CreatedDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? CreatedBy { get; set; }
        public int? ModifiedBy { get; set; }

        // Navigation properties (for display purposes)
        public string DepartmentName { get; set; }
        public string PositionTitle { get; set; }
        public string ManagerName { get; set; }

        public Employee()
        {
            EmploymentStatus = "Active";
        }
    }
} 