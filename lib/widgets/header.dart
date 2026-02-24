import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/youtube_model.dart';
import 'subscriptions_badge.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              Image.asset("assets/images/logo.png", width: 40),
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
          Consumer<YoutubeModel>(
            builder: (context, model, child) {
              return SubscriptionsBadge(count: model.subscriptionsCount);
            },
          ),
          Consumer<YoutubeModel>(
            builder: (context, model, child) {
              return IconButton(
                icon: Icon(
                  model.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  model.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
