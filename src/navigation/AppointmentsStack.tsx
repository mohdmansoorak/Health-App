/**
 * Appointments Stack Navigator
 */
import React from 'react';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import {AppointmentsStackParamList} from './types';

import AppointmentListScreen from '../screens/Appointments/AppointmentListScreen';
import BookAppointmentScreen from '../screens/Appointments/BookAppointmentScreen';
import SelectMemberScreen from '../screens/Appointments/SelectMemberScreen';
import SelectVisitTypeScreen from '../screens/Appointments/SelectVisitTypeScreen';
import SelectDoctorScreen from '../screens/Appointments/SelectDoctorScreen';
import SelectDateTimeScreen from '../screens/Appointments/SelectDateTimeScreen';
import AppointmentConfirmScreen from '../screens/Appointments/AppointmentConfirmScreen';
import AppointmentDetailsScreen from '../screens/Appointments/AppointmentDetailsScreen';

const Stack = createNativeStackNavigator<AppointmentsStackParamList>();

export const AppointmentsStack = () => {
  return (
    <Stack.Navigator screenOptions={{headerShown: false}}>
      <Stack.Screen name="AppointmentList" component={AppointmentListScreen} />
      <Stack.Screen name="BookAppointment" component={BookAppointmentScreen} />
      <Stack.Screen name="SelectMember" component={SelectMemberScreen} />
      <Stack.Screen name="SelectVisitType" component={SelectVisitTypeScreen} />
      <Stack.Screen name="SelectDoctor" component={SelectDoctorScreen} />
      <Stack.Screen name="SelectDateTime" component={SelectDateTimeScreen} />
      <Stack.Screen name="AppointmentConfirm" component={AppointmentConfirmScreen} />
      <Stack.Screen name="AppointmentDetails" component={AppointmentDetailsScreen} />
    </Stack.Navigator>
  );
};
