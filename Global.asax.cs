using System;
using System.Web;

namespace EmployeService
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            try
            {
                System.Diagnostics.Debug.WriteLine("Application starting - initializing database...");
                // Initialize database on application startup
                DatabaseInitializer.InitializeDatabase();
                System.Diagnostics.Debug.WriteLine("Application startup completed successfully.");
            }
            catch (Exception ex)
            {
                // Log the error but don't crash the application
                System.Diagnostics.Debug.WriteLine($"Application startup error: {ex.Message}");
            }
        }

        void Application_End(object sender, EventArgs e)
        {
            // Code that runs on application shutdown
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started
        }

        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends
        }
    }
} 