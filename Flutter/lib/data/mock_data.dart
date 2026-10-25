import '../domain/entities/course.dart';

final List<Course> mockCourses = [
  Course(
    id: 'ai-101',
    title: 'IA pour les débutants',
    category: 'Technologie',
    instructor: 'Amina Diallo',
    description:
        'Maîtrisez les bases de l’intelligence artificielle et apprenez à créer des solutions concrètes.',
    level: 'Débutant',
    rating: 4.8,
    lessons: 12,
    durationHours: 8,
    students: 15420,
    imageUrl:
        'https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=800&q=80',
    tags: ['IA', 'Python', 'Pratique'],
    lessonsData: [
      const Lesson(
          id: 'l1',
          title: 'Introduction à l’IA',
          duration: '8 min',
          content:
              'Découvrez ce qu’est l’IA, ses domaines et ses applications.',
          isFree: true),
      const Lesson(
          id: 'l2',
          title: 'Les algorithmes essentiels',
          duration: '12 min',
          content:
              'Apprenez les fondements des modèles prédictifs et de classification.',
          isFree: false),
      const Lesson(
          id: 'l3',
          title: 'Créer votre premier modèle',
          duration: '15 min',
          content:
              'Construisez votre premier modèle avec Python et scikit-learn.',
          isFree: false),
    ],
  ),
  const Course(
    id: 'ux-design',
    title: 'UX Design moderne',
    category: 'Design',
    instructor: 'Noah Martin',
    description:
        'Développez une expérience utilisateur intuitive en suivant des méthodes modernes.',
    level: 'Intermédiaire',
    rating: 4.7,
    lessons: 10,
    durationHours: 6,
    students: 9850,
    imageUrl:
        'https://images.unsplash.com/photo-1516321497487-e288fb19713f?auto=format&fit=crop&w=800&q=80',
    tags: ['UI/UX', 'Figma', 'Design'],
    lessonsData: [
      const Lesson(
          id: 'l4',
          title: 'Comprendre les personas',
          duration: '10 min',
          content:
              'Mettez au point une compréhension claire de vos utilisateurs.',
          isFree: true),
      const Lesson(
          id: 'l5',
          title: 'Wireframes et prototypes',
          duration: '14 min',
          content: 'Réalisez rapidement des maquettes et des parcours.',
          isFree: false),
    ],
  ),
  const Course(
    id: 'finance',
    title: 'Finance personnelle',
    category: 'Business',
    instructor: 'Sarah K.',
    description:
        'Apprenez à gérer votre budget, investir et construire des habitudes financières solides.',
    level: 'Tous niveaux',
    rating: 4.9,
    lessons: 15,
    durationHours: 9,
    students: 22100,
    imageUrl:
        'https://images.unsplash.com/photo-1554224155-6726b3ff858f?auto=format&fit=crop&w=800&q=80',
    tags: ['Budget', 'Investissement', 'Habitudes'],
    lessonsData: [
      const Lesson(
          id: 'l6',
          title: 'Créer un budget',
          duration: '9 min',
          content: 'Analysez vos dépenses et établissez votre budget.',
          isFree: true),
      const Lesson(
          id: 'l7',
          title: 'Épargner intelligemment',
          duration: '11 min',
          content: 'Mettez en place des règles d’épargne simples et efficaces.',
          isFree: false),
    ],
  ),
];

final List<QuizQuestion> quizQuestions = [
  const QuizQuestion(
      question: 'Quel est l’objectif d’un quiz ?',
      options: [
        'Évaluer les connaissances',
        'Supprimer un cours',
        'Changer de thème'
      ],
      correctIndex: 0),
  const QuizQuestion(
      question: 'Quelle action montre une progression ?',
      options: [
        'Terminer une leçon',
        'Éteindre l’application',
        'Supprimer un favori'
      ],
      correctIndex: 0),
  const QuizQuestion(
      question: 'Quelle fonctionnalité aide à retrouver un cours ?',
      options: ['Recherche', 'Mode avion', 'Notifications'],
      correctIndex: 0),
];

final List<ForumPost> forumPosts = [
  const ForumPost(
      author: 'Maya',
      title: 'Aide pour le module IA',
      content: 'Je bloque sur la première pratique, quelqu’un peut m’aider ?',
      category: 'IA',
      replies: 8),
  const ForumPost(
      author: 'Khaled',
      title: 'Conseils pour un bon portfolio',
      content: 'Quels outils recommandez-vous pour créer un portfolio ?',
      category: 'Design',
      replies: 4),
];

final List<ChatMessage> chatMessages = [
  const ChatMessage(
      author: 'Coach Amina',
      text: 'Bonjour ! Prêt pour votre séance du soir ?',
      isMe: false),
  const ChatMessage(
      author: 'Moi', text: 'Oui, je veux terminer mon quiz.', isMe: true),
];

final List<Certificate> certificates = [
  const Certificate(
      title: 'Certificat IA Débutant',
      issuedAt: 'Mai 2026',
      description: 'Validation de la réussite du parcours IA pour débutants.'),
  const Certificate(
      title: 'Certificat UX Design',
      issuedAt: 'Juin 2026',
      description:
          'Mise en valeur des compétences UX avec un projet pratique.'),
];
