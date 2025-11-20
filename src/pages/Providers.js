import React, { useState } from 'react';
import { useApp } from '../context/AppContext';
import { Search, MapPin, Phone, Star, CheckCircle, Filter } from 'lucide-react';

const Providers = () => {
  const { providers } = useApp();
  const [searchTerm, setSearchTerm] = useState('');
  const [filterType, setFilterType] = useState('all');
  const [filterSpecialty, setFilterSpecialty] = useState('all');

  const types = ['all', ...new Set(providers.map(p => p.type))];
  const specialties = ['all', ...new Set(providers.map(p => p.specialty))];

  const filteredProviders = providers.filter(provider => {
    const matchesSearch = provider.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         provider.specialty.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         provider.address.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = filterType === 'all' || provider.type === filterType;
    const matchesSpecialty = filterSpecialty === 'all' || provider.specialty === filterSpecialty;
    return matchesSearch && matchesType && matchesSpecialty;
  });

  return (
    <div style={styles.container}>
      <div style={styles.header}>
        <h2 style={styles.title}>Find Healthcare Providers</h2>
        <p style={styles.subtitle}>Search for in-network doctors, hospitals, and specialists</p>
      </div>

      {/* Search and Filters */}
      <div style={styles.searchSection}>
        <div style={styles.searchBox}>
          <Search size={20} color="#6b7280" />
          <input
            type="text"
            placeholder="Search by name, specialty, or location..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            style={styles.searchInput}
          />
        </div>

        <div style={styles.filters}>
          <div style={styles.filterGroup}>
            <Filter size={18} color="#6b7280" />
            <select
              value={filterType}
              onChange={(e) => setFilterType(e.target.value)}
              style={styles.filterSelect}
            >
              {types.map(type => (
                <option key={type} value={type}>
                  {type === 'all' ? 'All Types' : type}
                </option>
              ))}
            </select>
          </div>

          <div style={styles.filterGroup}>
            <select
              value={filterSpecialty}
              onChange={(e) => setFilterSpecialty(e.target.value)}
              style={styles.filterSelect}
            >
              {specialties.map(specialty => (
                <option key={specialty} value={specialty}>
                  {specialty === 'all' ? 'All Specialties' : specialty}
                </option>
              ))}
            </select>
          </div>
        </div>
      </div>

      {/* Results Count */}
      <div style={styles.resultsCount}>
        Found {filteredProviders.length} provider{filteredProviders.length !== 1 ? 's' : ''}
      </div>

      {/* Providers Grid */}
      <div style={styles.providersGrid}>
        {filteredProviders.map(provider => (
          <div key={provider.id} style={styles.providerCard}>
            <div style={styles.cardHeader}>
              <div style={styles.providerType}>{provider.type}</div>
              {provider.inNetwork && (
                <span style={styles.networkBadge}>
                  <CheckCircle size={14} />
                  In-Network
                </span>
              )}
            </div>

            <h3 style={styles.providerName}>{provider.name}</h3>
            <p style={styles.specialty}>{provider.specialty}</p>

            <div style={styles.rating}>
              <Star size={16} color="#f59e0b" fill="#f59e0b" />
              <span style={styles.ratingValue}>{provider.rating}</span>
              <span style={styles.ratingText}>Rating</span>
            </div>

            <div style={styles.providerDetails}>
              <div style={styles.detailItem}>
                <MapPin size={16} color="#6b7280" />
                <span>{provider.address}</span>
              </div>
              <div style={styles.detailItem}>
                <Phone size={16} color="#6b7280" />
                <span>{provider.phone}</span>
              </div>
            </div>

            <div style={styles.cardFooter}>
              <span style={styles.distance}>{provider.distance}</span>
              {provider.acceptingPatients ? (
                <span style={styles.accepting}>Accepting Patients</span>
              ) : (
                <span style={styles.notAccepting}>Not Accepting</span>
              )}
            </div>

            <div style={styles.cardActions}>
              <button style={styles.viewBtn}>View Details</button>
              <button style={styles.scheduleBtn}>Schedule Visit</button>
            </div>
          </div>
        ))}
      </div>

      {filteredProviders.length === 0 && (
        <div style={styles.emptyState}>
          <p>No providers found matching your criteria</p>
          <p style={styles.emptyHint}>Try adjusting your search or filters</p>
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
  searchSection: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
    marginBottom: '1.5rem',
  },
  searchBox: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.75rem',
    padding: '0.75rem 1rem',
    background: '#f9fafb',
    borderRadius: '0.5rem',
    border: '2px solid #e5e7eb',
    marginBottom: '1rem',
  },
  searchInput: {
    border: 'none',
    outline: 'none',
    flex: 1,
    fontSize: '0.875rem',
    background: 'transparent',
  },
  filters: {
    display: 'flex',
    gap: '1rem',
    flexWrap: 'wrap',
  },
  filterGroup: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem',
  },
  filterSelect: {
    padding: '0.5rem 1rem',
    borderRadius: '0.5rem',
    border: '2px solid #e5e7eb',
    fontSize: '0.875rem',
    background: 'white',
    cursor: 'pointer',
  },
  resultsCount: {
    color: '#6b7280',
    marginBottom: '1rem',
    fontSize: '0.875rem',
  },
  providersGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))',
    gap: '1.5rem',
  },
  providerCard: {
    background: 'white',
    padding: '1.5rem',
    borderRadius: '0.75rem',
    boxShadow: '0 1px 3px rgb(0 0 0 / 0.1)',
  },
  cardHeader: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: '0.75rem',
  },
  providerType: {
    fontSize: '0.75rem',
    fontWeight: 500,
    color: '#2563eb',
    background: '#eff6ff',
    padding: '0.25rem 0.5rem',
    borderRadius: '0.25rem',
  },
  networkBadge: {
    display: 'inline-flex',
    alignItems: 'center',
    gap: '0.25rem',
    fontSize: '0.75rem',
    fontWeight: 500,
    color: '#065f46',
    background: '#d1fae5',
    padding: '0.25rem 0.5rem',
    borderRadius: '9999px',
  },
  providerName: {
    fontSize: '1.125rem',
    fontWeight: 600,
    color: '#1f2937',
    marginBottom: '0.25rem',
  },
  specialty: {
    color: '#6b7280',
    fontSize: '0.875rem',
    marginBottom: '0.75rem',
  },
  rating: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.375rem',
    marginBottom: '1rem',
  },
  ratingValue: {
    fontWeight: 600,
    color: '#1f2937',
  },
  ratingText: {
    color: '#6b7280',
    fontSize: '0.75rem',
  },
  providerDetails: {
    display: 'flex',
    flexDirection: 'column',
    gap: '0.5rem',
    padding: '1rem 0',
    borderTop: '1px solid #e5e7eb',
    borderBottom: '1px solid #e5e7eb',
  },
  detailItem: {
    display: 'flex',
    alignItems: 'flex-start',
    gap: '0.5rem',
    fontSize: '0.875rem',
    color: '#374151',
  },
  cardFooter: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '0.75rem 0',
  },
  distance: {
    fontSize: '0.875rem',
    color: '#6b7280',
  },
  accepting: {
    fontSize: '0.75rem',
    color: '#065f46',
    fontWeight: 500,
  },
  notAccepting: {
    fontSize: '0.75rem',
    color: '#991b1b',
    fontWeight: 500,
  },
  cardActions: {
    display: 'flex',
    gap: '0.75rem',
    marginTop: '0.5rem',
  },
  viewBtn: {
    flex: 1,
    padding: '0.625rem',
    borderRadius: '0.5rem',
    border: '2px solid #2563eb',
    color: '#2563eb',
    fontWeight: 500,
    fontSize: '0.875rem',
    background: 'white',
    cursor: 'pointer',
  },
  scheduleBtn: {
    flex: 1,
    padding: '0.625rem',
    borderRadius: '0.5rem',
    background: '#2563eb',
    color: 'white',
    fontWeight: 500,
    fontSize: '0.875rem',
    cursor: 'pointer',
  },
  emptyState: {
    textAlign: 'center',
    padding: '3rem',
    color: '#6b7280',
  },
  emptyHint: {
    fontSize: '0.875rem',
    marginTop: '0.5rem',
  },
};

export default Providers;
