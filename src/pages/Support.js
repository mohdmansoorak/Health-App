import React, { useState } from 'react';
import { Phone, Mail, MessageCircle, HelpCircle, ChevronDown, ChevronUp, FileText, Clock, ExternalLink } from 'lucide-react';

const Support = () => {
  const [openFaq, setOpenFaq] = useState(null);

  const faqs = [
    {
      id: 1,
      question: 'How do I file a claim?',
      answer: 'To file a claim, go to the Claims section and click "File New Claim". Fill in the required information including the policy, service type, provider details, and amount. Upload any supporting documents such as bills or receipts, then submit your claim for processing.',
    },
    {
      id: 2,
      question: 'How long does claim processing take?',
      answer: 'Most claims are processed within 5-7 business days. Complex claims may take up to 14 business days. You can track the status of your claim in the Claims section of your dashboard.',
    },
    {
      id: 3,
      question: 'What is a deductible?',
      answer: 'A deductible is the amount you pay out-of-pocket for covered health care services before your insurance plan starts to pay. For example, with a $1,500 deductible, you pay the first $1,500 of covered services yourself.',
    },
    {
      id: 4,
      question: 'How do I add a family member to my policy?',
      answer: 'To add a family member, go to your Profile page and click "Add Member" in the Family Members section. You will need to provide their personal information and relationship to you. Additional premiums may apply.',
    },
    {
      id: 5,
      question: 'What does "in-network" mean?',
      answer: 'In-network providers are doctors, hospitals, and other healthcare providers that have contracted with your insurance company to provide services at negotiated rates. Using in-network providers typically results in lower out-of-pocket costs for you.',
    },
    {
      id: 6,
      question: 'How can I update my payment method?',
      answer: 'Go to the Payments section and click on "Add Payment Method" to add a new card or bank account. You can also set your default payment method for automatic premium payments.',
    },
    {
      id: 7,
      question: 'What is a copay?',
      answer: 'A copay (copayment) is a fixed amount you pay for a covered health care service after you have paid your deductible. For example, you might pay $25 for a doctor visit or $10 for a prescription.',
    },
    {
      id: 8,
      question: 'How do I get a copy of my ID card?',
      answer: 'You can view and download your digital ID card from the ID Card section. You can also print it or share it directly from the app. Physical cards can be requested by contacting member services.',
    },
  ];

  const contactOptions = [
    {
      icon: Phone,
      title: 'Call Us',
      description: 'Speak with a representative',
      action: '1-800-HEALTH',
      actionLabel: 'Call Now',
    },
    {
      icon: MessageCircle,
      title: 'Live Chat',
      description: 'Chat with support online',
      action: 'Start Chat',
      actionLabel: 'Start Chat',
    },
    {
      icon: Mail,
      title: 'Email',
      description: 'Send us an email',
      action: 'support@healthguard.com',
      actionLabel: 'Send Email',
    },
  ];

  const resources = [
    { icon: FileText, title: 'Policy Documents', description: 'Download your policy documents' },
    { icon: HelpCircle, title: 'Coverage Guide', description: 'Understand your benefits' },
    { icon: Clock, title: 'Claims History', description: 'View all your past claims' },
  ];

  return (
    <div style={styles.container}>
      <div style={styles.header}>
        <h2 style={styles.title}>Help & Support</h2>
        <p style={styles.subtitle}>Get help with your account and find answers to common questions</p>
      </div>

      {/* Contact Options */}
      <div style={styles.contactGrid}>
        {contactOptions.map((option, index) => (
          <div key={index} style={styles.contactCard}>
            <div style={styles.contactIcon}>
              <option.icon size={24} color="#2563eb" />
            </div>
            <h3 style={styles.contactTitle}>{option.title}</h3>
            <p style={styles.contactDesc}>{option.description}</p>
            <p style={styles.contactAction}>{option.action}</p>
            <button style={styles.contactBtn}>{option.actionLabel}</button>
          </div>
        ))}
      </div>

      {/* Operating Hours */}
      <div style={styles.hoursCard}>
        <Clock size={20} color="#2563eb" />
        <div>
          <p style={styles.hoursTitle}>Customer Service Hours</p>
          <p style={styles.hoursText}>Monday - Friday: 8:00 AM - 8:00 PM EST</p>
          <p style={styles.hoursText}>Saturday: 9:00 AM - 5:00 PM EST</p>
          <p style={styles.hoursText}>Sunday: Closed</p>
          <p style={styles.emergencyText}>24/7 Emergency Line: 1-800-911-HELP</p>
        </div>
      </div>

      {/* FAQs */}
      <div style={styles.faqSection}>
        <h3 style={styles.sectionTitle}>Frequently Asked Questions</h3>
        <div style={styles.faqList}>
          {faqs.map(faq => (
            <div key={faq.id} style={styles.faqItem}>
              <button
                onClick={() => setOpenFaq(openFaq === faq.id ? null : faq.id)}
                style={styles.faqQuestion}
              >
                <span>{faq.question}</span>
                {openFaq === faq.id ? (
                  <ChevronUp size={20} color="#6b7280" />
                ) : (
                  <ChevronDown size={20} color="#6b7280" />
                )}
              </button>
              {openFaq === faq.id && (
                <div style={styles.faqAnswer}>
                  {faq.answer}
                </div>
              )}
            </div>
          ))}
        </div>
      </div>

      {/* Quick Resources */}
      <div style={styles.resourcesSection}>
        <h3 style={styles.sectionTitle}>Quick Resources</h3>
        <div style={styles.resourcesGrid}>
          {resources.map((resource, index) => (
            <button key={index} style={styles.resourceCard}>
              <resource.icon size={24} color="#2563eb" />
              <div>
                <p style={styles.resourceTitle}>{resource.title}</p>
                <p style={styles.resourceDesc}>{resource.description}</p>
              </div>
              <ExternalLink size={16} color="#6b7280" />
            </button>
          ))}
        </div>
      </div>

      {/* Contact Form */}
      <div style={styles.formSection}>
        <h3 style={styles.sectionTitle}>Send Us a Message</h3>
        <form style={styles.contactForm}>
          <div style={styles.formRow}>
            <div style={styles.formGroup}>
              <label style={styles.label}>Name</label>
              <input type="text" style={styles.input} placeholder="Your name" />
            </div>
            <div style={styles.formGroup}>
              <label style={styles.label}>Email</label>
              <input type="email" style={styles.input} placeholder="Your email" />
            </div>
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Subject</label>
            <select style={styles.select}>
              <option value="">Select a topic</option>
              <option value="claims">Claims</option>
              <option value="billing">Billing & Payments</option>
              <option value="coverage">Coverage Questions</option>
              <option value="technical">Technical Support</option>
              <option value="other">Other</option>
            </select>
          </div>
          <div style={styles.formGroup}>
            <label style={styles.label}>Message</label>
            <textarea
              style={styles.textarea}
              rows={5}
              placeholder="How can we help you?"
            />
          </div>
          <button type="submit" style={styles.submitBtn}>Send Message</button>
        </form>
      </div>
    </div>
  );
};

const styles = {
  container: {
    maxWidth: '1000px',
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
  contactGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: '1.5rem',
    marginBottom: '1.5rem',
  },
  contactCard: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    textAlign: 'center',
  },
  contactIcon: {
    width: '56px',
    height: '56px',
    borderRadius: '50%',
    background: '#eff6ff',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    margin: '0 auto 1rem',
  },
  contactTitle: {
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  contactDesc: {
    fontSize: '0.875rem',
    color: '#6b7280',
    marginBottom: '0.75rem',
  },
  contactAction: {
    fontWeight: 600,
    color: '#2563eb',
    marginBottom: '1rem',
  },
  contactBtn: {
    width: '100%',
    padding: '0.625rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 500,
    fontSize: '0.875rem',
    cursor: 'pointer',
  },
  hoursCard: {
    display: 'flex',
    alignItems: 'flex-start',
    gap: '1rem',
    background: '#eff6ff',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    marginBottom: '2rem',
  },
  hoursTitle: {
    fontWeight: 600,
    color: '#1e40af',
    marginBottom: '0.5rem',
  },
  hoursText: {
    fontSize: '0.875rem',
    color: '#1e40af',
    marginBottom: '0.25rem',
  },
  emergencyText: {
    fontSize: '0.875rem',
    fontWeight: 600,
    color: '#dc2626',
    marginTop: '0.5rem',
  },
  faqSection: {
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
  faqList: {
    display: 'flex',
    flexDirection: 'column',
  },
  faqItem: {
    borderBottom: '1px solid #e5e7eb',
  },
  faqQuestion: {
    width: '100%',
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '1rem 0',
    fontWeight: 500,
    color: '#1f2937',
    textAlign: 'left',
    cursor: 'pointer',
    background: 'none',
  },
  faqAnswer: {
    padding: '0 0 1rem',
    color: '#6b7280',
    fontSize: '0.875rem',
    lineHeight: 1.6,
  },
  resourcesSection: {
    marginBottom: '1.5rem',
  },
  resourcesGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(3, 1fr)',
    gap: '1rem',
  },
  resourceCard: {
    display: 'flex',
    alignItems: 'center',
    gap: '1rem',
    padding: '1rem',
    background: 'white',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    cursor: 'pointer',
    textAlign: 'left',
    width: '100%',
  },
  resourceTitle: {
    fontWeight: 500,
    color: '#1f2937',
    marginBottom: '0.125rem',
  },
  resourceDesc: {
    fontSize: '0.75rem',
    color: '#6b7280',
  },
  formSection: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
  },
  contactForm: {
    display: 'flex',
    flexDirection: 'column',
    gap: '1rem',
  },
  formRow: {
    display: 'grid',
    gridTemplateColumns: 'repeat(2, 1fr)',
    gap: '1rem',
  },
  formGroup: {
    display: 'flex',
    flexDirection: 'column',
  },
  label: {
    marginBottom: '0.5rem',
    fontWeight: 500,
    color: '#374151',
    fontSize: '0.875rem',
  },
  input: {
    padding: '0.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
  },
  select: {
    padding: '0.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    background: 'white',
  },
  textarea: {
    padding: '0.75rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
    resize: 'vertical',
  },
  submitBtn: {
    padding: '0.875rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 600,
    cursor: 'pointer',
    alignSelf: 'flex-start',
  },
};

export default Support;
