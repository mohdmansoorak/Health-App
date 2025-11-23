import React from 'react';
import {View, Text, StyleSheet, SafeAreaView, ScrollView} from 'react-native';
import {Card} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';

const ApprovalDetailsScreen = () => {
  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content}>
        <Text style={styles.title}>Approval Details</Text>
        <Card>
          <Text style={styles.label}>Type:</Text>
          <Text style={styles.value}>Surgery Approval</Text>
          <Text style={styles.label}>Status:</Text>
          <Text style={[styles.value, {color: colors.success}]}>Approved</Text>
          <Text style={styles.label}>Hospital:</Text>
          <Text style={styles.value}>King Faisal Specialist Hospital</Text>
          <Text style={styles.label}>Doctor:</Text>
          <Text style={styles.value}>Dr. Mohammed Ahmed</Text>
          <Text style={styles.label}>Valid Until:</Text>
          <Text style={styles.value}>2024-12-15</Text>
        </Card>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: colors.background},
  content: {padding: spacing.lg},
  title: {fontSize: fontSize.xxl, fontWeight: fontWeight.bold, color: colors.text, marginBottom: spacing.lg},
  label: {fontSize: fontSize.sm, color: colors.textSecondary, marginTop: spacing.sm},
  value: {fontSize: fontSize.md, color: colors.text, fontWeight: fontWeight.medium, marginBottom: spacing.xs},
});

export default ApprovalDetailsScreen;
