/**
 * Authentication Service with Mock Data
 */

export interface LoginRequest {
  mobileOrId: string;
}

export interface OTPRequest {
  mobileOrId: string;
  otp: string;
}

export interface PINRequest {
  pin: string;
}

export const authService = {
  /**
   * Send OTP to mobile/ID
   */
  sendOTP: async (data: LoginRequest): Promise<{success: boolean; message: string}> => {
    // Mock API call
    return new Promise(resolve => {
      setTimeout(() => {
        resolve({
          success: true,
          message: 'OTP sent successfully',
        });
      }, 1000);
    });
  },

  /**
   * Verify OTP
   */
  verifyOTP: async (data: OTPRequest): Promise<{success: boolean; token?: string}> => {
    // Mock API call
    return new Promise(resolve => {
      setTimeout(() => {
        if (data.otp === '1234') {
          resolve({
            success: true,
            token: 'mock-jwt-token-12345',
          });
        } else {
          resolve({
            success: false,
          });
        }
      }, 1000);
    });
  },

  /**
   * Create PIN
   */
  createPIN: async (data: PINRequest): Promise<{success: boolean}> => {
    // Mock API call
    return new Promise(resolve => {
      setTimeout(() => {
        resolve({success: true});
      }, 500);
    });
  },

  /**
   * Verify PIN
   */
  verifyPIN: async (data: PINRequest): Promise<{success: boolean; token?: string}> => {
    // Mock API call
    return new Promise(resolve => {
      setTimeout(() => {
        if (data.pin === '1234') {
          resolve({
            success: true,
            token: 'mock-jwt-token-12345',
          });
        } else {
          resolve({success: false});
        }
      }, 500);
    });
  },

  /**
   * Get user profile
   */
  getUserProfile: async () => {
    // Mock API call
    return new Promise(resolve => {
      setTimeout(() => {
        resolve({
          id: '1',
          name: 'Ahmed Al-Mansoor',
          mobile: '+966 50 123 4567',
          nationalId: '1234567890',
          policyNumber: 'POL-2024-001',
          email: 'ahmed@example.com',
        });
      }, 500);
    });
  },
};
