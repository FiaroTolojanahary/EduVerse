import '../../domain/entities/course.dart';
import '../mock_data.dart';

abstract interface class CourseDataSource {
  List<Course> getCourses();

  void addCourse(Course course);
}

class InMemoryCourseDataSource implements CourseDataSource {
  final List<Course> _courses;

  InMemoryCourseDataSource({List<Course>? courses})
      : _courses = List.of(courses ?? mockCourses);

  @override
  List<Course> getCourses() => List.unmodifiable(_courses);

  @override
  void addCourse(Course course) {
    _courses.insert(0, course);
  }
}

// TODO: replace with RemoteCourseDataSource when the backend is ready.
// final class RemoteCourseDataSource implements CourseDataSource {
//   @override
//   List<Course> getCourses() => throw UnimplementedError();
//
//   @override
//   void addCourse(Course course) => throw UnimplementedError();
// }
