import React, { createContext, useContext, useState } from 'react';
import { mockUser, mockPolicies, mockClaims, mockProviders, mockPayments, mockNotifications } from '../data/mockData';

const AppContext = createContext();

export const useApp = () => {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within an AppProvider');
  }
  return context;
};

export const AppProvider = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [user, setUser] = useState(null);
  const [policies, setPolicies] = useState(mockPolicies);
  const [claims, setClaims] = useState(mockClaims);
  const [providers] = useState(mockProviders);
  const [payments, setPayments] = useState(mockPayments);
  const [notifications, setNotifications] = useState(mockNotifications);

  const login = (email, password) => {
    // Simulate authentication
    if (email && password) {
      setIsAuthenticated(true);
      setUser(mockUser);
      return true;
    }
    return false;
  };

  const logout = () => {
    setIsAuthenticated(false);
    setUser(null);
  };

  const register = (userData) => {
    // Simulate registration
    setIsAuthenticated(true);
    setUser({ ...mockUser, ...userData });
    return true;
  };

  const fileClaim = (claimData) => {
    const newClaim = {
      id: `CLM${String(claims.length + 1).padStart(6, '0')}`,
      ...claimData,
      status: 'pending',
      submittedDate: new Date().toISOString().split('T')[0],
    };
    setClaims([newClaim, ...claims]);
    return newClaim;
  };

  const makePayment = (paymentData) => {
    const newPayment = {
      id: `PAY${String(payments.length + 1).padStart(6, '0')}`,
      ...paymentData,
      date: new Date().toISOString().split('T')[0],
      status: 'completed',
    };
    setPayments([newPayment, ...payments]);
    return newPayment;
  };

  const markNotificationRead = (notificationId) => {
    setNotifications(notifications.map(n =>
      n.id === notificationId ? { ...n, read: true } : n
    ));
  };

  const value = {
    isAuthenticated,
    user,
    policies,
    claims,
    providers,
    payments,
    notifications,
    login,
    logout,
    register,
    fileClaim,
    makePayment,
    markNotificationRead,
  };

  return <AppContext.Provider value={value}>{children}</AppContext.Provider>;
};
