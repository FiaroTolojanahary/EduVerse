class AppRouter {
  static const String auth = '/auth';
  static const String home = '/home';
  static const String catalog = '/catalog';
  static const String progress = '/progress';
  static const String community = '/community';
  static const String profile = '/profile';

  static Map<String, String> routes() {
    return {
      auth: '/auth',
      home: '/home',
      catalog: '/catalog',
      progress: '/progress',
      community: '/community',
      profile: '/profile',
    };
  }
}
