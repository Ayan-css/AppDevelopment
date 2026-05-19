import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/today/data/today_repository.dart';
import '../features/today/presentation/state/today_controller.dart';
import '../features/today/presentation/today_screen.dart';

class FounderCockpitApp extends StatefulWidget {
  const FounderCockpitApp({super.key});

  @override
  State<FounderCockpitApp> createState() => _FounderCockpitAppState();
}

class _FounderCockpitAppState extends State<FounderCockpitApp> {
  late final TodayController _todayController;

  @override
  void initState() {
    super.initState();
    _todayController = TodayController(TodayRepository());
    _todayController.load();
  }

  @override
  void dispose() {
    _todayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Founder Cockpit',
      theme: AppTheme.dark(),
      home: TodayScreen(controller: _todayController),
    );
  }
}
