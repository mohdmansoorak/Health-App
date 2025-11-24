import React from 'react';
import {View, Text, StyleSheet, SafeAreaView} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {AuthStackParamList} from '../../navigation/types';
import {Button} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';

type ForgotPINScreenProps = {
  navigation: NativeStackNavigationProp<AuthStackParamList, 'ForgotPIN'>;
};

const ForgotPINScreen: React.FC<ForgotPINScreenProps> = ({navigation}) => {
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.icon}>🔑</Text>
        <Text style={styles.title}>Forgot PIN?</Text>
        <Text style={styles.subtitle}>
          We'll send an OTP to your registered mobile number to reset your PIN
        </Text>

        <Button
          title="Send OTP"
          onPress={() => navigation.navigate('Login')}
          fullWidth
          style={{marginTop: spacing.xl}}
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
    padding: spacing.xl,
    justifyContent: 'center',
  },
  icon: {
    fontSize: 60,
    textAlign: 'center',
    marginBottom: spacing.lg,
  },
  title: {
    fontSize: fontSize.xxl,
    fontWeight: fontWeight.bold,
    color: colors.text,
    textAlign: 'center',
    marginBottom: spacing.sm,
  },
  subtitle: {
    fontSize: fontSize.md,
    color: colors.textSecondary,
    textAlign: 'center',
  },
});

export default ForgotPINScreen;
