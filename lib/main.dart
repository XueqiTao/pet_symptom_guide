import 'package:flutter/material.dart';
import 'screens/symptom_list_screen.dart';
import 'screens/symptom_detail_screen.dart';

void main() {
  runApp(const PetSymptomGuideApp());
}

class PetSymptomGuideApp extends StatelessWidget {
  const PetSymptomGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Symptom Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF4D00),
        scaffoldBackgroundColor: const Color(0xFFF5F9FF),
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFF4D00),
          secondary: const Color(0xFFFFD7CC),
          surface: Colors.white,
          background: const Color(0xFFF5F9FF),
          error: Colors.red[400]!,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          color: const Color(0xFFFFD7CC),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4D00),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFFFF4D00),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          foregroundColor: Color(0xFFFF4D00),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF4A4A4A),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SymptomListScreen(),
        '/symptom-detail': (context) {
          final symptomId = ModalRoute.of(context)!.settings.arguments as String;
          return SymptomDetailScreen(symptomId: symptomId);
        },
      },
    );
  }
}
