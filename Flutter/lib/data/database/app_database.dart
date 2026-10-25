abstract class AppDatabase {
  Future<void> init();
}

class LocalDatabase implements AppDatabase {
  @override
  Future<void> init() async {
    // À remplacer par Floor/Hive/Drift selon le besoin du backend.
  }
}
