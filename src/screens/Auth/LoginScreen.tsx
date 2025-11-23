import React, {useState} from 'react';
import {View, Text, StyleSheet, SafeAreaView, Alert} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {AuthStackParamList} from '../../navigation/types';
import {Button, Input} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {authService} from '../../services/authService';

type LoginScreenProps = {
  navigation: NativeStackNavigationProp<AuthStackParamList, 'Login'>;
};

const LoginScreen: React.FC<LoginScreenProps> = ({navigation}) => {
  const [mobileOrId, setMobileOrId] = useState('');
  const [loading, setLoading] = useState(false);

  const handleLogin = async () => {
    if (!mobileOrId.trim()) {
      Alert.alert('Error', 'Please enter mobile number or ID');
      return;
    }

    setLoading(true);
    try {
      const response = await authService.sendOTP({mobileOrId});
      if (response.success) {
        navigation.navigate('OTP', {mobileOrId});
      }
    } catch (error) {
      Alert.alert('Error', 'Failed to send OTP');
    } finally {
      setLoading(false);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.icon}>🏥</Text>
        <Text style={styles.title}>Welcome Back</Text>
        <Text style={styles.subtitle}>Enter your details to access your account</Text>

        <View style={styles.form}>
          <Input
            label="Mobile Number or National ID"
            placeholder="050 123 4567 or 1234567890"
            value={mobileOrId}
            onChangeText={setMobileOrId}
            keyboardType="phone-pad"
          />

          <Button
            title="Continue"
            onPress={handleLogin}
            loading={loading}
            fullWidth
          />
        </View>
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
  },
  icon: {
    fontSize: 60,
    textAlign: 'center',
    marginTop: spacing.xxl,
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
    marginBottom: spacing.xl,
  },
  form: {
    marginTop: spacing.xl,
  },
});

export default LoginScreen;
