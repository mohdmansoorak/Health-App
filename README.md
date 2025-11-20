# HealthGuard - Health Insurance App

A comprehensive health insurance management application built with React, featuring a beautiful blue color theme.

## Features

### Authentication
- User login and registration
- Secure password handling
- Remember me functionality

### Dashboard
- Policy overview with quick stats
- Recent claims and payments
- Quick action buttons
- Notifications

### Policy Management
- View all active policies
- Detailed policy information
- Coverage benefits breakdown
- Covered family members

### Claims Management
- File new claims with document upload
- Track claim status (pending, approved, denied)
- Claims history with filters
- Search functionality

### Healthcare Providers
- Find in-network doctors and hospitals
- Filter by type and specialty
- View ratings and availability
- Schedule appointments

### Digital ID Card
- View insurance ID card
- Download as PDF
- Print functionality
- Coverage summary

### Payments
- Pay premiums online
- Multiple payment methods
- Payment history
- Auto-pay settings

### Profile & Settings
- Personal information management
- Family members
- Notification preferences
- Account security settings

### Support
- FAQ section
- Contact options (phone, chat, email)
- Submit support tickets
- Resource links

## Tech Stack

- React 18
- React Router DOM v6
- Lucide React (icons)
- CSS-in-JS styling

## Color Theme

The app uses a professional blue color palette:
- Primary: #2563eb
- Primary Dark: #1e40af
- Primary Light: #3b82f6
- Background: #f9fafb

## Getting Started

### Prerequisites
- Node.js 16+
- npm or yarn

### Installation

```bash
# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build
```

### Demo Access
Use any email and password to log in and explore the app.

## Project Structure

```
src/
├── components/
│   └── Layout.js
├── context/
│   └── AppContext.js
├── data/
│   └── mockData.js
├── pages/
│   ├── Login.js
│   ├── Register.js
│   ├── Dashboard.js
│   ├── Policies.js
│   ├── PolicyDetails.js
│   ├── Claims.js
│   ├── FileClaim.js
│   ├── Providers.js
│   ├── IDCard.js
│   ├── Payments.js
│   ├── Profile.js
│   └── Support.js
├── styles/
│   └── global.css
├── App.js
└── index.js
```

## License

MIT License
