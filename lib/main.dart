import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

var kColor =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(173, 196, 206, 1));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColor,
            scaffoldBackgroundColor: const Color.fromRGBO(238, 224, 201, 1),
            cardTheme: const CardTheme().copyWith(
              color: const Color.fromRGBO(241, 240, 232, 1),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: const Color.fromRGBO(150, 182, 197, 1)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(238, 224, 201, 1))),
            bottomSheetTheme: const BottomSheetThemeData().copyWith(
              backgroundColor: const Color.fromRGBO(241, 240, 232, 1),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                    titleLarge: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 77, 132, 158),
                  fontSize: 16,
                ))),
        home: const Expenses()),
  );
}
