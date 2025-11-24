/**
 * Mock Data for the App
 */

export const mockUser = {
  id: '1',
  name: 'Ahmed Al-Mansoor',
  mobile: '+966 50 123 4567',
  nationalId: '1234567890',
  policyNumber: 'POL-2024-001',
  email: 'ahmed@example.com',
};

export const mockPolicy = {
  policyNumber: 'POL-2024-001',
  type: 'Premium Health Insurance',
  startDate: '2024-01-01',
  endDate: '2024-12-31',
  status: 'Active',
  members: [
    {id: '1', name: 'Ahmed Al-Mansoor', relation: 'Self'},
    {id: '2', name: 'Fatima Al-Mansoor', relation: 'Spouse'},
    {id: '3', name: 'Omar Al-Mansoor', relation: 'Son'},
  ],
};

export const mockBenefits = [
  {
    category: 'Inpatient',
    services: [
      {name: 'Hospital Room', limit: 'SAR 500/day', remaining: 'Unlimited'},
      {name: 'Surgery', limit: 'Covered', remaining: 'Covered'},
      {name: 'ICU', limit: 'SAR 1000/day', remaining: 'Unlimited'},
    ],
  },
  {
    category: 'Outpatient',
    services: [
      {name: 'GP Consultation', limit: '20 visits', remaining: '15 visits'},
      {name: 'Specialist', limit: '15 visits', remaining: '12 visits'},
      {name: 'Lab Tests', limit: 'Covered', remaining: 'Covered'},
    ],
  },
  {
    category: 'Dental',
    services: [
      {name: 'Checkup', limit: '2 visits', remaining: '1 visit'},
      {name: 'Cleaning', limit: '2 visits', remaining: '2 visits'},
      {name: 'Fillings', limit: 'SAR 500', remaining: 'SAR 300'},
    ],
  },
];

export const mockApprovals = [
  {
    id: '1',
    type: 'Surgery Approval',
    status: 'Approved',
    date: '2024-11-15',
    hospital: 'King Faisal Specialist Hospital',
    doctor: 'Dr. Mohammed Ahmed',
    validUntil: '2024-12-15',
  },
  {
    id: '2',
    type: 'MRI Scan',
    status: 'Pending',
    date: '2024-11-20',
    hospital: 'Saudi German Hospital',
    doctor: 'Dr. Sarah Khan',
  },
  {
    id: '3',
    type: 'Physical Therapy',
    status: 'Rejected',
    date: '2024-11-10',
    hospital: 'Al Habib Medical',
    reason: 'Not covered under current policy',
  },
];

export const mockClaims = [
  {
    id: '1',
    type: 'Consultation',
    amount: 'SAR 250',
    status: 'Approved',
    date: '2024-11-18',
    provider: 'Dr. Ahmed Clinic',
    approvedAmount: 'SAR 250',
  },
  {
    id: '2',
    type: 'Lab Tests',
    amount: 'SAR 450',
    status: 'Under Review',
    date: '2024-11-20',
    provider: 'Al Borg Lab',
  },
  {
    id: '3',
    type: 'Medication',
    amount: 'SAR 180',
    status: 'Paid',
    date: '2024-11-12',
    provider: 'Nahdi Pharmacy',
    paidAmount: 'SAR 180',
  },
];

export const mockProviders = [
  {
    id: '1',
    name: 'King Faisal Specialist Hospital',
    type: 'Hospital',
    specialty: 'Multi-specialty',
    city: 'Riyadh',
    rating: 4.8,
    distance: '2.5 km',
    network: 'In-Network',
  },
  {
    id: '2',
    name: 'Dr. Mohammed Ahmed Clinic',
    type: 'Clinic',
    specialty: 'Cardiology',
    city: 'Riyadh',
    rating: 4.6,
    distance: '1.2 km',
    network: 'In-Network',
  },
  {
    id: '3',
    name: 'Saudi German Hospital',
    type: 'Hospital',
    specialty: 'Multi-specialty',
    city: 'Jeddah',
    rating: 4.7,
    distance: '3.8 km',
    network: 'In-Network',
  },
];

export const mockAppointments = [
  {
    id: '1',
    doctor: 'Dr. Sarah Khan',
    specialty: 'Dermatology',
    date: '2024-11-25',
    time: '10:00 AM',
    location: 'Saudi German Hospital',
    type: 'In-Clinic',
    status: 'Confirmed',
  },
  {
    id: '2',
    doctor: 'Dr. Ahmed Ali',
    specialty: 'General Physician',
    date: '2024-11-28',
    time: '2:00 PM',
    location: 'Video Consultation',
    type: 'Telemedicine',
    status: 'Confirmed',
  },
];

export const mockNotifications = [
  {
    id: '1',
    title: 'Claim Approved',
    message: 'Your claim #CLM-001 has been approved',
    date: '2024-11-20',
    read: false,
    type: 'claim',
  },
  {
    id: '2',
    title: 'Appointment Reminder',
    message: 'You have an appointment tomorrow at 10:00 AM',
    date: '2024-11-19',
    read: false,
    type: 'appointment',
  },
  {
    id: '3',
    title: 'Policy Renewal',
    message: 'Your policy will expire in 30 days',
    date: '2024-11-15',
    read: true,
    type: 'policy',
  },
];

export const mockWellnessRewards = {
  points: 850,
  level: 'Gold',
  challenges: [
    {id: '1', title: 'Daily Steps Challenge', progress: 75, points: 50},
    {id: '2', title: 'Water Intake', progress: 60, points: 30},
    {id: '3', title: 'Sleep Tracking', progress: 90, points: 40},
  ],
  rewards: [
    {id: '1', title: 'Fitness Tracker', points: 1000, image: ''},
    {id: '2', title: 'Spa Voucher', points: 500, image: ''},
    {id: '3', title: 'Healthy Meal Plan', points: 750, image: ''},
  ],
};

export const mockChronicPrograms = [
  {
    id: '1',
    name: 'Diabetes Management',
    enrolled: true,
    doctor: 'Dr. Fatima Hassan',
    nextFollowUp: '2024-11-30',
    tasks: [
      {id: '1', title: 'Blood Sugar Check', completed: true},
      {id: '2', title: 'Medication Reminder', completed: false},
      {id: '3', title: 'Diet Log', completed: true},
    ],
  },
  {
    id: '2',
    name: 'Hypertension Care',
    enrolled: false,
    description: 'Comprehensive blood pressure management program',
  },
];
