import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightDefault = ThemeData.light(useMaterial3: true);
  static final ThemeData darkDefault = ThemeData.dark(useMaterial3: true);

  static final ThemeData lightRedTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    primaryColorLight: Colors.red,
    useMaterial3: true,
  );
  static final ThemeData lightYellowTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
    primaryColorLight: Colors.yellow,
    useMaterial3: true,
  );
  static final ThemeData lightGreenTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    primaryColorLight: Colors.green,
    useMaterial3: true,
  );
  static final ThemeData lightBlueTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    primaryColorLight: Colors.blue,
    useMaterial3: true,
  );

  static final ThemeData darkRedTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
    ),
    primaryColorLight: Colors.red,
    useMaterial3: true,
  );
  static final ThemeData darkYellowTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.yellow,
      brightness: Brightness.dark,
    ),
    primaryColorLight: Colors.yellow,
    useMaterial3: true,
  );
  static final ThemeData darkGreenTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
    primaryColorLight: Colors.green,
    useMaterial3: true,
  );
  static final ThemeData darkBlueTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    primaryColorLight: Colors.blue,
    useMaterial3: true,
  );
}
