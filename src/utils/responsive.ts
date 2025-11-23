/**
 * Responsive utilities for different screen sizes
 */
import {Dimensions, PixelRatio} from 'react-native';

const {width: SCREEN_WIDTH, height: SCREEN_HEIGHT} = Dimensions.get('window');

// Base dimensions (iPhone 11 Pro)
const baseWidth = 375;
const baseHeight = 812;

/**
 * Scale function for responsive width
 */
export const scaleWidth = (size: number): number => {
  return PixelRatio.roundToNearestPixel((SCREEN_WIDTH / baseWidth) * size);
};

/**
 * Scale function for responsive height
 */
export const scaleHeight = (size: number): number => {
  return PixelRatio.roundToNearestPixel((SCREEN_HEIGHT / baseHeight) * size);
};

/**
 * Moderate scale - less aggressive scaling
 */
export const moderateScale = (size: number, factor = 0.5): number => {
  return PixelRatio.roundToNearestPixel(size + (scaleWidth(size) - size) * factor);
};

/**
 * Responsive font size
 */
export const responsiveFontSize = (size: number): number => {
  return moderateScale(size, 0.3);
};

/**
 * Get responsive dimensions
 */
export const getDimensions = () => ({
  width: SCREEN_WIDTH,
  height: SCREEN_HEIGHT,
  isSmallDevice: SCREEN_WIDTH < 375,
  isMediumDevice: SCREEN_WIDTH >= 375 && SCREEN_WIDTH < 414,
  isLargeDevice: SCREEN_WIDTH >= 414,
});
