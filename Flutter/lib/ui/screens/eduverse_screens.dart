import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/course.dart';
import '../state/eduverse_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    final featuredCourses = state.courses.take(2).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('EduVerse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const NotificationsScreen(),
                transitionDuration: const Duration(milliseconds: 250),
                transitionsBuilder: (_, animation, __, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => state.logout(),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: state.courses.isEmpty
            ? Center(
                key: const ValueKey('home-empty-state'),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBEAFE),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          size: 54,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Aucun cours disponible pour le moment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Les prochains parcours apparaîtront ici dès qu’ils seront ajoutés.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, height: 1.4),
                      ),
                    ],
                  ),
                ),
              )
            : ListView(
                key: const ValueKey('home-list'),
                padding: const EdgeInsets.all(20),
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF2563EB)],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bienvenue de retour',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Continuez votre apprentissage',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          children: [
                            _QuickAction(
                              label: 'Quiz',
                              icon: Icons.quiz_rounded,
                              onTap: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => const QuizScreen(),
                                  transitionDuration: const Duration(milliseconds: 250),
                                  transitionsBuilder: (_, animation, __, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                                ),
                              ),
                            ),
                            _QuickAction(
                              label: 'Exercices',
                              icon: Icons.task_alt_rounded,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ExercisesScreen(),
                                ),
                              ),
                            ),
                            _QuickAction(
                              label: 'Favoris',
                              icon: Icons.favorite_rounded,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FavoritesScreen(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Cours à la une',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...featuredCourses.map((course) => _CourseCard(course: course)),
                  const SizedBox(height: 20),
                  const Text(
                    'Suivi rapide',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const _StatTile(title: 'Cours suivis', value: '4'),
                  const _StatTile(title: 'Heures apprises', value: '18h'),
                  const _StatTile(title: 'Badges', value: '3'),
                ],
              ),
      ),
    );
  }
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final query = controller.text.toLowerCase();
    final filtered = context.read<EduVerseState>().courses.where((course) {
      final haystack =
          '${course.title} ${course.category} ${course.tags.join(' ')}'
              .toLowerCase();
      return haystack.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Rechercher un cours',
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: filtered.isEmpty
                    ? Center(
                        key: const ValueKey('catalog-empty'),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              size: 52,
                              color: Color(0xFF93C5FD),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Aucun cours trouvé',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              query.isEmpty
                                  ? 'Commencez par ajouter des parcours à votre catalogue.'
                                  : 'Essayez un autre mot-clé pour retrouver un cours.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        key: const ValueKey('catalog-list'),
                        children: filtered
                            .map((course) => _CourseCard(course: course))
                            .toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    final isFavorite = state.isFavorite(course);

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Hero(
            tag: 'course-${course.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                course.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: IconButton(
                  key: ValueKey(isFavorite),
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    context.read<EduVerseState>().toggleFavorite(course);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isFavorite
                              ? '${course.title} retiré de vos favoris'
                              : '${course.title} ajouté aux favoris',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Text(
            course.description,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: course.tags.map((tag) => Chip(label: Text(tag))).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _InfoPill(icon: Icons.person_rounded, label: course.instructor),
              const SizedBox(width: 10),
              _InfoPill(icon: Icons.star_rounded, label: '${course.rating}'),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Leçons',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...course.lessonsData.map(
            (lesson) => ListTile(
              title: Text(lesson.title),
              subtitle: Text(lesson.duration),
              trailing: const Icon(
                Icons.play_circle_fill_rounded,
                color: Color(0xFF2563EB),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonScreen(course: course, lesson: lesson),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(course: course),
                    ),
                  ),
                  icon: const Icon(Icons.quiz_rounded),
                  label: const Text('Quiz'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExercisesScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.task_alt_rounded),
                  label: const Text('Exercices'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LessonScreen extends StatelessWidget {
  final Course course;
  final Lesson lesson;
  const LessonScreen({super.key, required this.course, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    final completed = state.completedLessons[lesson.id] == true;

    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(lesson.duration, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(lesson.content),
            ),
            const SizedBox(height: 20),
            if (!completed)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<EduVerseState>().markLessonCompleted(lesson.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Leçon marquée comme terminée')),
                    );
                  },
                  icon: const Icon(Icons.check_circle_rounded),
                  label: const Text('Marquer comme terminé'),
                ),
              )
            else
              const Chip(label: Text('Leçon terminée')),
          ],
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Progression')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Votre avancée',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.insights_rounded,
                  size: 48,
                  color: Color(0xFF2563EB),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(state.progressFor(state.courses.first) * 100).toInt()}% complété',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Continuez pour atteindre votre objectif du mois'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...state.courses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(course.title),
                      Text('${(state.progressFor(course) * 100).toInt()}%'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: state.progressFor(course),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final Course? course;
  const QuizScreen({super.key, this.course});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool completed = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Quel est l’objectif principal d’un quiz ?',
      'options': [
        'Évaluer les connaissances',
        'Changer de thème',
        'Supprimer des cours'
      ],
      'answer': 0
    },
    {
      'question': 'Quelle action montre une progression ?',
      'options': [
        'Terminer une leçon',
        'Supprimer un cours',
        'Fermer l’application'
      ],
      'answer': 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (completed) {
      return Scaffold(
        appBar: AppBar(title: const Text('Résultat du quiz')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 60,
                color: Color(0xFF2563EB),
              ),
              const SizedBox(height: 12),
              Text(
                'Score : $score / ${questions.length}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Retour'),
              ),
            ],
          ),
        ),
      );
    }

    final question = questions[currentQuestion];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.course?.title ?? 'Quiz rapide',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(question['question'], style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ...List.generate(question['options'].length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    if (index == question['answer']) score++;
                    if (currentQuestion < questions.length - 1) {
                      setState(() => currentQuestion++);
                    } else {
                      setState(() => completed = true);
                    }
                  },
                  child: Text(question['options'][index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    final tasks = [
      'Créer un plan d’apprentissage',
      'Répondre à 3 questions',
      'Réviser une leçon',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Exercices')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          final done = state.exercisesDone.contains(task);
          return Card(
            child: ListTile(
              title: Text(task),
              trailing: done
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.radio_button_unchecked),
              onTap: () {
                context.read<EduVerseState>().completeExercise(task);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$task validé')));
              },
            ),
          );
        },
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: state.favorites.isEmpty
          ? const Center(child: Text('Aucun favori pour le moment'))
          : ListView(
              children: state.favorites.map((course) => _CourseCard(course: course)).toList(),
            ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.notifications.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.notifications_active_rounded),
              ),
              title: Text(state.notifications[index]),
            ),
          );
        },
      ),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Communauté')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _CommunityTile(
            title: 'Forum',
            subtitle: 'Questions, réponses et discussions',
            icon: Icons.forum_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ForumScreen()),
            ),
          ),
          _CommunityTile(
            title: 'Chat',
            subtitle: 'Discutez avec votre coach',
            icon: Icons.chat_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            ),
          ),
          _CommunityTile(
            title: 'Tableau de bord formateur',
            subtitle: 'Créer et piloter vos cours',
            icon: Icons.dashboard_customize_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TeacherDashboardScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Forum')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.forumItems.length,
        itemBuilder: (context, index) {
          final post = state.forumItems[index];
          return Card(
            child: ListTile(
              title: Text(post.title),
              subtitle: Text(
                '${post.author} • ${post.category} • ${post.replies} réponses\n${post.content}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.chatItems.length,
              itemBuilder: (context, index) {
                final msg = state.chatItems[index];
                return Align(
                  alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.isMe ? const Color(0xFF2563EB) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Écrivez un message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      context
                          .read<EduVerseState>()
                          .sendMessage(controller.text.trim());
                      controller.clear();
                    }
                  },
                  child: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tableau de bord formateur')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Vue d’ensemble',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DashCard(
                  title: 'Cours créés',
                  value: '3',
                  icon: Icons.menu_book_rounded,
                ),
              ),
              Expanded(
                child: _DashCard(
                  title: 'Étudiants',
                  value: '1.2k',
                  icon: Icons.people_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DashCard(
                  title: 'Réponses',
                  value: '84',
                  icon: Icons.forum_rounded,
                ),
              ),
              Expanded(
                child: _DashCard(
                  title: 'Note moyenne',
                  value: '4.8',
                  icon: Icons.star_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Créer un cours',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const _CreateCourseCard(),
        ],
      ),
    );
  }
}

class _CreateCourseCard extends StatefulWidget {
  const _CreateCourseCard();

  @override
  State<_CreateCourseCard> createState() => _CreateCourseCardState();
}

class _CreateCourseCardState extends State<_CreateCourseCard> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoController = TextEditingController();
  final pdfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titre du cours',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: videoController,
              decoration: const InputDecoration(
                labelText: 'Lien vidéo / fichier vidéo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: pdfController,
              decoration: const InputDecoration(
                labelText: 'Lien PDF / fichier PDF',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty) return;

                  final course = Course(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    category: 'Nouveau',
                    instructor: 'Vous',
                    description: descriptionController.text.isEmpty
                        ? 'Nouveau cours ajouté depuis l’interface'
                        : descriptionController.text,
                    level: 'Intermédiaire',
                    rating: 4.7,
                    lessons: 4,
                    durationHours: 3,
                    students: 0,
                    imageUrl:
                        'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=600&q=80',
                    tags: const ['Nouveau', 'Créé'],
                    lessonsData: [
                      const Lesson(
                        id: 'new-1',
                        title: 'Introduction',
                        duration: '10 min',
                        content: 'Bienvenue dans votre nouveau cours.',
                        isFree: true,
                      ),
                    ],
                  );

                  context.read<EduVerseState>().addCourse(course);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cours créé avec succès')),
                  );
                },
                child: const Text('Créer le cours'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Certificats')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: state.earnedCertificates.length,
        itemBuilder: (context, index) {
          final cert = state.earnedCertificates[index];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.workspace_premium_rounded),
              ),
              title: Text(cert.title),
              subtitle: Text('${cert.issuedAt}\n${cert.description}'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 40,
            child: Icon(Icons.person_rounded, size: 34),
          ),
          const SizedBox(height: 16),
          const Text(
            'Moussa Diop',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Étudiant curieux',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            value: state.offlineMode,
            onChanged: (_) => context.read<EduVerseState>().toggleOfflineMode(),
            title: const Text('Mode hors ligne'),
            subtitle: const Text('Accédez aux contenus sans connexion'),
            secondary: const Icon(Icons.offline_pin_rounded),
          ),
          ListTile(
            title: const Text('Mes certificats'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CertificatesScreen()),
            ),
          ),
          ListTile(
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
          ),
          ListTile(
            title: const Text('Tableau de bord formateur'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TeacherDashboardScreen()),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.read<EduVerseState>().logout(),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;
  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EduVerseState>();
    final isFavorite = state.isFavorite(course);

    return Hero(
      tag: 'course-${course.id}',
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => CourseDetailScreen(course: course),
              transitionDuration: const Duration(milliseconds: 260),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: IconButton(
                        key: ValueKey(isFavorite),
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          context.read<EduVerseState>().toggleFavorite(course);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavorite
                                    ? '${course.title} retiré de vos favoris'
                                    : '${course.title} ajouté aux favoris',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  course.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text(course.category)),
                    Chip(label: Text('${course.lessons} leçons')),
                    Chip(label: Text('${course.durationHours}h')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommunityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _CommunityTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _QuickAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _DashCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _DashCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28, color: const Color(0xFF2563EB)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String title;
  final String value;
  const _StatTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
