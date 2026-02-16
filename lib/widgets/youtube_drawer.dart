import 'package:flutter/material.dart';

class YoutubeDrawer extends StatelessWidget {
  const YoutubeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
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

              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.video_collection_rounded),
                title: const Text("Shorts"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("History"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.playlist_play),
                title: const Text("Playlists"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.watch_later),
                title: const Text("Watch later"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.video_camera_front),
                title: const Text("Your videos"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text("Downloads"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
