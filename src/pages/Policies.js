import React from 'react';
import { Link } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import { FileText, Calendar, Users, ChevronRight, Shield } from 'lucide-react';

const Policies = () => {
  const { policies } = useApp();

  return (
    <div style={styles.container}>
      <div style={styles.header}>
        <h2 style={styles.title}>My Policies</h2>
        <p style={styles.subtitle}>Manage and view all your insurance policies</p>
      </div>

      <div style={styles.policiesGrid}>
        {policies.map(policy => (
          <Link to={`/policies/${policy.id}`} key={policy.id} style={styles.policyCard}>
            <div style={styles.policyHeader}>
              <div style={styles.policyIcon}>
                <Shield size={24} color="#2563eb" />
              </div>
              <span style={{
                ...styles.statusBadge,
                background: policy.status === 'active' ? '#d1fae5' : '#fee2e2',
                color: policy.status === 'active' ? '#065f46' : '#991b1b'
              }}>
                {policy.status}
              </span>
            </div>

            <h3 style={styles.policyName}>{policy.name}</h3>
            <p style={styles.policyNumber}>{policy.policyNumber}</p>

            <div style={styles.policyDetails}>
              <div style={styles.detailItem}>
                <Users size={16} color="#6b7280" />
                <span>{policy.type}</span>
              </div>
              <div style={styles.detailItem}>
                <Calendar size={16} color="#6b7280" />
                <span>Expires: {policy.endDate}</span>
              </div>
            </div>

            <div style={styles.policyFooter}>
              <div style={styles.premium}>
                <span style={styles.premiumLabel}>Monthly Premium</span>
                <span style={styles.premiumAmount}>${policy.premium}</span>
              </div>
              <div style={styles.coverage}>
                <span style={styles.coverageLabel}>Coverage</span>
                <span style={styles.coverageAmount}>${policy.coverageAmount.toLocaleString()}</span>
              </div>
            </div>

            <div style={styles.viewDetails}>
              View Details <ChevronRight size={16} />
            </div>
          </Link>
        ))}
      </div>
    </div>
  );
};

const styles = {
  container: {
    maxWidth: '1200px',
    margin: '0 auto',
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
  policiesGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))',
    gap: '1.5rem',
  },
  policyCard: {
    background: 'white',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    padding: '1.5rem',
    transition: 'all 0.2s ease',
    border: '2px solid transparent',
    cursor: 'pointer',
    display: 'block',
  },
  policyHeader: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '1rem',
  },
  policyIcon: {
    width: '48px',
    height: '48px',
    borderRadius: '0.75rem',
    background: '#eff6ff',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  statusBadge: {
    padding: '0.25rem 0.75rem',
    borderRadius: '9999px',
    fontSize: '0.75rem',
    fontWeight: 500,
    textTransform: 'capitalize',
  },
  policyName: {
    fontSize: '1.125rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  policyNumber: {
    fontSize: '0.875rem',
    color: '#6b7280',
    marginBottom: '1rem',
  },
  policyDetails: {
    display: 'flex',
    gap: '1.5rem',
    marginBottom: '1rem',
  },
  detailItem: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    fontSize: '0.875rem',
    color: '#6b7280',
  },
  policyFooter: {
    display: 'flex',
    justifyContent: 'space-between',
    padding: '1rem 0',
    borderTop: '1px solid #e5e7eb',
    borderBottom: '1px solid #e5e7eb',
    marginBottom: '1rem',
  },
  premium: {
    display: 'flex',
    flexDirection: 'column',
  },
  premiumLabel: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  premiumAmount: {
    fontSize: '1.125rem',
    fontWeight: 600,
    color: '#1f2937',
  },
  coverage: {
    display: 'flex',
    flexDirection: 'column',
    textAlign: 'right',
  },
  coverageLabel: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  coverageAmount: {
    fontSize: '1.125rem',
    fontWeight: 600,
    color: '#2563eb',
  },
  viewDetails: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    gap: '0.25rem',
    color: '#2563eb',
    fontWeight: 500,
    fontSize: '0.875rem',
  },
};

export default Policies;
