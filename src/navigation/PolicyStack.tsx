/**
 * Policy Stack Navigator
 */
import React from 'react';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {PolicyStackParamList} from './types';

import PolicyOverviewScreen from '../screens/Policy/PolicyOverviewScreen';
import BenefitsScreen from '../screens/Policy/BenefitsScreen';

const Stack = createNativeStackNavigator<PolicyStackParamList>();

export const PolicyStack = () => {
  return (
    <Stack.Navigator screenOptions={{headerShown: false}}>
      <Stack.Screen name="PolicyOverview" component={PolicyOverviewScreen} />
      <Stack.Screen name="Benefits" component={BenefitsScreen} />
    </Stack.Navigator>
  );
};
