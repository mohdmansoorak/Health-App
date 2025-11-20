import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/otp_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/appointments/screens/booking_wizard_screen.dart';
import '../../features/appointments/screens/appointments_list_screen.dart';
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

    // Placeholder Routes (to be implemented)
    GoRoute(
      path: '/wellness',
      redirect: (context, state) => '/home',
    ),
    GoRoute(
      path: '/claims',
      redirect: (context, state) => '/home',
    ),
    GoRoute(
      path: '/profile',
      redirect: (context, state) => '/home',
    ),

    // Default route
    GoRoute(
      path: '/',
      redirect: (context, state) => '/splash',
    ),
  ],
);
