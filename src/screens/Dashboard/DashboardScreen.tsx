import React from 'react';
import {View, Text, StyleSheet, ScrollView, SafeAreaView, TouchableOpacity} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {CompositeNavigationProp} from '@react-navigation/native';
import {BottomTabNavigationProp} from '@react-navigation/bottom-tabs';
import {HomeStackParamList, MainTabParamList} from '../../navigation/types';
import {Card, QuickActionButton} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {mockAppointments, mockClaims, mockUser} from '../../services/mockData';

type DashboardScreenProps = {
  navigation: CompositeNavigationProp<
    NativeStackNavigationProp<HomeStackParamList, 'Dashboard'>,
    BottomTabNavigationProp<MainTabParamList>
  >;
};

const DashboardScreen: React.FC<DashboardScreenProps> = ({navigation}) => {
  const quickActions = [
    {icon: '💳', label: 'e-Card', onPress: () => navigation.navigate('ECard')},
    {icon: '📋', label: 'Benefits', onPress: () => navigation.navigate('PolicyTab', {screen: 'Benefits'})},
    {icon: '✅', label: 'Approvals', onPress: () => navigation.navigate('MoreTab', {screen: 'Approvals'})},
    {icon: '📄', label: 'Claims', onPress: () => navigation.navigate('MoreTab', {screen: 'Claims'})},
    {icon: '📅', label: 'Book', onPress: () => navigation.navigate('AppointmentsTab', {screen: 'BookAppointment'})},
    {icon: '👨‍⚕️', label: 'Instant Dr', onPress: () => navigation.navigate('MoreTab', {screen: 'InstantGP'})},
    {icon: '💪', label: 'Wellness', onPress: () => navigation.navigate('MoreTab', {screen: 'Wellness'})},
  ];

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView>
        <View style={styles.header}>
          <View>
            <Text style={styles.greeting}>Hello,</Text>
            <Text style={styles.userName}>{mockUser.name}</Text>
          </View>
          <TouchableOpacity onPress={() => navigation.navigate('Notifications')}>
            <Text style={styles.notificationIcon}>🔔</Text>
          </TouchableOpacity>
        </View>

        <Card style={styles.policyCard}>
          <Text style={styles.policyLabel}>Policy Number</Text>
          <Text style={styles.policyNumber}>{mockUser.policyNumber}</Text>
          <Text style={styles.policyStatus}>● Active</Text>
        </Card>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Quick Actions</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            {quickActions.map((action, index) => (
              <QuickActionButton
                key={index}
                icon={<Text style={styles.actionIcon}>{action.icon}</Text>}
                label={action.label}
                onPress={action.onPress}
              />
            ))}
          </ScrollView>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Upcoming Appointments</Text>
          {mockAppointments.slice(0, 2).map(apt => (
            <Card key={apt.id} style={styles.appointmentCard}>
              <Text style={styles.aptDoctor}>{apt.doctor}</Text>
              <Text style={styles.aptDetails}>{apt.specialty}</Text>
              <Text style={styles.aptDetails}>
                {apt.date} • {apt.time}
              </Text>
            </Card>
          ))}
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Recent Claims</Text>
          {mockClaims.slice(0, 2).map(claim => (
            <Card key={claim.id} style={styles.claimCard}>
              <View style={styles.claimRow}>
                <Text style={styles.claimType}>{claim.type}</Text>
                <Text style={styles.claimAmount}>{claim.amount}</Text>
              </View>
              <Text style={styles.claimStatus}>{claim.status}</Text>
            </Card>
          ))}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: spacing.lg,
  },
  greeting: {
    fontSize: fontSize.md,
    color: colors.textSecondary,
  },
  userName: {
    fontSize: fontSize.xl,
    fontWeight: fontWeight.bold,
    color: colors.text,
  },
  notificationIcon: {
    fontSize: 24,
  },
  policyCard: {
    marginHorizontal: spacing.lg,
    marginBottom: spacing.lg,
    backgroundColor: colors.primary,
  },
  policyLabel: {
    fontSize: fontSize.sm,
    color: colors.surface,
    opacity: 0.8,
  },
  policyNumber: {
    fontSize: fontSize.xl,
    fontWeight: fontWeight.bold,
    color: colors.surface,
    marginVertical: spacing.xs,
  },
  policyStatus: {
    fontSize: fontSize.sm,
    color: colors.success,
  },
  section: {
    marginBottom: spacing.lg,
  },
  sectionTitle: {
    fontSize: fontSize.lg,
    fontWeight: fontWeight.bold,
    color: colors.text,
    paddingHorizontal: spacing.lg,
    marginBottom: spacing.md,
  },
  actionIcon: {
    fontSize: 28,
  },
  appointmentCard: {
    marginHorizontal: spacing.lg,
    marginBottom: spacing.sm,
  },
  aptDoctor: {
    fontSize: fontSize.md,
    fontWeight: fontWeight.semibold,
    color: colors.text,
  },
  aptDetails: {
    fontSize: fontSize.sm,
    color: colors.textSecondary,
    marginTop: spacing.xs,
  },
  claimCard: {
    marginHorizontal: spacing.lg,
    marginBottom: spacing.sm,
  },
  claimRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: spacing.xs,
  },
  claimType: {
    fontSize: fontSize.md,
    fontWeight: fontWeight.semibold,
    color: colors.text,
  },
  claimAmount: {
    fontSize: fontSize.md,
    fontWeight: fontWeight.bold,
    color: colors.primary,
  },
  claimStatus: {
    fontSize: fontSize.sm,
    color: colors.textSecondary,
  },
});

export default DashboardScreen;
