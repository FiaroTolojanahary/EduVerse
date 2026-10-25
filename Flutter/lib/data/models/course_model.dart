import '../../domain/entities/course.dart';

class CourseModel {
  static const String tableName = 'courses';

  const CourseModel();

  Map<String, dynamic> toJson(Course course) {
    return {
      'id': course.id,
      'title': course.title,
      'category': course.category,
      'instructor': course.instructor,
      'description': course.description,
      'level': course.level,
      'rating': course.rating,
      'lessons': course.lessons,
      'durationHours': course.durationHours,
      'students': course.students,
      'imageUrl': course.imageUrl,
      'tags': course.tags,
      'lessonsData': course.lessonsData
          .map((lesson) => {
                'id': lesson.id,
                'title': lesson.title,
                'duration': lesson.duration,
                'content': lesson.content,
                'isFree': lesson.isFree,
              })
          .toList(),
    };
  }

  Course fromJson(Map<String, dynamic> json) {
    final lessons = (json['lessonsData'] as List<dynamic>? ?? []).map((entry) {
      final item = entry as Map<String, dynamic>;
      return Lesson(
        id: item['id'] as String,
        title: item['title'] as String,
        duration: item['duration'] as String,
        content: item['content'] as String,
        isFree: item['isFree'] as bool? ?? false,
      );
    }).toList();

    return Course(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      instructor: json['instructor'] as String,
      description: json['description'] as String,
      level: json['level'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      lessons: json['lessons'] as int? ?? 0,
      durationHours: json['durationHours'] as int? ?? 0,
      students: json['students'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>? ?? []).map((tag) => tag.toString()).toList(),
      lessonsData: lessons,
    );
  }
}
