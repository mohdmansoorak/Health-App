import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import { ArrowLeft, Upload, Calendar, DollarSign, Building } from 'lucide-react';

const FileClaim = () => {
  const { policies, fileClaim } = useApp();
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    policyId: '',
    type: '',
    description: '',
    provider: '',
    serviceDate: '',
    amount: '',
  });
  const [loading, setLoading] = useState(false);

  const claimTypes = [
    'Medical',
    'Prescription',
    'Specialist',
    'Dental',
    'Vision',
    'Mental Health',
    'Emergency',
    'Lab Work',
    'Other'
  ];

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setLoading(true);

    setTimeout(() => {
      fileClaim({
        ...formData,
        amount: parseFloat(formData.amount),
      });
      setLoading(false);
      navigate('/claims');
    }, 1500);
  };

  return (
    <div style={styles.container}>
      <Link to="/claims" style={styles.backButton}>
        <ArrowLeft size={20} />
        Back to Claims
      </Link>

      <div style={styles.header}>
        <h2 style={styles.title}>File a New Claim</h2>
        <p style={styles.subtitle}>Submit your insurance claim for processing</p>
      </div>

      <form onSubmit={handleSubmit} style={styles.form}>
        <div style={styles.formGrid}>
          {/* Policy Selection */}
          <div style={styles.inputGroup}>
            <label style={styles.label}>Select Policy *</label>
            <select
              name="policyId"
              value={formData.policyId}
              onChange={handleChange}
              style={styles.select}
              required
            >
              <option value="">Choose a policy</option>
              {policies.map(policy => (
                <option key={policy.id} value={policy.id}>
                  {policy.name} ({policy.policyNumber})
                </option>
              ))}
            </select>
          </div>

          {/* Claim Type */}
          <div style={styles.inputGroup}>
            <label style={styles.label}>Claim Type *</label>
            <select
              name="type"
              value={formData.type}
              onChange={handleChange}
              style={styles.select}
              required
            >
              <option value="">Select type</option>
              {claimTypes.map(type => (
                <option key={type} value={type}>{type}</option>
              ))}
            </select>
          </div>

          {/* Provider */}
          <div style={styles.inputGroup}>
            <label style={styles.label}>Healthcare Provider *</label>
            <div style={styles.inputWrapper}>
              <Building size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type="text"
                name="provider"
                value={formData.provider}
                onChange={handleChange}
                placeholder="Hospital, clinic, or doctor name"
                style={styles.input}
                required
              />
            </div>
          </div>

          {/* Service Date */}
          <div style={styles.inputGroup}>
            <label style={styles.label}>Date of Service *</label>
            <div style={styles.inputWrapper}>
              <Calendar size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type="date"
                name="serviceDate"
                value={formData.serviceDate}
                onChange={handleChange}
                style={styles.input}
                required
              />
            </div>
          </div>

          {/* Amount */}
          <div style={styles.inputGroup}>
            <label style={styles.label}>Claim Amount *</label>
            <div style={styles.inputWrapper}>
              <DollarSign size={20} color="#6b7280" style={styles.inputIcon} />
              <input
                type="number"
                name="amount"
                value={formData.amount}
                onChange={handleChange}
                placeholder="0.00"
                style={styles.input}
                min="0"
                step="0.01"
                required
              />
            </div>
          </div>

          {/* Description */}
          <div style={{ ...styles.inputGroup, gridColumn: '1 / -1' }}>
            <label style={styles.label}>Description *</label>
            <textarea
              name="description"
              value={formData.description}
              onChange={handleChange}
              placeholder="Describe the medical service or treatment received"
              style={styles.textarea}
              rows={4}
              required
            />
          </div>

          {/* Document Upload */}
          <div style={{ ...styles.inputGroup, gridColumn: '1 / -1' }}>
            <label style={styles.label}>Upload Documents</label>
            <div style={styles.uploadArea}>
              <Upload size={32} color="#6b7280" />
              <p style={styles.uploadText}>
                Drag and drop files here, or click to browse
              </p>
              <p style={styles.uploadHint}>
                Supported formats: PDF, JPG, PNG (Max 10MB)
              </p>
              <input
                type="file"
                multiple
                accept=".pdf,.jpg,.jpeg,.png"
                style={styles.fileInput}
              />
            </div>
          </div>
        </div>

        <div style={styles.formActions}>
          <Link to="/claims" style={styles.cancelBtn}>
            Cancel
          </Link>
          <button type="submit" style={styles.submitBtn} disabled={loading}>
            {loading ? 'Submitting...' : 'Submit Claim'}
          </button>
        </div>
      </form>

      <div style={styles.notice}>
        <h4 style={styles.noticeTitle}>Important Information</h4>
        <ul style={styles.noticeList}>
          <li>Claims are typically processed within 5-7 business days</li>
          <li>You will receive email notifications about your claim status</li>
          <li>Make sure all documents are clear and legible</li>
          <li>Contact support if you need assistance with your claim</li>
        </ul>
      </div>
    </div>
  );
};

const styles = {
  container: {
    maxWidth: '800px',
    margin: '0 auto',
  },
  backButton: {
    display: 'inline-flex',
    alignItems: 'center',
    gap: '0.5rem',
    color: '#2563eb',
    fontWeight: 500,
    marginBottom: '1.5rem',
  },
  header: {
    marginBottom: '2rem',
  },
  title: {
    fontSize: '1.5rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.5rem',
  },
  subtitle: {
    color: '#6b7280',
  },
  form: {
    background: 'white',
    padding: '2rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    marginBottom: '1.5rem',
  },
  formGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(2, 1fr)',
    gap: '1.5rem',
  },
  inputGroup: {
    display: 'flex',
    flexDirection: 'column',
  },
  label: {
    marginBottom: '0.5rem',
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
    padding: '0.75rem 0.75rem 0.75rem 2.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    outline: 'none',
    transition: 'border-color 0.2s ease',
  },
  select: {
    width: '100%',
    padding: '0.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    outline: 'none',
    background: 'white',
    cursor: 'pointer',
  },
  textarea: {
    width: '100%',
    padding: '0.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    outline: 'none',
    resize: 'vertical',
  },
  uploadArea: {
    border: '2px dashed #e5e7eb',
    borderRadius: '0.5rem',
    padding: '2rem',
    textAlign: 'center',
    position: 'relative',
    cursor: 'pointer',
  },
  uploadText: {
    marginTop: '0.75rem',
    color: '#374151',
    fontWeight: 500,
  },
  uploadHint: {
    fontSize: '0.75rem',
    color: '#6b7280',
    marginTop: '0.25rem',
  },
  fileInput: {
    position: 'absolute',
    inset: 0,
    opacity: 0,
    cursor: 'pointer',
  },
  formActions: {
    display: 'flex',
    justifyContent: 'flex-end',
    gap: '1rem',
    marginTop: '2rem',
    paddingTop: '1.5rem',
    borderTop: '1px solid #e5e7eb',
  },
  cancelBtn: {
    padding: '0.75rem 1.5rem',
    borderRadius: '0.5rem',
    fontWeight: 500,
    color: '#374151',
    background: '#f3f4f6',
  },
  submitBtn: {
    padding: '0.75rem 2rem',
    borderRadius: '0.5rem',
    fontWeight: 500,
    color: 'white',
    background: '#2563eb',
  },
  notice: {
    background: '#eff6ff',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    border: '1px solid #bfdbfe',
  },
  noticeTitle: {
    fontWeight: 600,
    color: '#1e40af',
    marginBottom: '0.75rem',
  },
  noticeList: {
    margin: 0,
    paddingLeft: '1.25rem',
    color: '#1e40af',
    fontSize: '0.875rem',
    lineHeight: 1.8,
  },
};

export default FileClaim;
