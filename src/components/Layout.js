import React, { useState } from 'react';
import { Outlet, NavLink, useNavigate } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import {
  LayoutDashboard,
  FileText,
  ClipboardList,
  MapPin,
  CreditCard,
  User,
  HelpCircle,
  LogOut,
  Menu,
  X,
  Bell,
  Shield,
  BadgeCheck
} from 'lucide-react';

const Layout = () => {
  const { user, logout, notifications } = useApp();
  const navigate = useNavigate();
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [showNotifications, setShowNotifications] = useState(false);

  const unreadCount = notifications.filter(n => !n.read).length;

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const navItems = [
    { to: '/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
    { to: '/policies', icon: FileText, label: 'My Policies' },
    { to: '/claims', icon: ClipboardList, label: 'Claims' },
    { to: '/providers', icon: MapPin, label: 'Find Providers' },
    { to: '/id-card', icon: BadgeCheck, label: 'ID Card' },
    { to: '/payments', icon: CreditCard, label: 'Payments' },
    { to: '/profile', icon: User, label: 'Profile' },
    { to: '/support', icon: HelpCircle, label: 'Support' },
  ];

  return (
    <div style={styles.container}>
      {/* Mobile Header */}
      <header style={styles.mobileHeader}>
        <button onClick={() => setSidebarOpen(true)} style={styles.menuButton}>
          <Menu size={24} />
        </button>
        <div style={styles.logo}>
          <Shield size={24} color="#2563eb" />
          <span style={styles.logoText}>HealthGuard</span>
        </div>
        <button
          onClick={() => setShowNotifications(!showNotifications)}
          style={styles.notificationButton}
        >
          <Bell size={24} />
          {unreadCount > 0 && <span style={styles.badge}>{unreadCount}</span>}
        </button>
      </header>

      {/* Sidebar Overlay */}
      {sidebarOpen && (
        <div style={styles.overlay} onClick={() => setSidebarOpen(false)} />
      )}

      {/* Sidebar */}
      <aside style={{ ...styles.sidebar, ...(sidebarOpen ? styles.sidebarOpen : {}) }}>
        <div style={styles.sidebarHeader}>
          <Shield size={32} color="#2563eb" />
          <span style={styles.sidebarLogo}>HealthGuard</span>
          <button onClick={() => setSidebarOpen(false)} style={styles.closeButton}>
            <X size={24} />
          </button>
        </div>

        <div style={styles.userInfo}>
          <div style={styles.avatar}>
            {user?.firstName?.[0]}{user?.lastName?.[0]}
          </div>
          <div>
            <p style={styles.userName}>{user?.firstName} {user?.lastName}</p>
            <p style={styles.memberId}>ID: {user?.memberId}</p>
          </div>
        </div>

        <nav style={styles.nav}>
          {navItems.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              onClick={() => setSidebarOpen(false)}
              style={({ isActive }) => ({
                ...styles.navItem,
                ...(isActive ? styles.navItemActive : {}),
              })}
            >
              <item.icon size={20} />
              <span>{item.label}</span>
            </NavLink>
          ))}
        </nav>

        <button onClick={handleLogout} style={styles.logoutButton}>
          <LogOut size={20} />
          <span>Logout</span>
        </button>
      </aside>

      {/* Main Content */}
      <main style={styles.main}>
        {/* Desktop Header */}
        <header style={styles.desktopHeader}>
          <h1 style={styles.pageTitle}>Welcome back, {user?.firstName}!</h1>
          <button
            onClick={() => setShowNotifications(!showNotifications)}
            style={styles.notificationButton}
          >
            <Bell size={24} />
            {unreadCount > 0 && <span style={styles.badge}>{unreadCount}</span>}
          </button>
        </header>

        {/* Notifications Dropdown */}
        {showNotifications && (
          <div style={styles.notificationsDropdown}>
            <h3 style={styles.notificationsTitle}>Notifications</h3>
            {notifications.length === 0 ? (
              <p style={styles.noNotifications}>No notifications</p>
            ) : (
              notifications.slice(0, 5).map(notification => (
                <div
                  key={notification.id}
                  style={{
                    ...styles.notificationItem,
                    ...(notification.read ? {} : styles.unreadNotification)
                  }}
                >
                  <p style={styles.notificationTitle}>{notification.title}</p>
                  <p style={styles.notificationMessage}>{notification.message}</p>
                  <p style={styles.notificationDate}>{notification.date}</p>
                </div>
              ))
            )}
          </div>
        )}

        <div style={styles.content}>
          <Outlet />
        </div>
      </main>
    </div>
  );
};

const styles = {
  container: {
    display: 'flex',
    minHeight: '100vh',
  },
  mobileHeader: {
    display: 'none',
    position: 'fixed',
    top: 0,
    left: 0,
    right: 0,
    height: '60px',
    background: 'white',
    borderBottom: '1px solid #e5e7eb',
    padding: '0 1rem',
    alignItems: 'center',
    justifyContent: 'space-between',
    zIndex: 100,
    '@media (max-width: 768px)': {
      display: 'flex',
    },
  },
  menuButton: {
    padding: '0.5rem',
    color: '#374151',
  },
  logo: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
  },
  logoText: {
    fontWeight: 700,
    fontSize: '1.25rem',
    color: '#1e40af',
  },
  notificationButton: {
    position: 'relative',
    padding: '0.5rem',
    color: '#374151',
  },
  badge: {
    position: 'absolute',
    top: 0,
    right: 0,
    background: '#ef4444',
    color: 'white',
    fontSize: '0.625rem',
    fontWeight: 600,
    padding: '0.125rem 0.375rem',
    borderRadius: '9999px',
  },
  overlay: {
    position: 'fixed',
    inset: 0,
    background: 'rgba(0, 0, 0, 0.5)',
    zIndex: 200,
  },
  sidebar: {
    position: 'fixed',
    left: 0,
    top: 0,
    bottom: 0,
    width: '280px',
    background: 'white',
    borderRight: '1px solid #e5e7eb',
    padding: '1.5rem',
    display: 'flex',
    flexDirection: 'column',
    zIndex: 300,
    transform: 'translateX(-100%)',
    transition: 'transform 0.3s ease',
  },
  sidebarOpen: {
    transform: 'translateX(0)',
  },
  sidebarHeader: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
    marginBottom: '2rem',
  },
  sidebarLogo: {
    fontWeight: 700,
    fontSize: '1.5rem',
    color: '#1e40af',
    flex: 1,
  },
  closeButton: {
    padding: '0.5rem',
    color: '#374151',
    display: 'none',
  },
  userInfo: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
    padding: '1rem',
    background: '#eff6ff',
    borderRadius: '0.75rem',
    marginBottom: '1.5rem',
  },
  avatar: {
    width: '40px',
    height: '40px',
    borderRadius: '50%',
    background: '#2563eb',
    color: 'white',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    fontWeight: 600,
  },
  userName: {
    fontWeight: 600,
    color: '#1f2937',
  },
  memberId: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  nav: {
    display: 'flex',
    flexDirection: 'column',
    gap: '0.5rem',
    flex: 1,
  },
  navItem: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
    padding: '0.75rem 1rem',
    borderRadius: '0.5rem',
    color: '#374151',
    transition: 'all 0.2s ease',
  },
  navItemActive: {
    background: '#2563eb',
    color: 'white',
  },
  logoutButton: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
    padding: '0.75rem 1rem',
    borderRadius: '0.5rem',
    color: '#ef4444',
    marginTop: 'auto',
  },
  main: {
    flex: 1,
    marginLeft: '280px',
    minHeight: '100vh',
  },
  desktopHeader: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: '1.5rem 2rem',
    background: 'white',
    borderBottom: '1px solid #e5e7eb',
  },
  pageTitle: {
    fontSize: '1.5rem',
    fontWeight: 600,
    color: '#1f2937',
  },
  notificationsDropdown: {
    position: 'absolute',
    top: '70px',
    right: '2rem',
    width: '320px',
    background: 'white',
    borderRadius: '0.75rem',
    boxShadow: '0 20px 25px -5px rgb(0 0 0 / 0.1)',
    padding: '1rem',
    zIndex: 100,
  },
  notificationsTitle: {
    fontWeight: 600,
    marginBottom: '1rem',
    color: '#1f2937',
  },
  noNotifications: {
    color: '#6b7280',
    textAlign: 'center',
    padding: '1rem',
  },
  notificationItem: {
    padding: '0.75rem',
    borderBottom: '1px solid #e5e7eb',
  },
  unreadNotification: {
    background: '#eff6ff',
    borderRadius: '0.5rem',
  },
  notificationTitle: {
    fontWeight: 500,
    fontSize: '0.875rem',
    color: '#1f2937',
  },
  notificationMessage: {
    fontSize: '0.75rem',
    color: '#6b7280',
    marginTop: '0.25rem',
  },
  notificationDate: {
    fontSize: '0.625rem',
    color: '#9ca3af',
    marginTop: '0.25rem',
  },
  content: {
    padding: '2rem',
  },
};

// Add media query styles via CSS
const styleSheet = document.createElement('style');
styleSheet.textContent = `
  @media (max-width: 768px) {
    .mobile-header { display: flex !important; }
    .sidebar { transform: translateX(-100%); }
    .sidebar-open { transform: translateX(0); }
    .close-button { display: block !important; }
    .main { margin-left: 0 !important; padding-top: 60px; }
    .desktop-header { display: none !important; }
  }
  @media (min-width: 769px) {
    .sidebar { transform: translateX(0) !important; }
  }
`;
document.head.appendChild(styleSheet);

export default Layout;
