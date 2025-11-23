import React, {useState} from 'react';
import {View, Text, StyleSheet, SafeAreaView, Alert} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {AuthStackParamList} from '../../navigation/types';
import {Button, Input} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';

type CreatePINScreenProps = {
  navigation: NativeStackNavigationProp<AuthStackParamList, 'CreatePIN'>;
};

const CreatePINScreen: React.FC<CreatePINScreenProps> = ({navigation}) => {
  const [pin, setPin] = useState('');
  const [confirmPin, setConfirmPin] = useState('');

  const handleCreatePIN = () => {
    if (pin.length !== 4) {
      Alert.alert('Error', 'PIN must be 4 digits');
      return;
    }
    if (pin !== confirmPin) {
      Alert.alert('Error', 'PINs do not match');
      return;
    }
    Alert.alert('Success', 'PIN created successfully');
    navigation.goBack();
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.icon}>🔒</Text>
        <Text style={styles.title}>Create PIN</Text>
        <Text style={styles.subtitle}>Set up a 4-digit PIN for quick access</Text>

        <View style={styles.form}>
          <Input
            label="Enter PIN"
            placeholder="••••"
            value={pin}
            onChangeText={setPin}
            keyboardType="number-pad"
            maxLength={4}
            secureTextEntry
          />

          <Input
            label="Confirm PIN"
            placeholder="••••"
            value={confirmPin}
            onChangeText={setConfirmPin}
            keyboardType="number-pad"
            maxLength={4}
            secureTextEntry
          />

          <Button
            title="Create PIN"
            onPress={handleCreatePIN}
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

export default CreatePINScreen;
