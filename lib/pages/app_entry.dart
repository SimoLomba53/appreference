import 'package:flutter/material.dart';
import 'package:growingapp/core/patch/patch.dart';
import 'package:growingapp/features/onboarding/presentation/pages/onboarding.dart';
import 'package:growingapp/injection_container.dart';
import 'package:growingapp/pages/home/main_view_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  @override
  void initState() {
    super.initState();
    patch(context);
  }

  @override
  Widget build(BuildContext context) {
    return (sl<SharedPreferences>().getBool('first-open') ?? true)
        ? const OnboardingPage()
        : const MainViewPage();
  }
}
