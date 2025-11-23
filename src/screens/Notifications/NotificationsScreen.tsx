import React from 'react';
import {View, Text, StyleSheet, SafeAreaView, ScrollView} from 'react-native';
import {Card} from '../../components';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';
import {mockNotifications} from '../../services/mockData';

const NotificationsScreen = () => {
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Notifications</Text>
      </View>
      <ScrollView contentContainerStyle={styles.content}>
        {mockNotifications.map(notif => (
          <Card
            key={notif.id}
            style={[styles.notifCard, !notif.read && styles.unread]}>
            <View style={styles.notifHeader}>
              <Text style={styles.notifTitle}>{notif.title}</Text>
              <Text style={styles.notifDate}>{notif.date}</Text>
            </View>
            <Text style={styles.notifMessage}>{notif.message}</Text>
            {!notif.read && <View style={styles.unreadDot} />}
          </Card>
        ))}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background,
  },
  header: {
    padding: spacing.lg,
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
    backgroundColor: colors.surface,
  },
  title: {
    fontSize: fontSize.xxl,
    fontWeight: fontWeight.bold,
    color: colors.text,
  },
  content: {
    padding: spacing.lg,
  },
  notifCard: {
    marginBottom: spacing.sm,
    position: 'relative',
  },
  unread: {
    backgroundColor: colors.primaryLight,
    opacity: 0.9,
  },
  notifHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: spacing.xs,
  },
  notifTitle: {
    fontSize: fontSize.md,
    fontWeight: fontWeight.semibold,
    color: colors.text,
    flex: 1,
  },
  notifDate: {
    fontSize: fontSize.xs,
    color: colors.textLight,
  },
  notifMessage: {
    fontSize: fontSize.sm,
    color: colors.textSecondary,
  },
  unreadDot: {
    position: 'absolute',
    top: spacing.md,
    right: spacing.md,
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: colors.primary,
  },
});

export default NotificationsScreen;
