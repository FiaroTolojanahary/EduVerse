import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/course_data_source.dart';
import 'data/datasources/learning_data_source.dart';
import 'data/repositories/in_memory_learning_repository.dart';
import 'data/repository/course_repository.dart';
import 'ui/screens/auth_screen.dart';
import 'ui/state/eduverse_state.dart';
import 'ui/themes/app_theme.dart';

void main() {
  runApp(const EduVerseApp());
}

class EduVerseApp extends StatelessWidget {
  const EduVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EduVerseState(
        courseRepository: AppCourseRepository(
          localDataSource: InMemoryCourseDataSource(),
        ),
        learningRepository: InMemoryLearningRepository(
          dataSource: InMemoryLearningDataSource(),
        ),
      ),
      child: MaterialApp(
        title: 'EduVerse',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthScreen(),
      ),
    );
  }
}