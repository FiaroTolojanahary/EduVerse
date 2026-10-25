import 'package:flutter/foundation.dart';

import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../../domain/repositories/learning_repository.dart';

class EduVerseState extends ChangeNotifier {
  final CourseRepository courseRepository;
  final LearningRepository learningRepository;

  EduVerseState({
    required this.courseRepository,
    required this.learningRepository,
  })  : _courses = courseRepository.getCourses(),
        _forumPosts = learningRepository.getForumPosts(),
        _chatMessages = learningRepository.getChatMessages(),
        _certificates = learningRepository.getCertificates(),
        quizQuestions = learningRepository.getQuizQuestions();

  bool _isLoggedIn = false;
  int _selectedIndex = 0;
  bool _offlineMode = false;
  final List<Course> _courses;
  final List<Course> _favorites = [];
  final List<String> _notifications = [
    'Votre progression a été mise à jour',
    'Nouveau quiz disponible sur l’IA',
    'Un nouveau cours a été ajouté à votre catalogue',
  ];
  final Map<String, bool> _completedLessons = {};
  final List<String> _exercisesDone = [];
  final List<ForumPost> _forumPosts;
  final List<ChatMessage> _chatMessages;
  final List<Certificate> _certificates;
  final List<QuizQuestion> quizQuestions;

  bool get isLoggedIn => _isLoggedIn;
  int get selectedIndex => _selectedIndex;
  bool get offlineMode => _offlineMode;
  List<Course> get courses => List.unmodifiable(_courses);
  List<Course> get favorites => List.unmodifiable(_favorites);
  List<String> get notifications => List.unmodifiable(_notifications);
  Map<String, bool> get completedLessons => Map.unmodifiable(_completedLessons);
  List<String> get exercisesDone => List.unmodifiable(_exercisesDone);
  List<ForumPost> get forumItems => List.unmodifiable(_forumPosts);
  List<ChatMessage> get chatItems => List.unmodifiable(_chatMessages);
  List<Certificate> get earnedCertificates => List.unmodifiable(_certificates);

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    if (index < 0 || index >= 5) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleOfflineMode() {
    _offlineMode = !_offlineMode;
    notifyListeners();
  }

  bool isFavorite(Course course) =>
      _favorites.any((item) => item.id == course.id);

  void toggleFavorite(Course course) {
    if (isFavorite(course)) {
      _favorites.removeWhere((item) => item.id == course.id);
    } else {
      _favorites.add(course);
    }
    notifyListeners();
  }

  void markLessonCompleted(String lessonId) {
    _completedLessons[lessonId] = true;
    notifyListeners();
  }

  void completeExercise(String task) {
    if (!_exercisesDone.contains(task)) {
      _exercisesDone.add(task);
      notifyListeners();
    }
  }

  void addForumPost(ForumPost post) {
    _forumPosts.insert(0, post);
    notifyListeners();
  }

  void sendMessage(String text) {
    _chatMessages.add(ChatMessage(author: 'Moi', text: text, isMe: true));
    notifyListeners();
  }

  void addCourse(Course course) {
    courseRepository.addCourse(course);
    _courses
      ..clear()
      ..addAll(courseRepository.getCourses());
    notifyListeners();
  }

  double progressFor(Course course) {
    if (course.lessonsData.isEmpty) return 0;
    final completed = course.lessonsData
        .where((lesson) => _completedLessons[lesson.id] == true)
        .length;
    return completed / course.lessonsData.length;
  }
}
