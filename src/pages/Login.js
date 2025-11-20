import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import { Shield, Mail, Lock, Eye, EyeOff } from 'lucide-react';

const Login = () => {
  const { login } = useApp();
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    setTimeout(() => {
      if (login(email, password)) {
        navigate('/dashboard');
      } else {
        setError('Invalid email or password');
      }
      setLoading(false);
    }, 1000);
  };

  return (
    <div style={styles.container}>
      <div style={styles.loginBox}>
        <div style={styles.header}>
          <Shield size={48} color="#2563eb" />
          <h1 style={styles.title}>HealthGuard</h1>
          <p style={styles.subtitle}>Your Health Insurance Partner</p>
        </div>

        <form onSubmit={handleSubmit} style={styles.form}>
          <h2 style={styles.formTitle}>Welcome Back</h2>
          <p style={styles.formSubtitle}>Sign in to access your account</p>

          {error && <div style={styles.error}>{error}</div>}

          <div style={styles.inputGroup}>
            <label style={styles.label}>Email Address</label>
            <div style={styles.inputWrapper}>
              <Mail size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Enter your email"
                style={styles.input}
                required
              />
            </div>
          </div>

          <div style={styles.inputGroup}>
            <label style={styles.label}>Password</label>
            <div style={styles.inputWrapper}>
              <Lock size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type={showPassword ? 'text' : 'password'}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Enter your password"
                style={styles.input}
                required
              />
              <button
                type="button"
                onClick={() => setShowPassword(!showPassword)}
                style={styles.eyeButton}
              >
                {showPassword ? <EyeOff size={20} /> : <Eye size={20} />}
              </button>
            </div>
          </div>

          <div style={styles.options}>
            <label style={styles.checkbox}>
              <input type="checkbox" />
              <span>Remember me</span>
            </label>
            <Link to="/forgot-password" style={styles.forgotLink}>
              Forgot Password?
            </Link>
          </div>

          <button type="submit" style={styles.submitButton} disabled={loading}>
            {loading ? 'Signing in...' : 'Sign In'}
          </button>

          <p style={styles.registerText}>
            Don't have an account?{' '}
            <Link to="/register" style={styles.registerLink}>
              Create Account
            </Link>
          </p>
        </form>

        <div style={styles.footer}>
          <p style={styles.footerText}>Demo credentials: any email & password</p>
        </div>
      </div>
    </div>
  );
};

const styles = {
  container: {
    minHeight: '100vh',
    minHeight: '-webkit-fill-available',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    background: 'linear-gradient(135deg, #1e40af 0%, #3b82f6 100%)',
    padding: '1rem',
    position: 'relative',
    width: '100%',
  },
  loginBox: {
    width: '100%',
    maxWidth: '440px',
    margin: '0 auto',
    background: 'white',
    borderRadius: '1rem',
    boxShadow: '0 25px 50px -12px rgb(0 0 0 / 0.25)',
    overflow: 'hidden',
    position: 'relative',
    left: '50%',
    transform: 'translateX(-50%)',
  },
  header: {
    textAlign: 'center',
    padding: '2rem 1.5rem 1rem',
    background: '#eff6ff',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  title: {
    fontSize: 'clamp(1.5rem, 5vw, 1.75rem)',
    fontWeight: 700,
    color: '#1e40af',
    marginTop: '0.5rem',
    marginBottom: '0.25rem',
  },
  subtitle: {
    color: '#6b7280',
    fontSize: 'clamp(0.813rem, 3vw, 0.875rem)',
    marginTop: '0.25rem',
  },
  form: {
    padding: '1.5rem',
  },
  formTitle: {
    fontSize: 'clamp(1.25rem, 4vw, 1.5rem)',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.25rem',
    textAlign: 'center',
  },
  formSubtitle: {
    color: '#6b7280',
    marginBottom: '1.5rem',
    textAlign: 'center',
    fontSize: 'clamp(0.813rem, 3vw, 0.875rem)',
  },
  error: {
    background: '#fee2e2',
    color: '#991b1b',
    padding: '0.75rem',
    borderRadius: '0.5rem',
    marginBottom: '1rem',
    fontSize: 'clamp(0.813rem, 3vw, 0.875rem)',
    textAlign: 'center',
  },
  inputGroup: {
    marginBottom: '1.25rem',
  },
  label: {
    display: 'block',
    marginBottom: '0.5rem',
    fontWeight: 500,
    color: '#374151',
    fontSize: 'clamp(0.813rem, 3vw, 0.875rem)',
  },
  inputWrapper: {
    position: 'relative',
    display: 'flex',
    alignItems: 'center',
    width: '100%',
  },
  inputIcon: {
    position: 'absolute',
    left: '0.75rem',
    pointerEvents: 'none',
  },
  input: {
    width: '100%',
    padding: '0.875rem 0.875rem 0.875rem 2.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: 'clamp(0.938rem, 3.5vw, 1rem)',
    transition: 'border-color 0.2s ease',
    outline: 'none',
    WebkitAppearance: 'none',
    appearance: 'none',
  },
  eyeButton: {
    position: 'absolute',
    right: '0.75rem',
    color: '#6b7280',
    padding: '0.5rem',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    cursor: 'pointer',
  },
  options: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '1.5rem',
    fontSize: 'clamp(0.75rem, 3vw, 0.875rem)',
    gap: '0.5rem',
    flexWrap: 'wrap',
  },
  checkbox: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    color: '#374151',
  },
  forgotLink: {
    color: '#2563eb',
    fontWeight: 500,
    whiteSpace: 'nowrap',
  },
  submitButton: {
    width: '100%',
    padding: '1rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 600,
    fontSize: 'clamp(0.938rem, 3.5vw, 1rem)',
    transition: 'background 0.2s ease',
    cursor: 'pointer',
    border: 'none',
    WebkitAppearance: 'none',
    appearance: 'none',
  },
  registerText: {
    textAlign: 'center',
    marginTop: '1.5rem',
    color: '#6b7280',
    fontSize: 'clamp(0.813rem, 3vw, 0.875rem)',
  },
  registerLink: {
    color: '#2563eb',
    fontWeight: 600,
  },
  footer: {
    padding: '1rem 1.5rem',
    background: '#f9fafb',
    borderTop: '1px solid #e5e7eb',
  },
  footerText: {
    textAlign: 'center',
    fontSize: 'clamp(0.75rem, 2.5vw, 0.813rem)',
    color: '#9ca3af',
  },
};

export default Login;
