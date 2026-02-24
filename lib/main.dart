import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/youtube_model.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => YoutubeModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<YoutubeModel>(
      builder: (context, model, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),

          themeMode:
              model.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

          home: const HomePage(),
        );
      },
    );
  }
}