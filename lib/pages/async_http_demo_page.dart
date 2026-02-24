import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/youtube_model.dart';

class AsyncHttpDemoPage extends StatefulWidget {
  const AsyncHttpDemoPage({super.key});

  @override
  State<AsyncHttpDemoPage> createState() => _AsyncHttpDemoPageState();
}

class _AsyncHttpDemoPageState extends State<AsyncHttpDemoPage> {
  List<RemotePhoto> remotePhotos = [];
  bool isLoadingRemote = false;
  String httpMessage = 'HTTP запит ще не виконувався';

  List<RemotePhoto> parseJson(String responseBody) {
    final List<dynamic> jsonList = jsonDecode(responseBody);
    final List<RemotePhoto> result = [];

    for (final item in jsonList) {
      result.add(RemotePhoto.fromJson(item));
    }

    return result;
  }

  Future<void> fetchRemotePhotos() async {
    setState(() {
      isLoadingRemote = true;
      httpMessage = 'Виконується HTTP запит...';
    });

    try {
      final uri = Uri.parse(
        'https://jsonplaceholder.typicode.com/photos?_limit=5',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final parsed = parseJson(response.body);

        setState(() {
          remotePhotos = parsed;
          httpMessage = 'HTTP успіх: отримано ${parsed.length} записів';
        });
      } else {
        setState(() {
          httpMessage = 'HTTP помилка: statusCode = ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        httpMessage = 'HTTP виняток: $e';
      });
    } finally {
      setState(() {
        isLoadingRemote = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<YoutubeModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Async / HTTP Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Демонстрація',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),

                  Text(
                    '2) Асинхронні функції',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<YoutubeModel>().demoAsyncWithThen();
                        },
                        child: const Text('.then()'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await context.read<YoutubeModel>().demoAsyncWithAwait();
                        },
                        child: const Text('await'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Async result:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(model.asyncMessage),

                  const Divider(height: 24),

                  Text(
                    '3) HTTP запит + 3.1) parseJson()',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),

                  ElevatedButton(
                    onPressed: isLoadingRemote ? null : fetchRemotePhotos,
                    child: const Text('Виконати HTTP запит'),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'HTTP result:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(httpMessage),

                  if (isLoadingRemote) ...[
                    const SizedBox(height: 10),
                    const LinearProgressIndicator(),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          if (remotePhotos.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Дані, отримані після parseJson()',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    for (final photo in remotePhotos)
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(photo.thumbnailUrl),
                        ),
                        title: Text(
                          photo.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text('ID: ${photo.id}'),
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