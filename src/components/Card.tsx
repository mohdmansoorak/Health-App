/**
 * Reusable Card Component
 */
import React from 'react';
import {View, StyleSheet, ViewStyle} from 'react-native';
import {colors, spacing, borderRadius, shadows} from '../config/theme';

interface CardProps {
  children: React.ReactNode;
  style?: ViewStyle;
  elevation?: 'none' | 'sm' | 'md' | 'lg';
  padding?: 'none' | 'sm' | 'md' | 'lg';
}

export const Card: React.FC<CardProps> = ({
  children,
  style,
  elevation = 'md',
  padding = 'md',
}) => {
  const cardStyle = [
    styles.card,
    elevation !== 'none' && shadows[elevation],
    padding !== 'none' && styles[`padding_${padding}`],
    style,
  ];

  return <View style={cardStyle}>{children}</View>;
};

const styles = StyleSheet.create({
  card: {
    backgroundColor: colors.card,
    borderRadius: borderRadius.lg,
  },
  padding_sm: {
    padding: spacing.sm,
  },
  padding_md: {
    padding: spacing.md,
  },
  padding_lg: {
    padding: spacing.lg,
  },
});
