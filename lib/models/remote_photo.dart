import 'dart:convert';

class RemotePhoto {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const RemotePhoto({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory RemotePhoto.fromJson(Map<String, dynamic> json) {
    return RemotePhoto(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

List<RemotePhoto> parseJson(String responseBody) {
  final List<dynamic> jsonList = jsonDecode(responseBody);

  final List<RemotePhoto> result = [];
  for (final item in jsonList) {
    result.add(RemotePhoto.fromJson(item as Map<String, dynamic>));
  }
  return result;
}