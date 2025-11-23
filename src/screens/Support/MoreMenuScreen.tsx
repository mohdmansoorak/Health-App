import React from 'react';
import {View, Text, StyleSheet, SafeAreaView, ScrollView, TouchableOpacity} from 'react-native';
import {NativeStackNavigationProp} from '@react-navigation/native-stack';
import {MoreStackParamList} from '../../navigation/types';
import {Card} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {useDispatch} from 'react-redux';
import {logout} from '../../store/slices/authSlice';

type MoreMenuScreenProps = {
  navigation: NativeStackNavigationProp<MoreStackParamList, 'MoreMenu'>;
};

const MoreMenuScreen: React.FC<MoreMenuScreenProps> = ({navigation}) => {
  const dispatch = useDispatch();

  const menuItems = [
    {title: 'Profile', icon: '👤', onPress: () => navigation.navigate('Profile')},
    {title: 'Approvals', icon: '✅', onPress: () => navigation.navigate('Approvals')},
    {title: 'Claims', icon: '📄', onPress: () => navigation.navigate('Claims')},
    {title: 'Find Provider', icon: '🏥', onPress: () => navigation.navigate('ProviderSearch')},
    {title: 'Telemedicine', icon: '📱', onPress: () => navigation.navigate('Telemedicine')},
    {title: 'Instant GP', icon: '👨‍⚕️', onPress: () => navigation.navigate('InstantGP')},
    {title: 'Chronic Care', icon: '💊', onPress: () => navigation.navigate('ChronicCare')},
    {title: 'Wellness Rewards', icon: '💪', onPress: () => navigation.navigate('Wellness')},
    {title: 'Support', icon: '❓', onPress: () => navigation.navigate('Support')},
    {title: 'FAQ', icon: '📖', onPress: () => navigation.navigate('FAQ')},
    {title: 'Contact Us', icon: '📞', onPress: () => navigation.navigate('ContactUs')},
    {title: 'Logout', icon: '🚪', onPress: () => dispatch(logout())},
  ];

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>More</Text>
      </View>
      <ScrollView contentContainerStyle={styles.content}>
        {menuItems.map((item, index) => (
          <TouchableOpacity key={index} onPress={item.onPress}>
            <Card style={styles.menuItem}>
              <Text style={styles.icon}>{item.icon}</Text>
              <Text style={styles.menuTitle}>{item.title}</Text>
              <Text style={styles.arrow}>→</Text>
            </Card>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: colors.background},
  header: {padding: spacing.lg, borderBottomWidth: 1, borderBottomColor: colors.border, backgroundColor: colors.surface},
  title: {fontSize: fontSize.xxl, fontWeight: fontWeight.bold, color: colors.text},
  content: {padding: spacing.lg},
  menuItem: {flexDirection: 'row', alignItems: 'center', marginBottom: spacing.sm, padding: spacing.md},
  icon: {fontSize: 24, marginRight: spacing.md},
  menuTitle: {flex: 1, fontSize: fontSize.md, color: colors.text},
  arrow: {fontSize: fontSize.lg, color: colors.textLight},
});

export default MoreMenuScreen;
