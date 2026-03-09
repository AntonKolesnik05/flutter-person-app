import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/live_bar_chart.dart';

import '../models/youtube_model.dart';
import 'hero_image_page.dart';

class VideoDetailsPage extends StatefulWidget {
  final String image;
  final String title;
  final String meta;
  final String channelId;

  const VideoDetailsPage({
    super.key,
    required this.image,
    required this.title,
    required this.meta,
    required this.channelId,
  });

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<YoutubeModel>();
    final isSubscribed = model.isSubscribed(widget.channelId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
        actions: [
          IconButton(
            tooltip: 'Open preview',
            icon: const Icon(Icons.open_in_full),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HeroImagePage(image: widget.image),
                ),
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.image,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            widget.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(widget.meta, style: Theme.of(context).textTheme.bodyMedium),

          const SizedBox(height: 16),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => liked = !liked),
                icon: Icon(liked ? Icons.thumb_up : Icons.thumb_up_outlined),
                label: Text(liked ? 'Liked' : 'Like'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: isSubscribed
                    ? null
                    : () => model.subscribe(widget.channelId),
                child: Text(isSubscribed ? 'Subscribed' : 'Subscribe'),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const LiveBarChart(),

          const SizedBox(height: 18),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Demo (return value)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('Current liked state: $liked'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, liked);
                    },
                    child: const Text('Back with result'),
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
