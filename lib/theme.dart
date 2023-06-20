import 'package:flutter/material.dart';

class FakeFootballDashboardTheme {
  BuildContext context;
  static ThemeData? themeData;

  FakeFootballDashboardTheme(this.context);

  ThemeData get mainTheme {
    themeData ??= ThemeData(
      fontFamily: 'FuturaPtDemi',
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white, fontFamily: 'FuturaPtDemi')),
      brightness: Brightness.dark,
      primarySwatch: Colors.yellow,
    );
    return themeData!;
  }
}
