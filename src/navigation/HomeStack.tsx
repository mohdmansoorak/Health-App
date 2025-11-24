/**
 * Home Stack Navigator
 */
import React from 'react';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {HomeStackParamList} from './types';

import DashboardScreen from '../screens/Dashboard/DashboardScreen';
import ECardScreen from '../screens/Dashboard/ECardScreen';
import NotificationsScreen from '../screens/Notifications/NotificationsScreen';

const Stack = createNativeStackNavigator<HomeStackParamList>();

export const HomeStack = () => {
  return (
    <Stack.Navigator screenOptions={{headerShown: false}}>
      <Stack.Screen name="Dashboard" component={DashboardScreen} />
      <Stack.Screen name="ECard" component={ECardScreen} />
      <Stack.Screen name="Notifications" component={NotificationsScreen} />
    </Stack.Navigator>
  );
};
