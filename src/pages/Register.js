import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import { Shield, Mail, Lock, User, Phone, Eye, EyeOff } from 'lucide-react';

const Register = () => {
  const { register } = useApp();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
  });
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    if (formData.password !== formData.confirmPassword) {
      setError('Passwords do not match');
      return;
    }

    setLoading(true);

    setTimeout(() => {
      if (register(formData)) {
        navigate('/dashboard');
      } else {
        setError('Registration failed. Please try again.');
      }
      setLoading(false);
    }, 1000);
  };

  return (
    <div style={styles.container}>
      <div style={styles.registerBox}>
        <div style={styles.header}>
          <Shield size={48} color="#2563eb" />
          <h1 style={styles.title}>HealthGuard</h1>
          <p style={styles.subtitle}>Create Your Account</p>
        </div>

        <form onSubmit={handleSubmit} style={styles.form}>
          {error && <div style={styles.error}>{error}</div>}

          <div style={styles.row}>
            <div style={styles.inputGroup}>
              <label style={styles.label}>First Name</label>
              <div style={styles.inputWrapper}>
                <User size={20} color="#6b7280" style={styles.inputIcon} />
                <input
                  type="text"
                  name="firstName"
                  value={formData.firstName}
                  onChange={handleChange}
                  placeholder="First name"
                  style={styles.input}
                  required
                />
              </div>
            </div>
            <div style={styles.inputGroup}>
              <label style={styles.label}>Last Name</label>
              <div style={styles.inputWrapper}>
                <User size={20} color="#6b7280" style={styles.inputIcon} />
                <input
                  type="text"
                  name="lastName"
                  value={formData.lastName}
                  onChange={handleChange}
                  placeholder="Last name"
                  style={styles.input}
                  required
                />
              </div>
            </div>
          </div>

          <div style={styles.inputGroup}>
            <label style={styles.label}>Email Address</label>
            <div style={styles.inputWrapper}>
              <Mail size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                placeholder="Enter your email"
                style={styles.input}
                required
              />
            </div>
          </div>

          <div style={styles.inputGroup}>
            <label style={styles.label}>Phone Number</label>
            <div style={styles.inputWrapper}>
              <Phone size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type="tel"
                name="phone"
                value={formData.phone}
                onChange={handleChange}
                placeholder="Enter your phone"
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
                name="password"
                value={formData.password}
                onChange={handleChange}
                placeholder="Create a password"
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

          <div style={styles.inputGroup}>
            <label style={styles.label}>Confirm Password</label>
            <div style={styles.inputWrapper}>
              <Lock size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type={showPassword ? 'text' : 'password'}
                name="confirmPassword"
                value={formData.confirmPassword}
                onChange={handleChange}
                placeholder="Confirm your password"
                style={styles.input}
                required
              />
            </div>
          </div>

          <label style={styles.terms}>
            <input type="checkbox" required />
            <span>
              I agree to the{' '}
              <a href="#terms" style={styles.link}>Terms of Service</a>{' '}
              and{' '}
              <a href="#privacy" style={styles.link}>Privacy Policy</a>
            </span>
          </label>

          <button type="submit" style={styles.submitButton} disabled={loading}>
            {loading ? 'Creating Account...' : 'Create Account'}
          </button>

          <p style={styles.loginText}>
            Already have an account?{' '}
            <Link to="/login" style={styles.loginLink}>
              Sign In
            </Link>
          </p>
        </form>
      </div>
    </div>
  );
};

const styles = {
  container: {
    minHeight: '100vh',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    background: 'linear-gradient(135deg, #1e40af 0%, #3b82f6 100%)',
    padding: '1rem',
  },
  registerBox: {
    width: '100%',
    maxWidth: '500px',
    background: 'white',
    borderRadius: '1rem',
    boxShadow: '0 25px 50px -12px rgb(0 0 0 / 0.25)',
    overflow: 'hidden',
  },
  header: {
    textAlign: 'center',
    padding: '1.5rem 2rem 1rem',
    background: '#eff6ff',
  },
  title: {
    fontSize: '1.75rem',
    fontWeight: 700,
    color: '#1e40af',
    marginTop: '0.5rem',
  },
  subtitle: {
    color: '#6b7280',
    fontSize: '0.875rem',
  },
  form: {
    padding: '1.5rem 2rem 2rem',
  },
  error: {
    background: '#fee2e2',
    color: '#991b1b',
    padding: '0.75rem',
    borderRadius: '0.5rem',
    marginBottom: '1rem',
    fontSize: '0.875rem',
  },
  row: {
    display: 'grid',
    gridTemplateColumns: '1fr 1fr',
    gap: '1rem',
  },
  inputGroup: {
    marginBottom: '1rem',
  },
  label: {
    display: 'block',
    marginBottom: '0.375rem',
    fontWeight: 500,
    color: '#374151',
    fontSize: '0.875rem',
  },
  inputWrapper: {
    position: 'relative',
    display: 'flex',
    alignItems: 'center',
  },
  inputIcon: {
    position: 'absolute',
    left: '0.75rem',
  },
  input: {
    width: '100%',
    padding: '0.625rem 0.75rem 0.625rem 2.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    transition: 'border-color 0.2s ease',
    outline: 'none',
  },
  eyeButton: {
    position: 'absolute',
    right: '0.75rem',
    color: '#6b7280',
    padding: '0.25rem',
  },
  terms: {
    display: 'flex',
    alignItems: 'flex-start',
    gap: '0.5rem',
    marginBottom: '1.5rem',
    fontSize: '0.8rem',
    color: '#374151',
  },
  link: {
    color: '#2563eb',
    textDecoration: 'underline',
  },
  submitButton: {
    width: '100%',
    padding: '0.875rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 600,
    fontSize: '1rem',
    transition: 'background 0.2s ease',
    cursor: 'pointer',
  },
  loginText: {
    textAlign: 'center',
    marginTop: '1.5rem',
    color: '#6b7280',
    fontSize: '0.875rem',
  },
  loginLink: {
    color: '#2563eb',
    fontWeight: 600,
  },
};

export default Register;
