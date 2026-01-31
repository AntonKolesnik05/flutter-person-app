import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int selectedIndex = 0;

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
          const Header(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: const [
                VideoCard("assets/images/preview-1.jpg", "Flutter in 100 seconds"),
                VideoCard("assets/images/preview-2.jpg", "Dart in 100 seconds"),
                VideoCard("assets/images/preview-3.jpg", "React in 100 seconds"),
                VideoCard("assets/images/preview-1.jpg", "Flutter in 100 seconds"),
                VideoCard("assets/images/preview-2.jpg", "Dart in 100 seconds"),
                VideoCard("assets/images/preview-3.jpg", "React in 100 seconds"),
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
  const Header({super.key});

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
            ],
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String image;
  final String title;

  const VideoCard(this.image, this.title, {super.key});

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
            child: Image.asset(
              image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 10),
            child: Text(
              "Fireship • 1M views",
              style: TextStyle(color: Color.fromARGB(255, 112, 112, 112)),
            ),
          ),
        ],
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: image,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
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
