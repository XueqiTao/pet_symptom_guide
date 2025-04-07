import 'package:flutter/material.dart';
import 'screens/symptom_list_screen.dart';
import 'screens/symptom_detail_screen.dart';
import 'models/symptom.dart';

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
        primaryColor: const Color(0xFF00856A),
        scaffoldBackgroundColor: const Color(0xFFF5F9FF),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00856A),
          primary: const Color(0xFF00856A),
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
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => const SymptomListScreen(),
          );
        } else if (settings.name == '/symptom_details') {
          final symptom = settings.arguments as Symptom;
          return MaterialPageRoute(
            builder: (context) => SymptomDetailScreen(symptom: symptom),
          );
        }
        return null;
      },
    );
  }
}
