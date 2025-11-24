import React from 'react';
import {View, Text, StyleSheet, SafeAreaView, ScrollView, TouchableOpacity} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {PolicyStackParamList} from '../../navigation/types';
import {Card} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {mockPolicy} from '../../services/mockData';

type PolicyOverviewScreenProps = {
  navigation: NativeStackNavigationProp<PolicyStackParamList, 'PolicyOverview'>;
};

const PolicyOverviewScreen: React.FC<PolicyOverviewScreenProps> = ({navigation}) => {
  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content}>
        <Text style={styles.title}>My Policy</Text>

        <Card>
          <Text style={styles.policyType}>{mockPolicy.type}</Text>
          <Text style={styles.policyNumber}>Policy: {mockPolicy.policyNumber}</Text>
          <View style={styles.statusContainer}>
            <Text style={styles.statusText}>Status: </Text>
            <Text style={styles.statusActive}>{mockPolicy.status}</Text>
          </View>
        </Card>

        <Card style={{marginTop: spacing.md}}>
          <Text style={styles.sectionTitle}>Policy Period</Text>
          <View style={styles.row}>
            <Text style={styles.label}>Start Date:</Text>
            <Text style={styles.value}>{mockPolicy.startDate}</Text>
          </View>
          <View style={styles.row}>
            <Text style={styles.label}>End Date:</Text>
            <Text style={styles.value}>{mockPolicy.endDate}</Text>
          </View>
        </Card>

        <Card style={{marginTop: spacing.md}}>
          <Text style={styles.sectionTitle}>Covered Members</Text>
          {mockPolicy.members.map(member => (
            <View key={member.id} style={styles.memberRow}>
              <Text style={styles.memberName}>{member.name}</Text>
              <Text style={styles.memberRelation}>{member.relation}</Text>
            </View>
          ))}
        </Card>

        <TouchableOpacity onPress={() => navigation.navigate('Benefits')}>
          <Card style={{marginTop: spacing.md, backgroundColor: colors.primaryLight}}>
            <Text style={styles.linkText}>View Benefits & Coverage →</Text>
          </Card>
        </TouchableOpacity>
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
  policyType: {
    fontSize: fontSize.lg,
    fontWeight: fontWeight.bold,
    color: colors.text,
  },
  policyNumber: {
    fontSize: fontSize.md,
    color: colors.textSecondary,
    marginTop: spacing.xs,
  },
  statusContainer: {
    flexDirection: 'row',
    marginTop: spacing.sm,
  },
  statusText: {
    fontSize: fontSize.sm,
    color: colors.textSecondary,
  },
  statusActive: {
    fontSize: fontSize.sm,
    color: colors.success,
    fontWeight: fontWeight.semibold,
  },
  sectionTitle: {
    fontSize: fontSize.md,
    fontWeight: fontWeight.semibold,
    color: colors.text,
    marginBottom: spacing.md,
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: spacing.sm,
  },
  label: {
    fontSize: fontSize.sm,
    color: colors.textSecondary,
  },
  value: {
    fontSize: fontSize.sm,
    color: colors.text,
    fontWeight: fontWeight.medium,
  },
  memberRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: spacing.sm,
    paddingVertical: spacing.xs,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  memberName: {
    fontSize: fontSize.md,
    color: colors.text,
  },
  memberRelation: {
    fontSize: fontSize.sm,
    color: colors.textSecondary,
  },
  linkText: {
    fontSize: fontSize.md,
    fontWeight: fontWeight.semibold,
    color: colors.surface,
    textAlign: 'center',
  },
});

export default PolicyOverviewScreen;
