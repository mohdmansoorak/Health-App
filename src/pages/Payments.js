import React, { useState } from 'react';
import { useApp } from '../context/AppContext';
import { CreditCard, Calendar, CheckCircle, DollarSign, Plus, Building } from 'lucide-react';

const Payments = () => {
  const { policies, payments, makePayment } = useApp();
  const [showPaymentModal, setShowPaymentModal] = useState(false);
  const [paymentData, setPaymentData] = useState({
    policyId: '',
    amount: '',
    method: 'credit-card',
  });

  const totalPremiums = policies.reduce((sum, p) => sum + p.premium, 0);

  const handleSubmitPayment = (e) => {
    e.preventDefault();
    const policy = policies.find(p => p.id === paymentData.policyId);
    makePayment({
      policyId: paymentData.policyId,
      amount: parseFloat(paymentData.amount),
      method: paymentData.method === 'credit-card' ? 'Credit Card' : 'Bank Transfer',
      description: `${new Date().toLocaleString('default', { month: 'long' })} ${new Date().getFullYear()} Premium`,
    });
    setShowPaymentModal(false);
    setPaymentData({ policyId: '', amount: '', method: 'credit-card' });
  };

  return (
    <div style={styles.container}>
      <div style={styles.header}>
        <div>
          <h2 style={styles.title}>Payments</h2>
          <p style={styles.subtitle}>Manage your premium payments and billing</p>
        </div>
        <button
          onClick={() => setShowPaymentModal(true)}
          style={styles.payBtn}
        >
          <Plus size={20} />
          Make Payment
        </button>
      </div>

      {/* Payment Summary */}
      <div style={styles.summaryGrid}>
        <div style={styles.summaryCard}>
          <div style={styles.summaryIcon}>
            <DollarSign size={24} color="#2563eb" />
          </div>
          <div>
            <p style={styles.summaryLabel}>Monthly Premium</p>
            <p style={styles.summaryValue}>${totalPremiums}</p>
          </div>
        </div>

        <div style={styles.summaryCard}>
          <div style={styles.summaryIcon}>
            <Calendar size={24} color="#2563eb" />
          </div>
          <div>
            <p style={styles.summaryLabel}>Next Due Date</p>
            <p style={styles.summaryValue}>Dec 1, 2024</p>
          </div>
        </div>

        <div style={styles.summaryCard}>
          <div style={styles.summaryIcon}>
            <CheckCircle size={24} color="#10b981" />
          </div>
          <div>
            <p style={styles.summaryLabel}>Payment Status</p>
            <p style={{ ...styles.summaryValue, color: '#10b981' }}>Current</p>
          </div>
        </div>

        <div style={styles.summaryCard}>
          <div style={styles.summaryIcon}>
            <CreditCard size={24} color="#2563eb" />
          </div>
          <div>
            <p style={styles.summaryLabel}>Auto-Pay</p>
            <p style={styles.summaryValue}>Enabled</p>
          </div>
        </div>
      </div>

      {/* Payment Methods */}
      <div style={styles.section}>
        <h3 style={styles.sectionTitle}>Payment Methods</h3>
        <div style={styles.methodsGrid}>
          <div style={styles.methodCard}>
            <div style={styles.methodHeader}>
              <CreditCard size={24} color="#2563eb" />
              <span style={styles.defaultBadge}>Default</span>
            </div>
            <p style={styles.cardType}>Visa ending in 4242</p>
            <p style={styles.cardExpiry}>Expires 12/2025</p>
          </div>
          <div style={styles.methodCard}>
            <div style={styles.methodHeader}>
              <Building size={24} color="#2563eb" />
            </div>
            <p style={styles.cardType}>Bank Account</p>
            <p style={styles.cardExpiry}>Checking ***1234</p>
          </div>
          <button style={styles.addMethodCard}>
            <Plus size={24} color="#6b7280" />
            <span>Add Payment Method</span>
          </button>
        </div>
      </div>

      {/* Payment History */}
      <div style={styles.section}>
        <h3 style={styles.sectionTitle}>Payment History</h3>
        <div style={styles.historyTable}>
          <div style={styles.tableHeader}>
            <span>Date</span>
            <span>Description</span>
            <span>Method</span>
            <span>Amount</span>
            <span>Status</span>
          </div>
          {payments.map(payment => (
            <div key={payment.id} style={styles.tableRow}>
              <span style={styles.cellDate}>{payment.date}</span>
              <span style={styles.cellDesc}>{payment.description}</span>
              <span style={styles.cellMethod}>{payment.method}</span>
              <span style={styles.cellAmount}>${payment.amount}</span>
              <span style={styles.cellStatus}>
                <span style={styles.statusBadge}>
                  <CheckCircle size={14} />
                  {payment.status}
                </span>
              </span>
            </div>
          ))}
        </div>
      </div>

      {/* Payment Modal */}
      {showPaymentModal && (
        <div style={styles.modalOverlay}>
          <div style={styles.modal}>
            <h3 style={styles.modalTitle}>Make a Payment</h3>
            <form onSubmit={handleSubmitPayment}>
              <div style={styles.modalField}>
                <label style={styles.modalLabel}>Select Policy</label>
                <select
                  value={paymentData.policyId}
                  onChange={(e) => setPaymentData({ ...paymentData, policyId: e.target.value })}
                  style={styles.modalSelect}
                  required
                >
                  <option value="">Choose a policy</option>
                  {policies.map(policy => (
                    <option key={policy.id} value={policy.id}>
                      {policy.name} - ${policy.premium}/month
                    </option>
                  ))}
                </select>
              </div>

              <div style={styles.modalField}>
                <label style={styles.modalLabel}>Amount</label>
                <input
                  type="number"
                  value={paymentData.amount}
                  onChange={(e) => setPaymentData({ ...paymentData, amount: e.target.value })}
                  placeholder="0.00"
                  style={styles.modalInput}
                  required
                />
              </div>

              <div style={styles.modalField}>
                <label style={styles.modalLabel}>Payment Method</label>
                <select
                  value={paymentData.method}
                  onChange={(e) => setPaymentData({ ...paymentData, method: e.target.value })}
                  style={styles.modalSelect}
                >
                  <option value="credit-card">Visa ending in 4242</option>
                  <option value="bank">Bank Account ***1234</option>
                </select>
              </div>

              <div style={styles.modalActions}>
                <button
                  type="button"
                  onClick={() => setShowPaymentModal(false)}
                  style={styles.cancelBtn}
                >
                  Cancel
                </button>
                <button type="submit" style={styles.submitBtn}>
                  Pay Now
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
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
  payBtn: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    padding: '0.75rem 1.5rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 500,
    cursor: 'pointer',
  },
  summaryGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(4, 1fr)',
    gap: '1rem',
    marginBottom: '2rem',
  },
  summaryCard: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    display: 'flex',
    alignItems: 'center',
    gap: '1rem',
  },
  summaryIcon: {
    width: '48px',
    height: '48px',
    borderRadius: '0.75rem',
    background: '#eff6ff',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  summaryLabel: {
    color: '#6b7280',
    fontSize: '0.875rem',
  },
  summaryValue: {
    fontSize: '1.25rem',
    fontWeight: 600,
    color: '#1f2937',
  },
  section: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    marginBottom: '1.5rem',
  },
  sectionTitle: {
    fontSize: '1rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '1rem',
  },
  methodsGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: '1rem',
  },
  methodCard: {
    padding: '1rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.75rem',
  },
  methodHeader: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '0.75rem',
  },
  defaultBadge: {
    fontSize: '0.625rem',
    fontWeight: 600,
    color: '#2563eb',
    background: '#eff6ff',
    padding: '0.25rem 0.5rem',
    borderRadius: '0.25rem',
  },
  cardType: {
    fontWeight: 500,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  cardExpiry: {
    fontSize: '0.875rem',
    color: '#6b7280',
  },
  addMethodCard: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    gap: '0.5rem',
    padding: '1rem',
    border: '2px dashed #e5e7eb',
    borderRadius: '0.75rem',
    color: '#6b7280',
    cursor: 'pointer',
    background: 'none',
  },
  historyTable: {
    display: 'flex',
    flexDirection: 'column',
  },
  tableHeader: {
    display: 'grid',
    gridTemplateColumns: '1fr 2fr 1fr 1fr 1fr',
    padding: '0.75rem 1rem',
    background: '#f9fafb',
    borderRadius: '0.5rem',
    fontWeight: 600,
    color: '#374151',
    fontSize: '0.875rem',
  },
  tableRow: {
    display: 'grid',
    gridTemplateColumns: '1fr 2fr 1fr 1fr 1fr',
    padding: '0.75rem 1rem',
    borderBottom: '1px solid #f3f4f6',
    fontSize: '0.875rem',
    alignItems: 'center',
  },
  cellDate: {
    color: '#6b7280',
  },
  cellDesc: {
    fontWeight: 500,
    color: '#1f2937',
  },
  cellMethod: {
    color: '#6b7280',
  },
  cellAmount: {
    fontWeight: 600,
    color: '#1f2937',
  },
  cellStatus: {},
  statusBadge: {
    display: 'inline-flex',
    alignItems: 'center',
    gap: '0.25rem',
    padding: '0.25rem 0.5rem',
    background: '#d1fae5',
    color: '#065f46',
    borderRadius: '9999px',
    fontSize: '0.75rem',
    fontWeight: 500,
    textTransform: 'capitalize',
  },
  modalOverlay: {
    position: 'fixed',
    inset: 0,
    background: 'rgba(0, 0, 0, 0.5)',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    zIndex: 1000,
  },
  modal: {
    background: 'white',
    padding: '2rem',
    borderRadius: '0.75rem',
    width: '100%',
    maxWidth: '400px',
  },
  modalTitle: {
    fontSize: '1.25rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '1.5rem',
  },
  modalField: {
    marginBottom: '1rem',
  },
  modalLabel: {
    display: 'block',
    marginBottom: '0.5rem',
    fontWeight: 500,
    color: '#374151',
    fontSize: '0.875rem',
  },
  modalInput: {
    width: '100%',
    padding: '0.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
  },
  modalSelect: {
    width: '100%',
    padding: '0.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    background: 'white',
  },
  modalActions: {
    display: 'flex',
    gap: '1rem',
    marginTop: '1.5rem',
  },
  cancelBtn: {
    flex: 1,
    padding: '0.75rem',
    borderRadius: '0.5rem',
    background: '#f3f4f6',
    color: '#374151',
    fontWeight: 500,
    cursor: 'pointer',
  },
  submitBtn: {
    flex: 1,
    padding: '0.75rem',
    borderRadius: '0.5rem',
    background: '#2563eb',
    color: 'white',
    fontWeight: 500,
    cursor: 'pointer',
  },
};

export default Payments;
