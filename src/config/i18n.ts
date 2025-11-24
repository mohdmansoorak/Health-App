/**
 * i18n Configuration
 * Multilingual support for English and Arabic with RTL
 */
import i18n from 'i18next';
import {initReactI18next} from 'react-i18next';

// Translation resources
const resources = {
  en: {
    translation: {
      // Common
      common: {
        welcome: 'Welcome',
        continue: 'Continue',
        submit: 'Submit',
        cancel: 'Cancel',
        confirm: 'Confirm',
        save: 'Save',
        edit: 'Edit',
        delete: 'Delete',
        search: 'Search',
        filter: 'Filter',
        back: 'Back',
        next: 'Next',
        loading: 'Loading...',
        error: 'Error',
        success: 'Success',
      },
      // Auth
      auth: {
        login: 'Login',
        loginSubtitle: 'Enter your details to access your account',
        mobileNumber: 'Mobile Number',
        nationalId: 'National ID / Iqama',
        enterOtp: 'Enter OTP',
        otpSent: 'OTP sent to your mobile',
        createPin: 'Create PIN',
        confirmPin: 'Confirm PIN',
        forgotPin: 'Forgot PIN?',
        logout: 'Logout',
      },
      // Dashboard
      dashboard: {
        title: 'Dashboard',
        quickActions: 'Quick Actions',
        eCard: 'e-Card',
        benefits: 'Benefits',
        approvals: 'Approvals',
        claims: 'Claims',
        bookAppointment: 'Book Appointment',
        instantDoctor: 'Instant Doctor',
        wellness: 'Wellness',
        upcomingAppointments: 'Upcoming Appointments',
        claimsUpdates: 'Claims Updates',
        approvalStatus: 'Approval Status',
      },
      // Navigation
      nav: {
        home: 'Home',
        policy: 'Policy',
        appointments: 'Appointments',
        more: 'More',
      },
    },
  },
  ar: {
    translation: {
      // Common
      common: {
        welcome: 'مرحباً',
        continue: 'متابعة',
        submit: 'إرسال',
        cancel: 'إلغاء',
        confirm: 'تأكيد',
        save: 'حفظ',
        edit: 'تعديل',
        delete: 'حذف',
        search: 'بحث',
        filter: 'تصفية',
        back: 'رجوع',
        next: 'التالي',
        loading: 'جاري التحميل...',
        error: 'خطأ',
        success: 'نجح',
      },
      // Auth
      auth: {
        login: 'تسجيل الدخول',
        loginSubtitle: 'أدخل بياناتك للوصول إلى حسابك',
        mobileNumber: 'رقم الجوال',
        nationalId: 'رقم الهوية / الإقامة',
        enterOtp: 'أدخل رمز التحقق',
        otpSent: 'تم إرسال رمز التحقق إلى جوالك',
        createPin: 'إنشاء رمز PIN',
        confirmPin: 'تأكيد رمز PIN',
        forgotPin: 'نسيت رمز PIN؟',
        logout: 'تسجيل الخروج',
      },
      // Dashboard
      dashboard: {
        title: 'لوحة التحكم',
        quickActions: 'إجراءات سريعة',
        eCard: 'البطاقة الإلكترونية',
        benefits: 'المزايا',
        approvals: 'الموافقات',
        claims: 'المطالبات',
        bookAppointment: 'حجز موعد',
        instantDoctor: 'طبيب فوري',
        wellness: 'العافية',
        upcomingAppointments: 'المواعيد القادمة',
        claimsUpdates: 'تحديثات المطالبات',
        approvalStatus: 'حالة الموافقة',
      },
      // Navigation
      nav: {
        home: 'الرئيسية',
        policy: 'الوثيقة',
        appointments: 'المواعيد',
        more: 'المزيد',
      },
    },
  },
};

i18n
  .use(initReactI18next)
  .init({
    compatibilityJSON: 'v3',
    resources,
    lng: 'en',
    fallbackLng: 'en',
    interpolation: {
      escapeValue: false,
    },
  });

export default i18n;
