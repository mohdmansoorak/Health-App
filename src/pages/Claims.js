import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import { Plus, Filter, Search, CheckCircle, Clock, XCircle } from 'lucide-react';

const Claims = () => {
  const { claims } = useApp();
  const [filter, setFilter] = useState('all');
  const [searchTerm, setSearchTerm] = useState('');

  const filteredClaims = claims.filter(claim => {
    const matchesFilter = filter === 'all' || claim.status === filter;
    const matchesSearch = claim.description.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         claim.provider.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         claim.id.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesFilter && matchesSearch;
  });

  const getStatusIcon = (status) => {
    switch (status) {
      case 'approved': return <CheckCircle size={16} color="#10b981" />;
      case 'pending': return <Clock size={16} color="#f59e0b" />;
      case 'denied': return <XCircle size={16} color="#ef4444" />;
      default: return null;
    }
  };

  const getStatusBadge = (status) => {
    const styles = {
      approved: { background: '#d1fae5', color: '#065f46' },
      pending: { background: '#fef3c7', color: '#92400e' },
      denied: { background: '#fee2e2', color: '#991b1b' },
    };
    return styles[status] || styles.pending;
  };

  return (
    <div style={styles.container}>
      <div style={styles.header}>
        <div>
          <h2 style={styles.title}>Claims</h2>
          <p style={styles.subtitle}>View and manage your insurance claims</p>
        </div>
        <Link to="/claims/new" style={styles.newClaimBtn}>
          <Plus size={20} />
          File New Claim
        </Link>
      </div>

      {/* Stats */}
      <div style={styles.statsGrid}>
        <div style={styles.statCard}>
          <div style={styles.statValue}>{claims.length}</div>
          <div style={styles.statLabel}>Total Claims</div>
        </div>
        <div style={styles.statCard}>
          <div style={{ ...styles.statValue, color: '#10b981' }}>
            {claims.filter(c => c.status === 'approved').length}
          </div>
          <div style={styles.statLabel}>Approved</div>
        </div>
        <div style={styles.statCard}>
          <div style={{ ...styles.statValue, color: '#f59e0b' }}>
            {claims.filter(c => c.status === 'pending').length}
          </div>
          <div style={styles.statLabel}>Pending</div>
        </div>
        <div style={styles.statCard}>
          <div style={{ ...styles.statValue, color: '#ef4444' }}>
            {claims.filter(c => c.status === 'denied').length}
          </div>
          <div style={styles.statLabel}>Denied</div>
        </div>
      </div>

      {/* Filters */}
      <div style={styles.filters}>
        <div style={styles.searchBox}>
          <Search size={20} color="#6b7280" />
          <input
            type="text"
            placeholder="Search claims..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            style={styles.searchInput}
          />
        </div>
        <div style={styles.filterButtons}>
          <Filter size={20} color="#6b7280" />
          {['all', 'approved', 'pending', 'denied'].map(status => (
            <button
              key={status}
              onClick={() => setFilter(status)}
              style={{
                ...styles.filterBtn,
                ...(filter === status ? styles.filterBtnActive : {})
              }}
            >
              {status.charAt(0).toUpperCase() + status.slice(1)}
            </button>
          ))}
        </div>
      </div>

      {/* Claims List */}
      <div style={styles.claimsList}>
        {filteredClaims.length === 0 ? (
          <div style={styles.emptyState}>
            <p>No claims found</p>
          </div>
        ) : (
          filteredClaims.map(claim => (
            <div key={claim.id} style={styles.claimCard}>
              <div style={styles.claimHeader}>
                <div style={styles.claimId}>{claim.id}</div>
                <span style={{
                  ...styles.statusBadge,
                  ...getStatusBadge(claim.status)
                }}>
                  {getStatusIcon(claim.status)}
                  {claim.status}
                </span>
              </div>

              <h3 style={styles.claimDescription}>{claim.description}</h3>
              <p style={styles.claimProvider}>{claim.provider}</p>

              <div style={styles.claimDetails}>
                <div style={styles.claimDetail}>
                  <span style={styles.detailLabel}>Type</span>
                  <span style={styles.detailValue}>{claim.type}</span>
                </div>
                <div style={styles.claimDetail}>
                  <span style={styles.detailLabel}>Submitted</span>
                  <span style={styles.detailValue}>{claim.submittedDate}</span>
                </div>
                <div style={styles.claimDetail}>
                  <span style={styles.detailLabel}>Amount</span>
                  <span style={styles.detailValue}>${claim.amount}</span>
                </div>
                <div style={styles.claimDetail}>
                  <span style={styles.detailLabel}>Approved</span>
                  <span style={{ ...styles.detailValue, color: '#10b981' }}>
                    {claim.approvedAmount !== null ? `$${claim.approvedAmount}` : '-'}
                  </span>
                </div>
              </div>

              {claim.denialReason && (
                <div style={styles.denialReason}>
                  <strong>Denial Reason:</strong> {claim.denialReason}
                </div>
              )}
            </div>
          ))
        )}
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
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
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
  newClaimBtn: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    padding: '0.75rem 1.5rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 500,
  },
  statsGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(4, 1fr)',
    gap: '1rem',
    marginBottom: '2rem',
  },
  statCard: {
    background: 'white',
    padding: '1.25rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    textAlign: 'center',
  },
  statValue: {
    fontSize: '1.5rem',
    fontWeight: 700,
    color: '#1f2937',
  },
  statLabel: {
    fontSize: '0.875rem',
    color: '#6b7280',
  },
  filters: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '1.5rem',
    flexWrap: 'wrap',
    gap: '1rem',
  },
  searchBox: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
    padding: '0.75rem 1rem',
    background: 'white',
    borderRadius: '0.5rem',
    border: '2px solid #e5e7eb',
    flex: '1',
    maxWidth: '400px',
  },
  searchInput: {
    border: 'none',
    outline: 'none',
    flex: 1,
    fontSize: '0.875rem',
  },
  filterButtons: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
  },
  filterBtn: {
    padding: '0.5rem 1rem',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    fontWeight: 500,
    color: '#6b7280',
    background: 'white',
    border: '2px solid #e5e7eb',
    transition: 'all 0.2s ease',
  },
  filterBtnActive: {
    background: '#2563eb',
    color: 'white',
    borderColor: '#2563eb',
  },
  claimsList: {
    display: 'flex',
    flexDirection: 'column',
    gap: '1rem',
  },
  emptyState: {
    textAlign: 'center',
    padding: '3rem',
    color: '#6b7280',
  },
  claimCard: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
  },
  claimHeader: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '0.75rem',
  },
  claimId: {
    fontSize: '0.875rem',
    fontWeight: 600,
    color: '#2563eb',
  },
  statusBadge: {
    display: 'inline-flex',
    alignItems: 'center',
    gap: '0.375rem',
    padding: '0.375rem 0.75rem',
    borderRadius: '9999px',
    fontSize: '0.75rem',
    fontWeight: 500,
    textTransform: 'capitalize',
  },
  claimDescription: {
    fontSize: '1rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  claimProvider: {
    fontSize: '0.875rem',
    color: '#6b7280',
    marginBottom: '1rem',
  },
  claimDetails: {
    display: 'grid',
    gridTemplateColumns: 'repeat(4, 1fr)',
    gap: '1rem',
    padding: '1rem 0',
    borderTop: '1px solid #e5e7eb',
  },
  claimDetail: {
    display: 'flex',
    flexDirection: 'column',
  },
  detailLabel: {
    fontSize: '0.75rem',
    color: '#6b7280',
    marginBottom: '0.25rem',
  },
  detailValue: {
    fontWeight: 500,
    color: '#1f2937',
  },
  denialReason: {
    marginTop: '1rem',
    padding: '0.75rem',
    background: '#fee2e2',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    color: '#991b1b',
  },
};

export default Claims;
