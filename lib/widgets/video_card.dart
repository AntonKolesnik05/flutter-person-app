import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/youtube_model.dart';
import '../pages/hero_image_page.dart';
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
    final model = Provider.of<YoutubeModel>(context);

    final isSubscribed = model.isSubscribed(channelId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HeroImagePage(image: image),
            ),
          ),
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
              onPressed: isSubscribed
                  ? null
                  : () => model.subscribe(channelId),
              child: Text(
                isSubscribed ? "Subscribed" : "Subscribe",
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}
