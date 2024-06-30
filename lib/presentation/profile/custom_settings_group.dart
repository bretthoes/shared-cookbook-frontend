import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/profile/settings_group.dart';
import 'package:flutter/material.dart';

class CustomSettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  CustomSettingsGroup({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: this.title,
      titleTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _themeStore.darkMode ? Colors.white : Colors.black),
      children: this.children,
    );
  }
}
