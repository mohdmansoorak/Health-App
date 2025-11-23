/**
 * Authentication Stack Navigator
 */
import React from 'react';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {AuthStackParamList} from './types';

// Import screens
import WelcomeScreen from '../screens/Auth/WelcomeScreen';
import LoginScreen from '../screens/Auth/LoginScreen';
import OTPScreen from '../screens/Auth/OTPScreen';
import CreatePINScreen from '../screens/Auth/CreatePINScreen';
import ForgotPINScreen from '../screens/Auth/ForgotPINScreen';

const Stack = createNativeStackNavigator<AuthStackParamList>();

export const AuthStack = () => {
  return (
    <Stack.Navigator
      screenOptions={{
        headerShown: false,
      }}>
      <Stack.Screen name="Welcome" component={WelcomeScreen} />
      <Stack.Screen name="Login" component={LoginScreen} />
      <Stack.Screen name="OTP" component={OTPScreen} />
      <Stack.Screen name="CreatePIN" component={CreatePINScreen} />
      <Stack.Screen name="ForgotPIN" component={ForgotPINScreen} />
    </Stack.Navigator>
  );
};
