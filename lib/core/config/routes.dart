import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/otp_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/appointments/screens/booking_wizard_screen.dart';
import '../../features/appointments/screens/appointments_list_screen.dart';
import '../../features/wellness/screens/wellness_screen.dart';
import '../../features/claims/screens/claims_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../core/models/appointment.dart';

/// App routing configuration
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Auth Routes
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),

    // Main Routes
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Appointment Routes
    GoRoute(
      path: '/appointments',
      builder: (context, state) => const AppointmentsListScreen(),
    ),
    GoRoute(
      path: '/booking/instant',
      builder: (context, state) => const BookingWizardScreen(
        appointmentType: AppointmentType.instantConsultation,
      ),
    ),
    GoRoute(
      path: '/booking/online',
      builder: (context, state) => const BookingWizardScreen(
        appointmentType: AppointmentType.onlineConsultation,
      ),
    ),
    GoRoute(
      path: '/booking/physical',
      builder: (context, state) => const BookingWizardScreen(
        appointmentType: AppointmentType.physicalClinic,
      ),
    ),

    // Main App Routes
    GoRoute(
      path: '/wellness',
      builder: (context, state) => const WellnessScreen(),
    ),
    GoRoute(
      path: '/claims',
      builder: (context, state) => const ClaimsScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),

    // Default route
    GoRoute(
      path: '/',
      redirect: (context, state) => '/splash',
    ),
  ],
);
