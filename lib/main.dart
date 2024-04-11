import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 62, 64, 134));
var kDarkColorScheme =
    ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 18, 64, 53));

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: kDarkColorScheme.onSecondary)),
        textTheme: const TextTheme().copyWith(
          bodyMedium: TextStyle(fontSize: 16, color: kDarkColorScheme.scrim),
          titleLarge: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        brightness: Brightness.light,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: const Color.fromARGB(255, 174, 176, 223),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: kColorScheme.onSecondary)),
        textTheme: const TextTheme().copyWith(
          bodyMedium: TextStyle(fontSize: 16, color: kColorScheme.scrim),
          titleLarge: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
