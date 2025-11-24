import React from 'react';
import {View, Text, StyleSheet, SafeAreaView, ScrollView, TouchableOpacity} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {MoreStackParamList} from '../../navigation/types';
import {Card} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {mockApprovals} from '../../services/mockData';

type ApprovalsScreenProps = {
  navigation: NativeStackNavigationProp<MoreStackParamList, 'Approvals'>;
};

const ApprovalsScreen: React.FC<ApprovalsScreenProps> = ({navigation}) => {
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'Approved': return colors.success;
      case 'Pending': return colors.warning;
      case 'Rejected': return colors.error;
      default: return colors.textSecondary;
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Approvals</Text>
      </View>
      <ScrollView contentContainerStyle={styles.content}>
        {mockApprovals.map(approval => (
          <TouchableOpacity
            key={approval.id}
            onPress={() => navigation.navigate('ApprovalDetails', {approvalId: approval.id})}>
            <Card style={styles.card}>
              <View style={styles.cardHeader}>
                <Text style={styles.approvalType}>{approval.type}</Text>
                <Text style={[styles.status, {color: getStatusColor(approval.status)}]}>
                  {approval.status}
                </Text>
              </View>
              <Text style={styles.hospital}>{approval.hospital}</Text>
              <Text style={styles.doctor}>{approval.doctor}</Text>
              <Text style={styles.date}>Date: {approval.date}</Text>
            </Card>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: colors.background},
  header: {padding: spacing.lg, borderBottomWidth: 1, borderBottomColor: colors.border, backgroundColor: colors.surface},
  title: {fontSize: fontSize.xxl, fontWeight: fontWeight.bold, color: colors.text},
  content: {padding: spacing.lg},
  card: {marginBottom: spacing.md},
  cardHeader: {flexDirection: 'row', justifyContent: 'space-between', marginBottom: spacing.sm},
  approvalType: {fontSize: fontSize.md, fontWeight: fontWeight.semibold, color: colors.text, flex: 1},
  status: {fontSize: fontSize.sm, fontWeight: fontWeight.semibold},
  hospital: {fontSize: fontSize.sm, color: colors.textSecondary, marginBottom: spacing.xs},
  doctor: {fontSize: fontSize.sm, color: colors.textSecondary, marginBottom: spacing.xs},
  date: {fontSize: fontSize.xs, color: colors.textLight},
});

export default ApprovalsScreen;
