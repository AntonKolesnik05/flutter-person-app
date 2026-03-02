import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/youtube_model.dart';
import '../pages/video_details_page.dart';
import 'like_button.dart';

class VideoCard extends StatelessWidget {
  final String image;
  final String title;
  final String meta;
  final String channelId;

  const VideoCard({
    required this.image,
    required this.title,
    required this.meta,
    required this.channelId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<YoutubeModel>();
    final isSubscribed = model.isSubscribed(channelId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final likedResult = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (_) => VideoDetailsPage(
                  image: image,
                  title: title,
                  meta: meta,
                  channelId: channelId,
                ),
              ),
            );
            if (likedResult != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    likedResult
                        ? 'Повернувся з деталей: liked = true'
                        : 'Повернувся з деталей: liked = false',
                  ),
                ),
              );
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        Text(meta),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const LikeButton(),

            ElevatedButton(
              onPressed: isSubscribed ? null : () => model.subscribe(channelId),
              child: Text(isSubscribed ? "Subscribed" : "Subscribe"),
            ),
          ],
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}