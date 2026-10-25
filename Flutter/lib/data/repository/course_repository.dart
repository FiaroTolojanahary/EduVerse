import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart' as domain;
import '../../network/api_client.dart';
import '../datasources/course_data_source.dart';

class AppCourseRepository implements domain.CourseRepository {
  AppCourseRepository({
    CourseDataSource? localDataSource,
    ApiClient? apiClient,
  })  : _localDataSource = localDataSource ?? InMemoryCourseDataSource(),
        _apiClient = apiClient ?? ApiClient();

  final CourseDataSource _localDataSource;
  final ApiClient _apiClient;

  Future<void> syncWithRemote() async {
    final response = await _apiClient.get('/courses');
    if (response.isEmpty) {
      return;
    }

    // À brancher sur le vrai backend quand la contract API sera disponible.
  }

  @override
  List<Course> getCourses() => _localDataSource.getCourses();

  @override
  void addCourse(Course course) {
    _localDataSource.addCourse(course);
  }
}
