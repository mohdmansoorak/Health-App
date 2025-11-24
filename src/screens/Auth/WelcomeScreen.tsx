import React from 'react';
import {View, Text, StyleSheet, SafeAreaView} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {AuthStackParamList} from '../../navigation/types';
import {Button} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';

type WelcomeScreenProps = {
  navigation: NativeStackNavigationProp<AuthStackParamList, 'Welcome'>;
};

const WelcomeScreen: React.FC<WelcomeScreenProps> = ({navigation}) => {
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.icon}>🏥</Text>
        <Text style={styles.title}>CareConnect Health</Text>
        <Text style={styles.subtitle}>Your Health Insurance Companion</Text>

        <View style={styles.features}>
          <Text style={styles.feature}>✓ Digital e-Card</Text>
          <Text style={styles.feature}>✓ Book Appointments</Text>
          <Text style={styles.feature}>✓ Manage Claims</Text>
          <Text style={styles.feature}>✓ Find Providers</Text>
        </View>
      </View>

      <View style={styles.footer}>
        <Button
          title="Get Started"
          onPress={() => navigation.navigate('Login')}
          fullWidth
        />
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  content: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: spacing.xl,
  },
  icon: {
    fontSize: 80,
    marginBottom: spacing.lg,
  },
  title: {
    fontSize: fontSize.xxxl,
    fontWeight: fontWeight.bold,
    color: colors.primary,
    marginBottom: spacing.sm,
  },
  subtitle: {
    fontSize: fontSize.lg,
    color: colors.textSecondary,
    textAlign: 'center',
    marginBottom: spacing.xl,
  },
  features: {
    marginTop: spacing.xl,
  },
  feature: {
    fontSize: fontSize.md,
    color: colors.text,
    marginBottom: spacing.sm,
  },
  footer: {
    padding: spacing.xl,
  },
});

export default WelcomeScreen;
