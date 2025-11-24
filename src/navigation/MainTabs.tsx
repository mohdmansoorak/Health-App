/**
 * Main Bottom Tab Navigator
 */
import React from 'react';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import {MainTabParamList} from './types';
import {colors} from '../config/theme';
import {Text} from 'react-native';

// Import stack navigators
import {HomeStack} from './HomeStack';
import {PolicyStack} from './PolicyStack';
import {AppointmentsStack} from './AppointmentsStack';
import {MoreStack} from './MoreStack';

const Tab = createBottomTabNavigator<MainTabParamList>();

export const MainTabs = () => {
  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.textLight,
        tabBarStyle: {
          borderTopWidth: 1,
          borderTopColor: colors.border,
        },
      }}>
      <Tab.Screen
        name="HomeTab"
        component={HomeStack}
        options={{
          title: 'Home',
          tabBarIcon: ({color}) => <Text style={{color, fontSize: 20}}>🏠</Text>,
        }}
      />
      <Tab.Screen
        name="PolicyTab"
        component={PolicyStack}
        options={{
          title: 'Policy',
          tabBarIcon: ({color}) => <Text style={{color, fontSize: 20}}>📋</Text>,
        }}
      />
      <Tab.Screen
        name="AppointmentsTab"
        component={AppointmentsStack}
        options={{
          title: 'Appointments',
          tabBarIcon: ({color}) => <Text style={{color, fontSize: 20}}>📅</Text>,
        }}
      />
      <Tab.Screen
        name="MoreTab"
        component={MoreStack}
        options={{
          title: 'More',
          tabBarIcon: ({color}) => <Text style={{color, fontSize: 20}}>☰</Text>,
        }}
      />
    </Tab.Navigator>
  );
};
