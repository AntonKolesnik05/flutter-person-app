import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/remote_photo.dart';
import '../models/youtube_model.dart';
import '../services/api_service.dart';

class AsyncHttpDemoPage extends StatefulWidget {
  const AsyncHttpDemoPage({super.key});

  @override
  State<AsyncHttpDemoPage> createState() => _AsyncHttpDemoPageState();
}

class _AsyncHttpDemoPageState extends State<AsyncHttpDemoPage> {
  final ApiService _api = ApiService();

  List<RemotePhoto> remotePhotos = [];
  bool isLoadingRemote = false;
  String httpMessage = 'HTTP запит ще не виконувався';

  Future<void> fetchRemotePhotos() async {
    setState(() {
      isLoadingRemote = true;
      httpMessage = 'Виконується HTTP запит...';
    });

    try {
      final parsed = await _api.fetchPhotos(limit: 5);

      setState(() {
        remotePhotos = parsed;
        httpMessage = 'HTTP успіх: отримано ${parsed.length} записів';
      });
    } catch (e) {
      setState(() {
        httpMessage = 'HTTP помилка: $e';
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
                    'Лабораторна демонстрація',
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
                          // 2.1) .then()
                          context.read<YoutubeModel>().demoAsyncWithThen();
                        },
                        child: const Text('.then()'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // 2.2) await
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
                      'Дані після parseJson()',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),

                    for (final photo in remotePhotos)
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            photo.thumbnailUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.broken_image),
                              );
                            },
                          ),
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