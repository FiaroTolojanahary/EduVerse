import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/course_data_source.dart';
import 'data/datasources/learning_data_source.dart';
import 'data/repositories/in_memory_learning_repository.dart';
import 'presentation/screens/auth_screen.dart';
import 'presentation/state/eduverse_state.dart';

void main() {
  runApp(const EduVerseApp());
}

class EduVerseApp extends StatelessWidget {
  const EduVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EduVerseState(
        courseRepository: InMemoryCourseRepository(
          dataSource: InMemoryCourseDataSource(),
        ),
        learningRepository: InMemoryLearningRepository(
          dataSource: InMemoryLearningDataSource(),
        ),
      ),
      child: MaterialApp(
        title: 'EduVerse',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
          scaffoldBackgroundColor: const Color(0xFFF8FAFC),
          useMaterial3: true,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF0F172A),
            elevation: 0,
            centerTitle: false,
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF2563EB), width: 2),
            ),
          ),
          snackBarTheme: const SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF0F172A),
            contentTextStyle: TextStyle(color: Colors.white),
          ),
        ),
        home: const AuthScreen(),
      ),
    );
  }
}