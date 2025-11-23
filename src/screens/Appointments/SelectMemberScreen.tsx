import React from 'react';
import {View, Text, StyleSheet, SafeAreaView} from 'react-native';
import {colors, spacing, fontSize, fontWeight} from '../../config/theme';

const SelectMemberScreen = () => {
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.title}>Select Member</Text>
        <Text style={styles.subtitle}>Feature coming soon</Text>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: colors.background},
  content: {flex: 1, padding: spacing.lg, justifyContent: 'center', alignItems: 'center'},
  title: {fontSize: fontSize.xxl, fontWeight: fontWeight.bold, color: colors.text, marginBottom: spacing.sm},
  subtitle: {fontSize: fontSize.md, color: colors.textSecondary},
});

export default SelectMemberScreen;
