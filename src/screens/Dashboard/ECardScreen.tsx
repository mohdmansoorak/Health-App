import React from 'react';
import {View, Text, StyleSheet, SafeAreaView, ScrollView} from 'react-native';
import {Card, Button} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {mockUser} from '../../services/mockData';

const ECardScreen = () => {
  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content}>
        <Text style={styles.title}>Digital e-Card</Text>

        <Card style={styles.eCard}>
          <View style={styles.cardHeader}>
            <Text style={styles.cardTitle}>CareConnect Health</Text>
            <Text style={styles.cardSubtitle}>Member e-Card</Text>
          </View>

          <View style={styles.cardBody}>
            <View style={styles.field}>
              <Text style={styles.label}>Member Name</Text>
              <Text style={styles.value}>{mockUser.name}</Text>
            </View>

            <View style={styles.field}>
              <Text style={styles.label}>Member ID</Text>
              <Text style={styles.value}>{mockUser.nationalId}</Text>
            </View>

            <View style={styles.field}>
              <Text style={styles.label}>Policy Number</Text>
              <Text style={styles.value}>{mockUser.policyNumber}</Text>
            </View>

            <View style={styles.qrContainer}>
              <Text style={styles.qrPlaceholder}>QR CODE</Text>
              <Text style={styles.qrText}>Scan at provider</Text>
            </View>
          </View>
        </Card>

        <Button
          title="Download e-Card"
          onPress={() => {}}
          fullWidth
          style={{marginTop: spacing.lg}}
        />

        <Button
          title="Share e-Card"
          onPress={() => {}}
          variant="outline"
          fullWidth
          style={{marginTop: spacing.md}}
        />
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  content: {
    padding: spacing.lg,
  },
  title: {
    fontSize: fontSize.xxl,
    fontWeight: fontWeight.bold,
    color: colors.text,
    marginBottom: spacing.lg,
  },
  eCard: {
    backgroundColor: colors.primary,
    padding: spacing.lg,
  },
  cardHeader: {
    marginBottom: spacing.lg,
  },
  cardTitle: {
    fontSize: fontSize.xl,
    fontWeight: fontWeight.bold,
    color: colors.surface,
  },
  cardSubtitle: {
    fontSize: fontSize.md,
    color: colors.surface,
    opacity: 0.8,
  },
  cardBody: {},
  field: {
    marginBottom: spacing.md,
  },
  label: {
    fontSize: fontSize.sm,
    color: colors.surface,
    opacity: 0.8,
  },
  value: {
    fontSize: fontSize.md,
    fontWeight: fontWeight.semibold,
    color: colors.surface,
    marginTop: spacing.xs,
  },
  qrContainer: {
    alignItems: 'center',
    marginTop: spacing.lg,
    padding: spacing.lg,
    backgroundColor: colors.surface,
    borderRadius: spacing.sm,
  },
  qrPlaceholder: {
    fontSize: fontSize.xxl,
    fontWeight: fontWeight.bold,
    color: colors.primary,
  },
  qrText: {
    fontSize: fontSize.sm,
    color: colors.textSecondary,
    marginTop: spacing.xs,
  },
});

export default ECardScreen;
