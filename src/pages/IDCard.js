import React from 'react';
import { useApp } from '../context/AppContext';
import { Download, Printer, Share2, Shield, Phone, Globe } from 'lucide-react';

const IDCard = () => {
  const { user, policies } = useApp();
  const primaryPolicy = policies[0];

  return (
    <div style={styles.container}>
      <div style={styles.header}>
        <h2 style={styles.title}>Digital ID Card</h2>
        <p style={styles.subtitle}>Your insurance identification card</p>
      </div>

      <div style={styles.cardActions}>
        <button style={styles.actionBtn}>
          <Download size={20} />
          Download PDF
        </button>
        <button style={styles.actionBtn}>
          <Printer size={20} />
          Print Card
        </button>
        <button style={styles.actionBtn}>
          <Share2 size={20} />
          Share
        </button>
      </div>

      {/* Front of Card */}
      <div style={styles.idCard}>
        <div style={styles.cardFront}>
          <div style={styles.cardLogo}>
            <Shield size={28} color="white" />
            <span style={styles.cardLogoText}>HealthGuard</span>
          </div>

          <div style={styles.cardBrand}>
            <span style={styles.planName}>{primaryPolicy?.name}</span>
            <span style={styles.planType}>{primaryPolicy?.type} Plan</span>
          </div>

          <div style={styles.memberInfo}>
            <div style={styles.infoRow}>
              <div style={styles.infoItem}>
                <span style={styles.infoLabel}>Member Name</span>
                <span style={styles.infoValue}>{user?.firstName} {user?.lastName}</span>
              </div>
              <div style={styles.infoItem}>
                <span style={styles.infoLabel}>Member ID</span>
                <span style={styles.infoValue}>{user?.memberId}</span>
              </div>
            </div>
            <div style={styles.infoRow}>
              <div style={styles.infoItem}>
                <span style={styles.infoLabel}>Group Number</span>
                <span style={styles.infoValue}>GRP-2024-001</span>
              </div>
              <div style={styles.infoItem}>
                <span style={styles.infoLabel}>Policy Number</span>
                <span style={styles.infoValue}>{primaryPolicy?.policyNumber}</span>
              </div>
            </div>
            <div style={styles.infoRow}>
              <div style={styles.infoItem}>
                <span style={styles.infoLabel}>Effective Date</span>
                <span style={styles.infoValue}>{primaryPolicy?.startDate}</span>
              </div>
              <div style={styles.infoItem}>
                <span style={styles.infoLabel}>Copay</span>
                <span style={styles.infoValue}>${primaryPolicy?.copay}</span>
              </div>
            </div>
          </div>

          <div style={styles.cardChip}></div>
        </div>

        <p style={styles.cardSide}>Front of Card</p>
      </div>

      {/* Back of Card */}
      <div style={styles.idCard}>
        <div style={styles.cardBack}>
          <div style={styles.backHeader}>
            <Shield size={20} color="#2563eb" />
            <span style={styles.backTitle}>HealthGuard Insurance</span>
          </div>

          <div style={styles.backContent}>
            <div style={styles.contactSection}>
              <h4 style={styles.contactTitle}>Important Contact Numbers</h4>
              <div style={styles.contactItem}>
                <Phone size={14} color="#2563eb" />
                <span>Member Services: 1-800-HEALTH</span>
              </div>
              <div style={styles.contactItem}>
                <Phone size={14} color="#ef4444" />
                <span>24/7 Emergency: 1-800-911-HELP</span>
              </div>
              <div style={styles.contactItem}>
                <Globe size={14} color="#2563eb" />
                <span>www.healthguard.com</span>
              </div>
            </div>

            <div style={styles.claimsSection}>
              <h4 style={styles.contactTitle}>Claims Address</h4>
              <p style={styles.addressText}>
                HealthGuard Insurance<br />
                P.O. Box 12345<br />
                Claims Processing Center<br />
                San Francisco, CA 94102
              </p>
            </div>

            <div style={styles.noticeSection}>
              <p style={styles.noticeText}>
                This card is for identification only. It does not guarantee coverage or payment.
                Present this card when obtaining medical services.
              </p>
            </div>

            <div style={styles.barcode}>
              <div style={styles.barcodeLines}></div>
              <span style={styles.barcodeNumber}>{user?.memberId}</span>
            </div>
          </div>
        </div>

        <p style={styles.cardSide}>Back of Card</p>
      </div>

      {/* Coverage Summary */}
      <div style={styles.coverageSection}>
        <h3 style={styles.sectionTitle}>Coverage Summary</h3>
        <div style={styles.coverageGrid}>
          <div style={styles.coverageItem}>
            <span style={styles.coverageLabel}>Deductible</span>
            <span style={styles.coverageValue}>${primaryPolicy?.deductible}</span>
          </div>
          <div style={styles.coverageItem}>
            <span style={styles.coverageLabel}>Out-of-Pocket Max</span>
            <span style={styles.coverageValue}>$5,000</span>
          </div>
          <div style={styles.coverageItem}>
            <span style={styles.coverageLabel}>Primary Care Copay</span>
            <span style={styles.coverageValue}>${primaryPolicy?.copay}</span>
          </div>
          <div style={styles.coverageItem}>
            <span style={styles.coverageLabel}>Specialist Copay</span>
            <span style={styles.coverageValue}>$50</span>
          </div>
          <div style={styles.coverageItem}>
            <span style={styles.coverageLabel}>Emergency Room</span>
            <span style={styles.coverageValue}>$150</span>
          </div>
          <div style={styles.coverageItem}>
            <span style={styles.coverageLabel}>Prescription (Generic)</span>
            <span style={styles.coverageValue}>$10</span>
          </div>
        </div>
      </div>
    </div>
  );
};

const styles = {
  container: {
    maxWidth: '800px',
    margin: '0 auto',
  },
  header: {
    marginBottom: '1.5rem',
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
  cardActions: {
    display: 'flex',
    gap: '1rem',
    marginBottom: '2rem',
  },
  actionBtn: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    padding: '0.75rem 1.25rem',
    background: 'white',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontWeight: 500,
    color: '#374151',
    cursor: 'pointer',
  },
  idCard: {
    marginBottom: '2rem',
  },
  cardFront: {
    background: 'linear-gradient(135deg, #1e40af 0%, #3b82f6 100%)',
    borderRadius: '1rem',
    padding: '1.5rem',
    color: 'white',
    position: 'relative',
    minHeight: '220px',
  },
  cardLogo: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    marginBottom: '1rem',
  },
  cardLogoText: {
    fontSize: '1.25rem',
    fontWeight: 700,
  },
  cardBrand: {
    position: 'absolute',
    top: '1.5rem',
    right: '1.5rem',
    textAlign: 'right',
  },
  planName: {
    display: 'block',
    fontSize: '0.875rem',
    fontWeight: 600,
  },
  planType: {
    fontSize: '0.75rem',
    opacity: 0.8,
  },
  memberInfo: {
    marginTop: '1.5rem',
  },
  infoRow: {
    display: 'flex',
    gap: '2rem',
    marginBottom: '0.75rem',
  },
  infoItem: {
    flex: 1,
  },
  infoLabel: {
    display: 'block',
    fontSize: '0.625rem',
    textTransform: 'uppercase',
    opacity: 0.8,
    marginBottom: '0.125rem',
  },
  infoValue: {
    fontSize: '0.875rem',
    fontWeight: 500,
  },
  cardChip: {
    position: 'absolute',
    bottom: '1.5rem',
    right: '1.5rem',
    width: '40px',
    height: '30px',
    background: 'linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%)',
    borderRadius: '4px',
  },
  cardSide: {
    textAlign: 'center',
    marginTop: '0.75rem',
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  cardBack: {
    background: 'white',
    borderRadius: '1rem',
    padding: '1.5rem',
    border: '2px solid #e5e7eb',
    minHeight: '220px',
  },
  backHeader: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    marginBottom: '1rem',
    paddingBottom: '0.75rem',
    borderBottom: '1px solid #e5e7eb',
  },
  backTitle: {
    fontWeight: 600,
    color: '#1e40af',
  },
  backContent: {
    fontSize: '0.75rem',
  },
  contactSection: {
    marginBottom: '1rem',
  },
  contactTitle: {
    fontWeight: 600,
    color: '#374151',
    marginBottom: '0.5rem',
    fontSize: '0.8rem',
  },
  contactItem: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    marginBottom: '0.25rem',
    color: '#374151',
  },
  claimsSection: {
    marginBottom: '1rem',
  },
  addressText: {
    color: '#6b7280',
    lineHeight: 1.4,
  },
  noticeSection: {
    marginBottom: '1rem',
  },
  noticeText: {
    color: '#6b7280',
    fontStyle: 'italic',
    fontSize: '0.625rem',
  },
  barcode: {
    textAlign: 'center',
  },
  barcodeLines: {
    height: '30px',
    background: 'repeating-linear-gradient(90deg, #000 0px, #000 2px, #fff 2px, #fff 4px)',
    marginBottom: '0.25rem',
  },
  barcodeNumber: {
    fontFamily: 'monospace',
    fontSize: '0.75rem',
    color: '#374151',
  },
  coverageSection: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
  },
  sectionTitle: {
    fontSize: '1rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '1rem',
  },
  coverageGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: '1rem',
  },
  coverageItem: {
    padding: '1rem',
    background: '#f9fafb',
    borderRadius: '0.5rem',
    textAlign: 'center',
  },
  coverageLabel: {
    display: 'block',
    fontSize: '0.75rem',
    color: '#6b7280',
    marginBottom: '0.25rem',
  },
  coverageValue: {
    fontSize: '1.125rem',
    fontWeight: 600,
    color: '#2563eb',
  },
};

export default IDCard;
