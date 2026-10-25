import '../entities/course.dart';

abstract interface class LearningRepository {
  List<QuizQuestion> getQuizQuestions();

  List<ForumPost> getForumPosts();

  List<ChatMessage> getChatMessages();

  List<Certificate> getCertificates();
}
