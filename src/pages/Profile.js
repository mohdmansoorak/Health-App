import React, { useState } from 'react';
import { useApp } from '../context/AppContext';
import { User, Mail, Phone, MapPin, Calendar, Users, Edit2, Save, X } from 'lucide-react';

const Profile = () => {
  const { user } = useApp();
  const [editing, setEditing] = useState(false);
  const [formData, setFormData] = useState({
    firstName: user?.firstName || '',
    lastName: user?.lastName || '',
    email: user?.email || '',
    phone: user?.phone || '',
    street: user?.address?.street || '',
    city: user?.address?.city || '',
    state: user?.address?.state || '',
    zipCode: user?.address?.zipCode || '',
  });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSave = () => {
    // Save logic would go here
    setEditing(false);
  };

  return (
    <div style={styles.container}>
      <div style={styles.header}>
        <h2 style={styles.title}>My Profile</h2>
        <p style={styles.subtitle}>Manage your personal information and preferences</p>
      </div>

      <div style={styles.profileGrid}>
        {/* Profile Card */}
        <div style={styles.profileCard}>
          <div style={styles.avatarSection}>
            <div style={styles.avatar}>
              {user?.firstName?.[0]}{user?.lastName?.[0]}
            </div>
            <div>
              <h3 style={styles.userName}>{user?.firstName} {user?.lastName}</h3>
              <p style={styles.memberId}>Member ID: {user?.memberId}</p>
              <p style={styles.memberSince}>Member since {user?.memberSince}</p>
            </div>
          </div>

          <div style={styles.quickInfo}>
            <div style={styles.infoItem}>
              <Mail size={18} color="#6b7280" />
              <span>{user?.email}</span>
            </div>
            <div style={styles.infoItem}>
              <Phone size={18} color="#6b7280" />
              <span>{user?.phone}</span>
            </div>
            <div style={styles.infoItem}>
              <Calendar size={18} color="#6b7280" />
              <span>DOB: {user?.dateOfBirth}</span>
            </div>
          </div>
        </div>

        {/* Personal Information */}
        <div style={styles.section}>
          <div style={styles.sectionHeader}>
            <h3 style={styles.sectionTitle}>Personal Information</h3>
            {!editing ? (
              <button onClick={() => setEditing(true)} style={styles.editBtn}>
                <Edit2 size={16} />
                Edit
              </button>
            ) : (
              <div style={styles.editActions}>
                <button onClick={() => setEditing(false)} style={styles.cancelBtn}>
                  <X size={16} />
                  Cancel
                </button>
                <button onClick={handleSave} style={styles.saveBtn}>
                  <Save size={16} />
                  Save
                </button>
              </div>
            )}
          </div>

          <div style={styles.formGrid}>
            <div style={styles.formGroup}>
              <label style={styles.label}>First Name</label>
              {editing ? (
                <input
                  type="text"
                  name="firstName"
                  value={formData.firstName}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.firstName}</p>
              )}
            </div>

            <div style={styles.formGroup}>
              <label style={styles.label}>Last Name</label>
              {editing ? (
                <input
                  type="text"
                  name="lastName"
                  value={formData.lastName}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.lastName}</p>
              )}
            </div>

            <div style={styles.formGroup}>
              <label style={styles.label}>Email Address</label>
              {editing ? (
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.email}</p>
              )}
            </div>

            <div style={styles.formGroup}>
              <label style={styles.label}>Phone Number</label>
              {editing ? (
                <input
                  type="tel"
                  name="phone"
                  value={formData.phone}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.phone}</p>
              )}
            </div>
          </div>
        </div>

        {/* Address */}
        <div style={styles.section}>
          <div style={styles.sectionHeader}>
            <h3 style={styles.sectionTitle}>
              <MapPin size={18} color="#2563eb" />
              Address
            </h3>
          </div>

          <div style={styles.formGrid}>
            <div style={{ ...styles.formGroup, gridColumn: '1 / -1' }}>
              <label style={styles.label}>Street Address</label>
              {editing ? (
                <input
                  type="text"
                  name="street"
                  value={formData.street}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.address?.street}</p>
              )}
            </div>

            <div style={styles.formGroup}>
              <label style={styles.label}>City</label>
              {editing ? (
                <input
                  type="text"
                  name="city"
                  value={formData.city}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.address?.city}</p>
              )}
            </div>

            <div style={styles.formGroup}>
              <label style={styles.label}>State</label>
              {editing ? (
                <input
                  type="text"
                  name="state"
                  value={formData.state}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.address?.state}</p>
              )}
            </div>

            <div style={styles.formGroup}>
              <label style={styles.label}>ZIP Code</label>
              {editing ? (
                <input
                  type="text"
                  name="zipCode"
                  value={formData.zipCode}
                  onChange={handleChange}
                  style={styles.input}
                />
              ) : (
                <p style={styles.value}>{user?.address?.zipCode}</p>
              )}
            </div>
          </div>
        </div>

        {/* Family Members */}
        <div style={styles.section}>
          <div style={styles.sectionHeader}>
            <h3 style={styles.sectionTitle}>
              <Users size={18} color="#2563eb" />
              Family Members
            </h3>
            <button style={styles.addBtn}>Add Member</button>
          </div>

          <div style={styles.familyList}>
            {user?.familyMembers?.map(member => (
              <div key={member.id} style={styles.familyCard}>
                <div style={styles.familyAvatar}>
                  {member.name.split(' ').map(n => n[0]).join('')}
                </div>
                <div style={styles.familyInfo}>
                  <p style={styles.familyName}>{member.name}</p>
                  <p style={styles.familyRelation}>{member.relationship}</p>
                </div>
                <div style={styles.familyDob}>
                  <p style={styles.dobLabel}>Date of Birth</p>
                  <p style={styles.dobValue}>{member.dateOfBirth}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Account Settings */}
        <div style={styles.section}>
          <h3 style={styles.sectionTitle}>Account Settings</h3>
          <div style={styles.settingsList}>
            <div style={styles.settingItem}>
              <div>
                <p style={styles.settingName}>Email Notifications</p>
                <p style={styles.settingDesc}>Receive updates about your policies and claims</p>
              </div>
              <label style={styles.toggle}>
                <input type="checkbox" defaultChecked />
                <span style={styles.toggleSlider}></span>
              </label>
            </div>
            <div style={styles.settingItem}>
              <div>
                <p style={styles.settingName}>SMS Alerts</p>
                <p style={styles.settingDesc}>Get text messages for important updates</p>
              </div>
              <label style={styles.toggle}>
                <input type="checkbox" defaultChecked />
                <span style={styles.toggleSlider}></span>
              </label>
            </div>
            <div style={styles.settingItem}>
              <div>
                <p style={styles.settingName}>Two-Factor Authentication</p>
                <p style={styles.settingDesc}>Add an extra layer of security</p>
              </div>
              <label style={styles.toggle}>
                <input type="checkbox" />
                <span style={styles.toggleSlider}></span>
              </label>
            </div>
          </div>
        </div>
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
  profileGrid: {
    display: 'flex',
    flexDirection: 'column',
    gap: '1.5rem',
  },
  profileCard: {
    background: 'linear-gradient(135deg, #1e40af 0%, #3b82f6 100%)',
    borderRadius: '0.75rem',
    padding: '2rem',
    color: 'white',
  },
  avatarSection: {
    display: 'flex',
    alignItems: 'center',
    gap: '1.5rem',
    marginBottom: '1.5rem',
  },
  avatar: {
    width: '80px',
    height: '80px',
    borderRadius: '50%',
    background: 'rgba(255, 255, 255, 0.2)',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    fontSize: '1.5rem',
    fontWeight: 600,
  },
  userName: {
    fontSize: '1.5rem',
    fontWeight: 600,
    marginBottom: '0.25rem',
  },
  memberId: {
    opacity: 0.9,
    marginBottom: '0.25rem',
  },
  memberSince: {
    fontSize: '0.875rem',
    opacity: 0.8,
  },
  quickInfo: {
    display: 'flex',
    gap: '2rem',
    flexWrap: 'wrap',
  },
  infoItem: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    fontSize: '0.875rem',
  },
  section: {
    background: 'white',
    borderRadius: '0.75rem',
    padding: '1.5rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
  },
  sectionHeader: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '1rem',
  },
  sectionTitle: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    fontSize: '1rem',
    fontWeight: 600,
    color: '#1f2937',
  },
  editBtn: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
    padding: '0.5rem 1rem',
    color: '#2563eb',
    fontWeight: 500,
    fontSize: '0.875rem',
    cursor: 'pointer',
  },
  editActions: {
    display: 'flex',
    gap: '0.5rem',
  },
  cancelBtn: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.25rem',
    padding: '0.5rem 1rem',
    color: '#6b7280',
    fontWeight: 500,
    fontSize: '0.875rem',
    cursor: 'pointer',
  },
  saveBtn: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.25rem',
    padding: '0.5rem 1rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 500,
    fontSize: '0.875rem',
    cursor: 'pointer',
  },
  addBtn: {
    padding: '0.5rem 1rem',
    background: '#2563eb',
    color: 'white',
    borderRadius: '0.5rem',
    fontWeight: 500,
    fontSize: '0.875rem',
    cursor: 'pointer',
  },
  formGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(2, 1fr)',
    gap: '1rem',
  },
  formGroup: {
    display: 'flex',
    flexDirection: 'column',
  },
  label: {
    fontSize: '0.75rem',
    fontWeight: 500,
    color: '#6b7280',
    marginBottom: '0.375rem',
    textTransform: 'uppercase',
  },
  value: {
    color: '#1f2937',
    fontWeight: 500,
  },
  input: {
    padding: '0.625rem',
    border: '2px solid #e5e7eb',
    borderRadius: '0.5rem',
    fontSize: '0.875rem',
  },
  familyList: {
    display: 'flex',
    flexDirection: 'column',
    gap: '0.75rem',
  },
  familyCard: {
    display: 'flex',
    alignItems: 'center',
    gap: '1rem',
    padding: '1rem',
    background: '#f9fafb',
    borderRadius: '0.5rem',
  },
  familyAvatar: {
    width: '40px',
    height: '40px',
    borderRadius: '50%',
    background: '#2563eb',
    color: 'white',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    fontSize: '0.875rem',
    fontWeight: 600,
  },
  familyInfo: {
    flex: 1,
  },
  familyName: {
    fontWeight: 500,
    color: '#1f2937',
  },
  familyRelation: {
    fontSize: '0.875rem',
    color: '#6b7280',
  },
  familyDob: {
    textAlign: 'right',
  },
  dobLabel: {
    fontSize: '0.625rem',
    color: '#6b7280',
    textTransform: 'uppercase',
  },
  dobValue: {
    fontSize: '0.875rem',
    fontWeight: 500,
    color: '#1f2937',
  },
  settingsList: {
    display: 'flex',
    flexDirection: 'column',
  },
  settingItem: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '1rem 0',
    borderBottom: '1px solid #f3f4f6',
  },
  settingName: {
    fontWeight: 500,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  settingDesc: {
    fontSize: '0.875rem',
    color: '#6b7280',
  },
  toggle: {
    position: 'relative',
    width: '48px',
    height: '24px',
  },
  toggleSlider: {
    position: 'absolute',
    cursor: 'pointer',
    inset: 0,
    background: '#e5e7eb',
    borderRadius: '24px',
    transition: '0.3s',
  },
};

export default Profile;
