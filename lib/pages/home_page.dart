import 'package:flutter/material.dart';

import '../models/video_data.dart';
import '../widgets/header.dart';
import '../widgets/video_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/youtube_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<VideoData> videos = const [
    VideoData(
      image: "assets/images/preview-1.jpg",
      title: "Flutter in 100 seconds",
      meta: "Fireship • 1M views",
    ),
    VideoData(
      image: "assets/images/preview-5.jpg",
      title: "Me at the zoo",
      meta: "jawed • 381M views",
    ),
    VideoData(
      image: "assets/images/preview-6.jpg",
      title: "1 A.M Study Session 📚",
      meta: "Lofi Girl • 129M views",
    ),
    VideoData(
      image: "assets/images/preview-4.jpg",
      title: "Try Not To Laugh 🤣",
      meta: "Funny Moments • 97K views",
    ),
    VideoData(
      image: "assets/images/preview-2.jpg",
      title: "Dart in 100 seconds",
      meta: "Fireship • 2M views",
    ),
    VideoData(
      image: "assets/images/preview-3.jpg",
      title: "React in 100 seconds",
      meta: "Fireship • 937K views",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: const YoutubeDrawer(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () => print("Upload video"),
      ),

      body: Column(
        children: [
          const Header(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                for (final v in videos)
                  VideoCard(
                    image: v.image,
                    title: v.title,
                    meta: v.meta,
                    channelId: v.title,
                  ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
      ),
    );
  }
}
