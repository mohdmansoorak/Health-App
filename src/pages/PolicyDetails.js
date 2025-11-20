import React from 'react';
import { useParams, Link } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import { ArrowLeft, Shield, Calendar, Users, CreditCard, CheckCircle } from 'lucide-react';

const PolicyDetails = () => {
  const { id } = useParams();
  const { policies } = useApp();
  const policy = policies.find(p => p.id === id);

  if (!policy) {
    return (
      <div style={styles.notFound}>
        <h2>Policy not found</h2>
        <Link to="/policies" style={styles.backLink}>Back to Policies</Link>
      </div>
    );
  }

  return (
    <div style={styles.container}>
      <Link to="/policies" style={styles.backButton}>
        <ArrowLeft size={20} />
        Back to Policies
      </Link>

      <div style={styles.header}>
        <div style={styles.headerContent}>
          <div style={styles.policyIcon}>
            <Shield size={32} color="#2563eb" />
          </div>
          <div>
            <h2 style={styles.title}>{policy.name}</h2>
            <p style={styles.policyNumber}>{policy.policyNumber}</p>
          </div>
        </div>
        <span style={{
          ...styles.statusBadge,
          background: policy.status === 'active' ? '#d1fae5' : '#fee2e2',
          color: policy.status === 'active' ? '#065f46' : '#991b1b'
        }}>
          {policy.status}
        </span>
      </div>

      <div style={styles.grid}>
        {/* Policy Overview */}
        <div style={styles.card}>
          <h3 style={styles.cardTitle}>Policy Overview</h3>
          <div style={styles.overviewGrid}>
            <div style={styles.overviewItem}>
              <Calendar size={20} color="#2563eb" />
              <div>
                <p style={styles.overviewLabel}>Start Date</p>
                <p style={styles.overviewValue}>{policy.startDate}</p>
              </div>
            </div>
            <div style={styles.overviewItem}>
              <Calendar size={20} color="#2563eb" />
              <div>
                <p style={styles.overviewLabel}>End Date</p>
                <p style={styles.overviewValue}>{policy.endDate}</p>
              </div>
            </div>
            <div style={styles.overviewItem}>
              <Users size={20} color="#2563eb" />
              <div>
                <p style={styles.overviewLabel}>Policy Type</p>
                <p style={styles.overviewValue}>{policy.type}</p>
              </div>
            </div>
            <div style={styles.overviewItem}>
              <CreditCard size={20} color="#2563eb" />
              <div>
                <p style={styles.overviewLabel}>Premium</p>
                <p style={styles.overviewValue}>${policy.premium}/{policy.premiumFrequency}</p>
              </div>
            </div>
          </div>
        </div>

        {/* Coverage Details */}
        <div style={styles.card}>
          <h3 style={styles.cardTitle}>Coverage Details</h3>
          <div style={styles.coverageDetails}>
            <div style={styles.coverageItem}>
              <span style={styles.coverageLabel}>Total Coverage</span>
              <span style={styles.coverageValue}>${policy.coverageAmount.toLocaleString()}</span>
            </div>
            <div style={styles.coverageItem}>
              <span style={styles.coverageLabel}>Deductible</span>
              <span style={styles.coverageValue}>${policy.deductible}</span>
            </div>
            <div style={styles.coverageItem}>
              <span style={styles.coverageLabel}>Copay</span>
              <span style={styles.coverageValue}>${policy.copay}</span>
            </div>
          </div>
        </div>

        {/* Covered Members */}
        <div style={styles.card}>
          <h3 style={styles.cardTitle}>Covered Members</h3>
          <div style={styles.membersList}>
            {policy.coveredMembers.map((member, index) => (
              <div key={index} style={styles.memberItem}>
                <div style={styles.memberAvatar}>
                  {member.split(' ').map(n => n[0]).join('')}
                </div>
                <span style={styles.memberName}>{member}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Benefits */}
        <div style={{ ...styles.card, gridColumn: '1 / -1' }}>
          <h3 style={styles.cardTitle}>Benefits & Coverage</h3>
          <div style={styles.benefitsTable}>
            <div style={styles.tableHeader}>
              <span>Benefit</span>
              <span>Coverage</span>
              <span>Limit</span>
            </div>
            {policy.benefits.map((benefit, index) => (
              <div key={index} style={styles.tableRow}>
                <span style={styles.benefitName}>
                  <CheckCircle size={16} color="#10b981" />
                  {benefit.name}
                </span>
                <span style={styles.benefitCoverage}>{benefit.coverage}</span>
                <span style={styles.benefitLimit}>{benefit.limit}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

const styles = {
  container: {
    maxWidth: '1200px',
    margin: '0 auto',
  },
  notFound: {
    textAlign: 'center',
    padding: '3rem',
  },
  backButton: {
    display: 'inline-flex',
    alignItems: 'center',
    gap: '0.5rem',
    color: '#2563eb',
    fontWeight: 500,
    marginBottom: '1.5rem',
  },
  backLink: {
    color: '#2563eb',
    marginTop: '1rem',
    display: 'inline-block',
  },
  header: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '2rem',
  },
  headerContent: {
    display: 'flex',
    alignItems: 'center',
    gap: '1rem',
  },
  policyIcon: {
    width: '64px',
    height: '64px',
    borderRadius: '1rem',
    background: '#eff6ff',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    fontSize: '1.5rem',
    fontWeight: 600,
    color: '#1f2937',
  },
  policyNumber: {
    color: '#6b7280',
  },
  statusBadge: {
    padding: '0.5rem 1rem',
    borderRadius: '9999px',
    fontSize: '0.875rem',
    fontWeight: 500,
    textTransform: 'capitalize',
  },
  grid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: '1.5rem',
  },
  card: {
    background: 'white',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    padding: '1.5rem',
  },
  cardTitle: {
    fontSize: '1rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '1rem',
  },
  overviewGrid: {
    display: 'flex',
    flexDirection: 'column',
    gap: '1rem',
  },
  overviewItem: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
  },
  overviewLabel: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  overviewValue: {
    fontWeight: 500,
    color: '#1f2937',
  },
  coverageDetails: {
    display: 'flex',
    flexDirection: 'column',
    gap: '1rem',
  },
  coverageItem: {
    display: 'flex',
    justifyContent: 'space-between',
    padding: '0.75rem',
    background: '#f9fafb',
    borderRadius: '0.5rem',
  },
  coverageLabel: {
    color: '#6b7280',
  },
  coverageValue: {
    fontWeight: 600,
    color: '#2563eb',
  },
  membersList: {
    display: 'flex',
    flexDirection: 'column',
    gap: '0.75rem',
  },
  memberItem: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
  },
  memberAvatar: {
    width: '36px',
    height: '36px',
    borderRadius: '50%',
    background: '#2563eb',
    color: 'white',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    fontSize: '0.75rem',
    fontWeight: 600,
  },
  memberName: {
    fontWeight: 500,
    color: '#1f2937',
  },
  benefitsTable: {
    display: 'flex',
    flexDirection: 'column',
  },
  tableHeader: {
    display: 'grid',
    gridTemplateColumns: '2fr 1fr 1fr',
    padding: '0.75rem 1rem',
    background: '#f9fafb',
    borderRadius: '0.5rem',
    fontWeight: 600,
    color: '#374151',
    fontSize: '0.875rem',
  },
  tableRow: {
    display: 'grid',
    gridTemplateColumns: '2fr 1fr 1fr',
    padding: '0.75rem 1rem',
    borderBottom: '1px solid #f3f4f6',
    fontSize: '0.875rem',
  },
  benefitName: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    fontWeight: 500,
    color: '#1f2937',
  },
  benefitCoverage: {
    color: '#2563eb',
    fontWeight: 500,
  },
  benefitLimit: {
    color: '#6b7280',
  },
};

export default PolicyDetails;
