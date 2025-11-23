import React from 'react';
import {View, Text, StyleSheet, SafeAreaView, ScrollView, TouchableOpacity} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {MoreStackParamList} from '../../navigation/types';
import {Card, Button} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {mockClaims} from '../../services/mockData';

type ClaimsScreenProps = {
  navigation: NativeStackNavigationProp<MoreStackParamList, 'Claims'>;
};

const ClaimsScreen: React.FC<ClaimsScreenProps> = ({navigation}) => {
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'Approved': case 'Paid': return colors.success;
      case 'Under Review': return colors.warning;
      case 'Rejected': return colors.error;
      default: return colors.textSecondary;
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>My Claims</Text>
        <Button title="Submit Claim" onPress={() => navigation.navigate('SubmitClaim')} size="small" />
      </View>
      <ScrollView contentContainerStyle={styles.content}>
        {mockClaims.map(claim => (
          <TouchableOpacity key={claim.id} onPress={() => navigation.navigate('ClaimDetails', {claimId: claim.id})}>
            <Card style={styles.card}>
              <View style={styles.cardHeader}>
                <Text style={styles.claimType}>{claim.type}</Text>
                <Text style={styles.amount}>{claim.amount}</Text>
              </View>
              <Text style={styles.provider}>{claim.provider}</Text>
              <View style={styles.footer}>
                <Text style={styles.date}>{claim.date}</Text>
                <Text style={[styles.status, {color: getStatusColor(claim.status)}]}>{claim.status}</Text>
              </View>
            </Card>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: colors.background},
  header: {flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', padding: spacing.lg, borderBottomWidth: 1, borderBottomColor: colors.border, backgroundColor: colors.surface},
  title: {fontSize: fontSize.xxl, fontWeight: fontWeight.bold, color: colors.text},
  content: {padding: spacing.lg},
  card: {marginBottom: spacing.md},
  cardHeader: {flexDirection: 'row', justifyContent: 'space-between', marginBottom: spacing.sm},
  claimType: {fontSize: fontSize.md, fontWeight: fontWeight.semibold, color: colors.text},
  amount: {fontSize: fontSize.md, fontWeight: fontWeight.bold, color: colors.primary},
  provider: {fontSize: fontSize.sm, color: colors.textSecondary, marginBottom: spacing.sm},
  footer: {flexDirection: 'row', justifyContent: 'space-between'},
  date: {fontSize: fontSize.xs, color: colors.textLight},
  status: {fontSize: fontSize.sm, fontWeight: fontWeight.semibold},
});

export default ClaimsScreen;
