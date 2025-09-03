
import 'package:flutter/material.dart';

/// Global theme utilities for violet + black gradient across the app.
class AppTheme {
  static const Color topBlack = Color(0xFF000000);
  static const Color bottomViolet = Color(0xFF4B0F6B); // violet like your sample

  static const LinearGradient mainGradient = LinearGradient(
    colors: [topBlack, bottomViolet],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static BoxDecoration gradientBg() => const BoxDecoration(gradient: mainGradient);

  static PreferredSizeWidget gradientAppBar(String title, {List<Widget>? actions}) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
      flexibleSpace: Container(decoration: gradientBg()),
    );
  }

  static Widget gradientScaffoldBody({required Widget child}) {
    return Container(decoration: gradientBg(), child: child);
  }
}
