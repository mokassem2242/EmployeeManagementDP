# Master Page Layout Documentation

## Overview

A new master page layout has been implemented for the UAE Government Employee Management System. This provides a consistent navigation and sidebar across all pages with a modern, responsive design.

## Features

### 🎨 **Modern Design**
- Clean, professional government branding
- UAE Government logo and colors (#2E8B57)
- Responsive design for all devices
- Modern typography and spacing

### 📱 **Responsive Layout**
- Fixed header with user information
- Collapsible sidebar navigation
- Mobile-friendly hamburger menu
- Adaptive content areas

### 🧭 **Navigation Structure**
- **Main Dashboard**: Dashboard overview
- **Employee Management**: Manage employees and view profiles
- **System Administration**: User registration and login
- **Services**: Web service endpoints

### 🔧 **Technical Features**
- ASP.NET Web Forms Master Page
- Content placeholders for flexible content
- Session-based user management
- Logout functionality

## File Structure

```
Site.Master              # Main master page file
Site.Master.cs           # Master page code-behind
Site.Master.designer.cs  # Master page designer file
Dashboard.aspx           # Updated to use master page
SamplePage.aspx          # Example page using master page
```

## How to Convert Existing Pages

### Step 1: Update Page Directive
```aspx
<%@ Page Title="Your Page Title" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="YourPage.aspx.cs" Inherits="EmployeService.YourPage" %>
```

### Step 2: Wrap Content in Content Placeholders
```aspx
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- Your CSS styles and scripts here -->
    <style>
        .your-custom-styles { }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Your page content here -->
    <div class="page-header">
        <h1 class="page-title">Your Page Title</h1>
        <p class="page-subtitle">Your page description</p>
    </div>
    
    <div class="content-area">
        <!-- Your main content -->
    </div>
</asp:Content>
```

### Step 3: Remove Existing HTML Structure
- Remove `<!DOCTYPE html>`
- Remove `<html>` tags
- Remove `<head>` tags
- Remove `<body>` tags
- Remove `<form>` tags (master page provides this)

## CSS Classes Available

### Layout Classes
- `.page-header` - Page title section
- `.page-title` - Main page title
- `.page-subtitle` - Page description
- `.content-area` - Main content container

### Utility Classes
- `.text-center` - Center align text
- `.text-right` - Right align text
- `.mb-20` - Margin bottom 20px
- `.mt-20` - Margin top 20px
- `.p-20` - Padding 20px

### Navigation Classes
- `.nav-item` - Navigation menu items
- `.nav-item.active` - Active navigation item
- `.nav-section` - Navigation section container
- `.nav-section-title` - Section titles

## Sidebar Navigation

The sidebar includes organized sections:

### Main Dashboard
- Dashboard overview

### Employee Management
- Manage Employees (AdminEmployeeManagement.aspx)
- My Profile (EmployeeView.aspx)

### System Administration
- Register User (Register.aspx)
- Login (Login.aspx)

### Services
- Authentication Service (AuthService.asmx)
- Employee Service (EmployeeService.asmx)
- Department Service (DepartmentService.asmx)
- Position Service (PositionService.asmx)

## Mobile Responsiveness

### Desktop (>1024px)
- Sidebar always visible
- Full navigation menu

### Tablet (768px - 1024px)
- Collapsible sidebar
- Hamburger menu button
- Overlay when sidebar is open

### Mobile (<768px)
- Hidden sidebar by default
- Hamburger menu
- Overlay background
- Simplified header

## User Management

The master page handles:
- User name display from session
- User role display from session
- Logout functionality
- Session clearing on logout

## Browser Compatibility

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Internet Explorer 11+

## Customization

### Colors
The primary color scheme uses:
- Primary: #2E8B57 (Sea Green)
- Background: #F5F5F5 (Light Gray)
- Text: #333333 (Dark Gray)
- Secondary Text: #666666 (Medium Gray)

### Fonts
- Primary: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif
- Icons: Font Awesome 6.4.0

## Example Implementation

See `SamplePage.aspx` for a complete example of how to implement the master page layout.

## Migration Checklist

- [ ] Update Page directive with MasterPageFile
- [ ] Remove DOCTYPE and HTML structure
- [ ] Wrap styles in HeadContent placeholder
- [ ] Wrap content in MainContent placeholder
- [ ] Add page header with title and subtitle
- [ ] Wrap main content in content-area div
- [ ] Test responsive behavior
- [ ] Verify navigation links work
- [ ] Check user session handling

## Support

For questions or issues with the master page implementation, refer to the code examples in:
- `Site.Master` - Main master page
- `Dashboard.aspx` - Updated dashboard
- `SamplePage.aspx` - Example implementation 