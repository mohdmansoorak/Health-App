/**
 * RTL (Right-to-Left) utilities
 */
import {I18nManager} from 'react-native';
import i18n from '../config/i18n';

/**
 * Check if current language is RTL
 */
export const isRTL = (): boolean => {
  return i18n.language === 'ar';
};

/**
 * Force RTL layout
 */
export const forceRTL = (rtl: boolean): void => {
  I18nManager.forceRTL(rtl);
};

/**
 * Allow RTL
 */
export const allowRTL = (allow: boolean): void => {
  I18nManager.allowRTL(allow);
};

/**
 * Get text alignment based on RTL
 */
export const textAlign = (): 'left' | 'right' => {
  return isRTL() ? 'right' : 'left';
};

/**
 * Get flex direction based on RTL
 */
export const flexDirection = (): 'row' | 'row-reverse' => {
  return isRTL() ? 'row-reverse' : 'row';
};
