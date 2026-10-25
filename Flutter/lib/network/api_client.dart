class ApiClient {
  ApiClient({this.baseUrl = 'https://api.example.com'});

  final String baseUrl;

  Future<Map<String, dynamic>> get(String path) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return {
      'path': path,
      'baseUrl': baseUrl,
      'items': <Map<String, dynamic>>[],
    };
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return {'path': path, 'baseUrl': baseUrl, 'body': body};
  }
}
