import React, {useState} from 'react';
import {View, Text, StyleSheet, SafeAreaView, Alert} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {RouteProp} from '@react-navigation/native';
import {AuthStackParamList} from '../../navigation/types';
import {Button, Input} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {authService} from '../../services/authService';
import {useDispatch} from 'react-redux';
import {loginSuccess} from '../../store/slices/authSlice';

type OTPScreenProps = {
  navigation: NativeStackNavigationProp<AuthStackParamList, 'OTP'>;
  route: RouteProp<AuthStackParamList, 'OTP'>;
};

const OTPScreen: React.FC<OTPScreenProps> = ({navigation, route}) => {
  const {mobileOrId} = route.params;
  const [otp, setOtp] = useState('');
  const [loading, setLoading] = useState(false);
  const dispatch = useDispatch();

  const handleVerifyOTP = async () => {
    if (!otp.trim() || otp.length !== 4) {
      Alert.alert('Error', 'Please enter 4-digit OTP');
      return;
    }

    setLoading(true);
    try {
      const response = await authService.verifyOTP({mobileOrId, otp});
      if (response.success && response.token) {
        dispatch(loginSuccess(response.token));
      } else {
        Alert.alert('Error', 'Invalid OTP');
      }
    } catch (error) {
      Alert.alert('Error', 'Failed to verify OTP');
    } finally {
      setLoading(false);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.icon}>📱</Text>
        <Text style={styles.title}>Enter OTP</Text>
        <Text style={styles.subtitle}>
          We've sent a code to {mobileOrId}
        </Text>
        <Text style={styles.hint}>(Use 1234 for demo)</Text>

        <View style={styles.form}>
          <Input
            label="OTP Code"
            placeholder="1234"
            value={otp}
            onChangeText={setOtp}
            keyboardType="number-pad"
            maxLength={4}
          />

          <Button
            title="Verify"
            onPress={handleVerifyOTP}
            loading={loading}
            fullWidth
          />

          <Button
            title="Resend OTP"
            onPress={() => {}}
            variant="ghost"
            fullWidth
            style={{marginTop: spacing.md}}
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
  },
  hint: {
    fontSize: fontSize.sm,
    color: colors.textLight,
    textAlign: 'center',
    marginTop: spacing.xs,
    marginBottom: spacing.xl,
  },
  form: {
    marginTop: spacing.xl,
  },
});

export default OTPScreen;
