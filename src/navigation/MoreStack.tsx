/**
 * More Stack Navigator
 */
import React from 'react';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {MoreStackParamList} from './types';

import MoreMenuScreen from '../screens/Support/MoreMenuScreen';
import ApprovalsScreen from '../screens/Approvals/ApprovalsScreen';
import ApprovalDetailsScreen from '../screens/Approvals/ApprovalDetailsScreen';
import ClaimsScreen from '../screens/Claims/ClaimsScreen';
import ClaimDetailsScreen from '../screens/Claims/ClaimDetailsScreen';
import SubmitClaimScreen from '../screens/Claims/SubmitClaimScreen';
import ProviderSearchScreen from '../screens/Providers/ProviderSearchScreen';
import ProviderDetailsScreen from '../screens/Providers/ProviderDetailsScreen';
import TelemedicineScreen from '../screens/Telemedicine/TelemedicineScreen';
import InstantGPScreen from '../screens/Telemedicine/InstantGPScreen';
import ChronicCareScreen from '../screens/ChronicCare/ChronicCareScreen';
import ProgramDetailsScreen from '../screens/ChronicCare/ProgramDetailsScreen';
import WellnessScreen from '../screens/Wellness/WellnessScreen';
import SupportScreen from '../screens/Support/SupportScreen';
import FAQScreen from '../screens/Support/FAQScreen';
import ContactUsScreen from '../screens/Support/ContactUsScreen';
import ProfileScreen from '../screens/Support/ProfileScreen';

const Stack = createNativeStackNavigator<MoreStackParamList>();

export const MoreStack = () => {
  return (
    <Stack.Navigator screenOptions={{headerShown: false}}>
      <Stack.Screen name="MoreMenu" component={MoreMenuScreen} />
      <Stack.Screen name="Approvals" component={ApprovalsScreen} />
      <Stack.Screen name="ApprovalDetails" component={ApprovalDetailsScreen} />
      <Stack.Screen name="Claims" component={ClaimsScreen} />
      <Stack.Screen name="ClaimDetails" component={ClaimDetailsScreen} />
      <Stack.Screen name="SubmitClaim" component={SubmitClaimScreen} />
      <Stack.Screen name="ProviderSearch" component={ProviderSearchScreen} />
      <Stack.Screen name="ProviderDetails" component={ProviderDetailsScreen} />
      <Stack.Screen name="Telemedicine" component={TelemedicineScreen} />
      <Stack.Screen name="InstantGP" component={InstantGPScreen} />
      <Stack.Screen name="ChronicCare" component={ChronicCareScreen} />
      <Stack.Screen name="ProgramDetails" component={ProgramDetailsScreen} />
      <Stack.Screen name="Wellness" component={WellnessScreen} />
      <Stack.Screen name="Support" component={SupportScreen} />
      <Stack.Screen name="FAQ" component={FAQScreen} />
      <Stack.Screen name="ContactUs" component={ContactUsScreen} />
      <Stack.Screen name="Profile" component={ProfileScreen} />
    </Stack.Navigator>
  );
};
