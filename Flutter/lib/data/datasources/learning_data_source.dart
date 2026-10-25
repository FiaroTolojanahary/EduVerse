import '../../domain/entities/course.dart';
import '../mock_data.dart';

abstract interface class LearningDataSource {
  List<QuizQuestion> getQuizQuestions();

  List<ForumPost> getForumPosts();

  List<ChatMessage> getChatMessages();

  List<Certificate> getCertificates();
}

class InMemoryLearningDataSource implements LearningDataSource {
  @override
  List<QuizQuestion> getQuizQuestions() => List.unmodifiable(quizQuestions);

  @override
  List<ForumPost> getForumPosts() => List.unmodifiable(forumPosts);

  @override
  List<ChatMessage> getChatMessages() => List.unmodifiable(chatMessages);

  @override
  List<Certificate> getCertificates() => List.unmodifiable(certificates);
}

// TODO: replace with RemoteLearningDataSource when the backend is ready.
// final class RemoteLearningDataSource implements LearningDataSource {
//   @override
//   List<QuizQuestion> getQuizQuestions() => throw UnimplementedError();
//
//   @override
//   List<ForumPost> getForumPosts() => throw UnimplementedError();
//
//   @override
//   List<ChatMessage> getChatMessages() => throw UnimplementedError();
//
//   @override
//   List<Certificate> getCertificates() => throw UnimplementedError();
// }
