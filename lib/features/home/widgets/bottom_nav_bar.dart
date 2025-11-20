import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/constants/app_colors.dart';

/// Bottom navigation bar with 5 main tabs
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = context.watch<LocaleProvider>().isArabic;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,
      unselectedFontSize: 11,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_rounded),
          label: l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_today_rounded),
          label: l10n.care,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_rounded),
          label: l10n.wellness,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.receipt_long_rounded),
          label: l10n.claims,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_rounded),
          label: l10n.profile,
        ),
      ],
    );
  }
}
