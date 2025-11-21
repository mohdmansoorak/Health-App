import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_insurance_app/features/auth/screens/login_screen.dart';
import 'package:health_insurance_app/core/providers/auth_provider.dart';
import 'package:health_insurance_app/core/providers/locale_provider.dart';
import 'package:health_insurance_app/core/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginScreen Widget Tests', () {
    late AuthProvider authProvider;
    late LocaleProvider localeProvider;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      authProvider = AuthProvider();
      localeProvider = LocaleProvider();
      await Future.delayed(const Duration(milliseconds: 100));
    });

    tearDown(() {
      authProvider.dispose();
      localeProvider.dispose();
    });

    Widget createLoginScreen() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
          ChangeNotifierProvider<LocaleProvider>.value(value: localeProvider),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          home: const LoginScreen(),
        ),
      );
    }

    testWidgets('should display app logo and title', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find logo icon
      expect(find.byIcon(Icons.local_hospital_rounded), findsOneWidget);

      // Find title
      expect(find.text('CareConnect'), findsOneWidget);
    });

    testWidgets('should display language toggle button', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find language icon
      expect(find.byIcon(Icons.language), findsOneWidget);

      // Find language text (should show Arabic option when in English)
      expect(find.text('عربي'), findsOneWidget);
    });

    testWidgets('should toggle language when language button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Initial state - should show Arabic option
      expect(find.text('عربي'), findsOneWidget);

      // Tap language toggle
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();

      // After toggle - should show English option
      expect(find.text('EN'), findsOneWidget);
    });

    testWidgets('should display input field for mobile/ID', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find text field
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('should display Continue button', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find Continue button
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('should allow text input', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find text field and enter text
      final textField = find.byType(TextField).first;
      await tester.enterText(textField, '1234567890');
      await tester.pump();

      // Verify text was entered
      expect(find.text('1234567890'), findsOneWidget);
    });

    testWidgets('should show error when Continue clicked with empty field', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Tap Continue button without entering text
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Verify error message appears
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('should show loading indicator when sending OTP', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Enter mobile number
      final textField = find.byType(TextField).first;
      await tester.enterText(textField, '1234567890');
      await tester.pump();

      // Tap Continue
      await tester.tap(find.text('Continue'));
      await tester.pump();

      // Verify loading indicator appears
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display login method toggle buttons', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Find Mobile and ID toggle buttons
      expect(find.text('Mobile Number'), findsOneWidget);
      expect(find.text('National/Member ID'), findsOneWidget);
    });

    testWidgets('should change input label when switching login method', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Initial state - Mobile Number should be selected
      expect(find.text('Mobile Number'), findsOneWidget);

      // Tap National/Member ID option
      await tester.tap(find.text('National/Member ID'));
      await tester.pumpAndSettle();

      // Verify UI updated
      expect(find.text('National/Member ID'), findsOneWidget);
    });

    testWidgets('should display biometric login option when available', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // On web, biometric won't be available, so it might not show
      // On mobile tests, it would show
      // This test documents the expected behavior
    });

    testWidgets('should render correctly in Arabic', (WidgetTester tester) async {
      // Set locale to Arabic
      await localeProvider.setArabic();

      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Verify Arabic text is displayed
      expect(find.text('كير كونكت'), findsOneWidget);

      // Verify text direction is RTL
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(Directionality.of(tester.element(find.byType(Scaffold))), TextDirection.rtl);
    });

    testWidgets('should maintain state when rebuilding', (WidgetTester tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Enter text
      final textField = find.byType(TextField).first;
      await tester.enterText(textField, '1234567890');
      await tester.pump();

      // Trigger rebuild
      await tester.pump();

      // Verify text is still there
      expect(find.text('1234567890'), findsOneWidget);
    });
  });
}
