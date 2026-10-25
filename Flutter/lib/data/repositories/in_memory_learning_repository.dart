import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../../domain/repositories/learning_repository.dart';
import '../datasources/course_data_source.dart';
import '../datasources/learning_data_source.dart';

class InMemoryCourseRepository implements CourseRepository {
  final CourseDataSource _dataSource;

  InMemoryCourseRepository({CourseDataSource? dataSource})
      : _dataSource = dataSource ?? InMemoryCourseDataSource();

  @override
  List<Course> getCourses() => _dataSource.getCourses();

  @override
  void addCourse(Course course) {
    _dataSource.addCourse(course);
  }
}

class InMemoryLearningRepository implements LearningRepository {
  final LearningDataSource _dataSource;

  InMemoryLearningRepository({LearningDataSource? dataSource})
      : _dataSource = dataSource ?? InMemoryLearningDataSource();

  @override
  List<QuizQuestion> getQuizQuestions() => _dataSource.getQuizQuestions();

  @override
  List<ForumPost> getForumPosts() => _dataSource.getForumPosts();

  @override
  List<ChatMessage> getChatMessages() => _dataSource.getChatMessages();

  @override
  List<Certificate> getCertificates() => _dataSource.getCertificates();
}
