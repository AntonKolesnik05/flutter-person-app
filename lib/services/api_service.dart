import 'package:http/http.dart' as http;

import '../models/remote_photo.dart';

class ApiService {
  Future<List<RemotePhoto>> fetchPhotos({int limit = 5}) async {
    final uri = Uri.parse(
      'https://jsonplaceholder.typicode.com/photos?_limit=$limit',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseJson(response.body);
    }

    throw Exception('HTTP error: ${response.statusCode}');
  }
}