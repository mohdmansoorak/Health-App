import React from 'react';
import { Link } from 'react-router-dom';
import { useApp } from '../context/AppContext';
import {
  FileText,
  ClipboardList,
  CreditCard,
  AlertCircle,
  CheckCircle,
  Clock,
  TrendingUp,
  Calendar,
  ArrowRight
} from 'lucide-react';

const Dashboard = () => {
  const { user, policies, claims, payments } = useApp();

  const activePolicies = policies.filter(p => p.status === 'active');
  const pendingClaims = claims.filter(c => c.status === 'pending').length;
  const approvedClaims = claims.filter(c => c.status === 'approved').length;
  const totalCoverage = activePolicies.reduce((sum, p) => sum + p.coverageAmount, 0);
  const monthlyPremium = activePolicies.reduce((sum, p) => sum + p.premium, 0);

  const recentClaims = claims.slice(0, 3);
  const recentPayments = payments.slice(0, 3);

  const getStatusBadge = (status) => {
    const styles = {
      approved: { background: '#d1fae5', color: '#065f46' },
      pending: { background: '#fef3c7', color: '#92400e' },
      denied: { background: '#fee2e2', color: '#991b1b' },
    };
    return styles[status] || styles.pending;
  };

  return (
    <div style={styles.dashboard}>
      {/* Quick Stats */}
      <div style={styles.statsGrid}>
        <div style={styles.statCard}>
          <div style={styles.statIcon}>
            <FileText size={24} color="#2563eb" />
          </div>
          <div>
            <p style={styles.statLabel}>Active Policies</p>
            <p style={styles.statValue}>{activePolicies.length}</p>
          </div>
        </div>

        <div style={styles.statCard}>
          <div style={styles.statIcon}>
            <TrendingUp size={24} color="#2563eb" />
          </div>
          <div>
            <p style={styles.statLabel}>Total Coverage</p>
            <p style={styles.statValue}>${totalCoverage.toLocaleString()}</p>
          </div>
        </div>

        <div style={styles.statCard}>
          <div style={styles.statIcon}>
            <CreditCard size={24} color="#2563eb" />
          </div>
          <div>
            <p style={styles.statLabel}>Monthly Premium</p>
            <p style={styles.statValue}>${monthlyPremium}</p>
          </div>
        </div>

        <div style={styles.statCard}>
          <div style={styles.statIcon}>
            <ClipboardList size={24} color="#2563eb" />
          </div>
          <div>
            <p style={styles.statLabel}>Pending Claims</p>
            <p style={styles.statValue}>{pendingClaims}</p>
          </div>
        </div>
      </div>

      {/* Main Content Grid */}
      <div style={styles.contentGrid}>
        {/* Active Policies */}
        <div style={styles.card}>
          <div style={styles.cardHeader}>
            <h3 style={styles.cardTitle}>My Policies</h3>
            <Link to="/policies" style={styles.viewAll}>
              View All <ArrowRight size={16} />
            </Link>
          </div>
          <div style={styles.cardContent}>
            {activePolicies.map(policy => (
              <div key={policy.id} style={styles.policyItem}>
                <div style={styles.policyInfo}>
                  <h4 style={styles.policyName}>{policy.name}</h4>
                  <p style={styles.policyNumber}>{policy.policyNumber}</p>
                </div>
                <div style={styles.policyMeta}>
                  <span style={styles.policyType}>{policy.type}</span>
                  <p style={styles.policyExpiry}>
                    <Calendar size={14} />
                    Expires: {policy.endDate}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Claims Summary */}
        <div style={styles.card}>
          <div style={styles.cardHeader}>
            <h3 style={styles.cardTitle}>Claims Summary</h3>
            <Link to="/claims" style={styles.viewAll}>
              View All <ArrowRight size={16} />
            </Link>
          </div>
          <div style={styles.claimsSummary}>
            <div style={styles.summaryItem}>
              <CheckCircle size={20} color="#10b981" />
              <span style={styles.summaryLabel}>Approved</span>
              <span style={styles.summaryValue}>{approvedClaims}</span>
            </div>
            <div style={styles.summaryItem}>
              <Clock size={20} color="#f59e0b" />
              <span style={styles.summaryLabel}>Pending</span>
              <span style={styles.summaryValue}>{pendingClaims}</span>
            </div>
            <div style={styles.summaryItem}>
              <AlertCircle size={20} color="#ef4444" />
              <span style={styles.summaryLabel}>Denied</span>
              <span style={styles.summaryValue}>
                {claims.filter(c => c.status === 'denied').length}
              </span>
            </div>
          </div>
        </div>

        {/* Recent Claims */}
        <div style={styles.card}>
          <div style={styles.cardHeader}>
            <h3 style={styles.cardTitle}>Recent Claims</h3>
            <Link to="/claims/new" style={styles.newClaimBtn}>
              File New Claim
            </Link>
          </div>
          <div style={styles.cardContent}>
            {recentClaims.map(claim => (
              <div key={claim.id} style={styles.claimItem}>
                <div style={styles.claimInfo}>
                  <h4 style={styles.claimDesc}>{claim.description}</h4>
                  <p style={styles.claimProvider}>{claim.provider}</p>
                </div>
                <div style={styles.claimMeta}>
                  <p style={styles.claimAmount}>${claim.amount}</p>
                  <span style={{
                    ...styles.statusBadge,
                    ...getStatusBadge(claim.status)
                  }}>
                    {claim.status}
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Recent Payments */}
        <div style={styles.card}>
          <div style={styles.cardHeader}>
            <h3 style={styles.cardTitle}>Recent Payments</h3>
            <Link to="/payments" style={styles.viewAll}>
              View All <ArrowRight size={16} />
            </Link>
          </div>
          <div style={styles.cardContent}>
            {recentPayments.map(payment => (
              <div key={payment.id} style={styles.paymentItem}>
                <div style={styles.paymentInfo}>
                  <h4 style={styles.paymentDesc}>{payment.description}</h4>
                  <p style={styles.paymentDate}>{payment.date}</p>
                </div>
                <div style={styles.paymentAmount}>
                  ${payment.amount}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div style={styles.quickActions}>
        <h3 style={styles.actionsTitle}>Quick Actions</h3>
        <div style={styles.actionsGrid}>
          <Link to="/claims/new" style={styles.actionCard}>
            <ClipboardList size={24} color="#2563eb" />
            <span>File a Claim</span>
          </Link>
          <Link to="/providers" style={styles.actionCard}>
            <FileText size={24} color="#2563eb" />
            <span>Find Provider</span>
          </Link>
          <Link to="/id-card" style={styles.actionCard}>
            <CreditCard size={24} color="#2563eb" />
            <span>View ID Card</span>
          </Link>
          <Link to="/payments" style={styles.actionCard}>
            <TrendingUp size={24} color="#2563eb" />
            <span>Make Payment</span>
          </Link>
        </div>
      </div>
    </div>
  );
};

const styles = {
  dashboard: {
    maxWidth: '1200px',
    margin: '0 auto',
  },
  statsGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
    gap: '1rem',
    marginBottom: '2rem',
  },
  statCard: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    display: 'flex',
    alignItems: 'center',
    gap: '1rem',
  },
  statIcon: {
    width: '48px',
    height: '48px',
    borderRadius: '0.75rem',
    background: '#eff6ff',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  statLabel: {
    color: '#6b7280',
    fontSize: '0.875rem',
  },
  statValue: {
    fontSize: '1.5rem',
    fontWeight: 700,
    color: '#1f2937',
  },
  contentGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(2, 1fr)',
    gap: '1.5rem',
    marginBottom: '2rem',
  },
  card: {
    background: 'white',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    overflow: 'hidden',
  },
  cardHeader: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '1rem 1.5rem',
    borderBottom: '1px solid #e5e7eb',
  },
  cardTitle: {
    fontSize: '1rem',
    fontWeight: 600,
    color: '#1f2937',
  },
  viewAll: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.25rem',
    color: '#2563eb',
    fontSize: '0.875rem',
    fontWeight: 500,
  },
  newClaimBtn: {
    padding: '0.5rem 1rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    fontWeight: 500,
  },
  cardContent: {
    padding: '1rem 1.5rem',
  },
  policyItem: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '0.75rem 0',
    borderBottom: '1px solid #f3f4f6',
  },
  policyInfo: {},
  policyName: {
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  policyNumber: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  policyMeta: {
    textAlign: 'right',
  },
  policyType: {
    display: 'inline-block',
    padding: '0.25rem 0.5rem',
    background: '#eff6ff',
    color: '#1e40af',
    borderRadius: '0.25rem',
    fontSize: '0.75rem',
    fontWeight: 500,
    marginBottom: '0.25rem',
  },
  policyExpiry: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.25rem',
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  claimsSummary: {
    padding: '1.5rem',
    display: 'flex',
    justifyContent: 'space-around',
  },
  summaryItem: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    gap: '0.5rem',
  },
  summaryLabel: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  summaryValue: {
    fontSize: '1.25rem',
    fontWeight: 700,
    color: '#1f2937',
  },
  claimItem: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '0.75rem 0',
    borderBottom: '1px solid #f3f4f6',
  },
  claimInfo: {},
  claimDesc: {
    fontWeight: 500,
    color: '#1f2937',
    marginBottom: '0.25rem',
    fontSize: '0.875rem',
  },
  claimProvider: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  claimMeta: {
    textAlign: 'right',
  },
  claimAmount: {
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  statusBadge: {
    display: 'inline-block',
    padding: '0.25rem 0.5rem',
    borderRadius: '9999px',
    fontSize: '0.75rem',
    fontWeight: 500,
    textTransform: 'capitalize',
  },
  paymentItem: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '0.75rem 0',
    borderBottom: '1px solid #f3f4f6',
  },
  paymentInfo: {},
  paymentDesc: {
    fontWeight: 500,
    color: '#1f2937',
    marginBottom: '0.25rem',
    fontSize: '0.875rem',
  },
  paymentDate: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  paymentAmount: {
    fontWeight: 600,
    color: '#10b981',
  },
  quickActions: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
  },
  actionsTitle: {
    fontSize: '1rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '1rem',
  },
  actionsGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(4, 1fr)',
    gap: '1rem',
  },
  actionCard: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    gap: '0.5rem',
    padding: '1rem',
    background: '#eff6ff',
    borderRadius: '0.5rem',
    color: '#1e40af',
    fontWeight: 500,
    fontSize: '0.875rem',
    transition: 'all 0.2s ease',
  },
};

export default Dashboard;
