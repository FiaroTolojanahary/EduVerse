class Course {
  final String id;
  final String title;
  final String category;
  final String instructor;
  final String description;
  final String level;
  final double rating;
  final int lessons;
  final int durationHours;
  final int students;
  final String imageUrl;
  final List<String> tags;
  final List<Lesson> lessonsData;

  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.instructor,
    required this.description,
    required this.level,
    required this.rating,
    required this.lessons,
    required this.durationHours,
    required this.students,
    required this.imageUrl,
    required this.tags,
    required this.lessonsData,
  });
}

class Lesson {
  final String id;
  final String title;
  final String duration;
  final String content;
  final bool isFree;

  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.content,
    required this.isFree,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class ForumPost {
  final String author;
  final String title;
  final String content;
  final String category;
  final int replies;

  const ForumPost({
    required this.author,
    required this.title,
    required this.content,
    required this.category,
    required this.replies,
  });
}

class ChatMessage {
  final String author;
  final String text;
  final bool isMe;

  const ChatMessage({
    required this.author,
    required this.text,
    required this.isMe,
  });
}

class Certificate {
  final String title;
  final String issuedAt;
  final String description;

  const Certificate({
    required this.title,
    required this.issuedAt,
    required this.description,
  });
}
