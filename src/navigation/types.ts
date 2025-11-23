/**
 * Navigation Types
 */
import {NavigatorScreenParams} from '@react-navigation/native';

export type RootStackParamList = {
  Auth: NavigatorScreenParams<AuthStackParamList>;
  Main: NavigatorScreenParams<MainTabParamList>;
};

export type AuthStackParamList = {
  Welcome: undefined;
  Login: undefined;
  OTP: {mobileOrId: string};
  CreatePIN: undefined;
  ForgotPIN: undefined;
};

export type MainTabParamList = {
  HomeTab: NavigatorScreenParams<HomeStackParamList>;
  PolicyTab: NavigatorScreenParams<PolicyStackParamList>;
  AppointmentsTab: NavigatorScreenParams<AppointmentsStackParamList>;
  MoreTab: NavigatorScreenParams<MoreStackParamList>;
};

export type HomeStackParamList = {
  Dashboard: undefined;
  ECard: undefined;
  Notifications: undefined;
};

export type PolicyStackParamList = {
  PolicyOverview: undefined;
  Benefits: undefined;
};

export type AppointmentsStackParamList = {
  AppointmentList: undefined;
  BookAppointment: undefined;
  SelectMember: undefined;
  SelectVisitType: undefined;
  SelectDoctor: undefined;
  SelectDateTime: undefined;
  AppointmentConfirm: undefined;
  AppointmentDetails: {appointmentId: string};
};

export type MoreStackParamList = {
  MoreMenu: undefined;
  Approvals: undefined;
  ApprovalDetails: {approvalId: string};
  Claims: undefined;
  ClaimDetails: {claimId: string};
  SubmitClaim: undefined;
  ProviderSearch: undefined;
  ProviderDetails: {providerId: string};
  Telemedicine: undefined;
  InstantGP: undefined;
  ChronicCare: undefined;
  ProgramDetails: {programId: string};
  Wellness: undefined;
  Support: undefined;
  FAQ: undefined;
  ContactUs: undefined;
  Profile: undefined;
};
