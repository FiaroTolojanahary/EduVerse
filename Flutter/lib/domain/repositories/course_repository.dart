import '../entities/course.dart';

abstract interface class CourseRepository {
  List<Course> getCourses();

  void addCourse(Course course);
}
