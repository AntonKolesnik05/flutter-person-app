import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}

class VideoData {
  final String image;
  final String title;
  final String meta;

  const VideoData({
    required this.image,
    required this.title,
    required this.meta,
  });
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int selectedIndex = 0;

  final Set<String> subscribedChannels = {};

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
      title: "1 A.M Study Session 📚 [lofi hip hop]",
      meta: "Lofi Girl • 129M views",
    ),
    VideoData(
      image: "assets/images/preview-4.jpg",
      title: "Try Not To Laugh 🤣 2026 #66",
      meta: "FMW - Funny Moments • 97K views",
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


  void subscribeTo(String channelId) {
    setState(() {
      subscribedChannels.add(channelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: 75,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset('assets/images/logo.png', width: 40),
                      const SizedBox(width: 8),
                      const Text(
                        "YouTube",
                        style: TextStyle(
                          fontFamily: "Bebas",
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(leading: const Icon(Icons.home), title: const Text("Home"), onTap: () {}),
                ListTile(leading: const Icon(Icons.video_collection_rounded), title: const Text("Shorts"), onTap: () {}),
                ListTile(leading: const Icon(Icons.history), title: const Text("History"), onTap: () {}),
                ListTile(leading: const Icon(Icons.playlist_play), title: const Text("Playlists"), onTap: () {}),
                ListTile(leading: const Icon(Icons.watch_later), title: const Text("Watch later"), onTap: () {}),
                ListTile(leading: const Icon(Icons.video_camera_front), title: const Text("Your videos"), onTap: () {}),
                ListTile(leading: const Icon(Icons.download), title: const Text("Downloads"), onTap: () {}),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () => print("Upload video"),
      ),

      body: Column(
        children: [
          Header(subscriptionsCount: subscribedChannels.length),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                for (final v in videos)
                  VideoCard(
                    image: v.image,
                    title: v.title,
                    meta: v.meta,

                    channelId: v.title,

                    isSubscribed: subscribedChannels.contains(v.title),

                    onSubscribe: subscribeTo,
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

class Header extends StatelessWidget {
  final int subscriptionsCount;

  const Header({required this.subscriptionsCount, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              Image.asset('assets/images/logo.png', width: 40),
              const SizedBox(width: 8),
              const Text(
                "YouTube",
                style: TextStyle(
                  fontFamily: "Bebas",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Row(
            children: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              SubscriptionsBadge(count: subscriptionsCount),
            ],
          ),
        ],
      ),
    );
  }
}

class SubscriptionsBadge extends StatelessWidget {
  final int count;

  const SubscriptionsBadge({required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(Icons.subscriptions_outlined),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Subscribers: $count")),
            );
          },
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                "$count",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class VideoCard extends StatelessWidget {
  final String image;
  final String title;
  final String meta;

  final String channelId;
  final bool isSubscribed;

  final void Function(String channelId) onSubscribe;

  const VideoCard({
    required this.image,
    required this.title,
    required this.meta,
    required this.channelId,
    required this.isSubscribed,
    required this.onSubscribe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HeroImagePage(image: image)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: image,
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8, top: 2),
            child: Text(
              meta,
              style: const TextStyle(color: Color.fromARGB(255, 112, 112, 112)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LikeButton(),

                ElevatedButton(
                  onPressed: isSubscribed ? null : () => onSubscribe(channelId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSubscribed ? Colors.grey : Colors.red,
                  ),
                  child: Text(
                    isSubscribed ? "Subscribed" : "Subscribe",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        setState(() {
          liked = !liked;
        });
      },
      icon: Icon(
        liked ? Icons.thumb_up : Icons.thumb_up_outlined,
        color: liked ? Colors.red : Colors.black,
      ),
      label: Text(
        liked ? "Liked" : "Like",
        style: TextStyle(color: liked ? Colors.red : Colors.black),
      ),
    );
  }
}

class HeroImagePage extends StatelessWidget {
  final String image;

  const HeroImagePage({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: image,
            child: Image.asset(image, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({required this.selectedIndex, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(icon: Icons.home, index: 0, selectedIndex: selectedIndex, onTap: onTap),
          NavItem(icon: Icons.video_library_rounded, index: 1, selectedIndex: selectedIndex, onTap: onTap),
          NavItem(icon: Icons.account_circle_outlined, index: 2, selectedIndex: selectedIndex, onTap: onTap),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const NavItem({required this.icon, required this.index, required this.selectedIndex, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.red : Colors.black,
          size: isSelected ? 30 : 24,
        ),
      ),
    );
  }
}
