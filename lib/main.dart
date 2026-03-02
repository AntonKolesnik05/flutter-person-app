import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/youtube_model.dart';
import 'pages/main_shell_page.dart';
import 'pages/async_http_demo_page.dart';

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
          themeMode: model.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

          routes: {
            '/': (context) => const MainShellPage(),
            '/demo': (context) => const AsyncHttpDemoPage(),
          },

          initialRoute: '/',
        );
      },
    );
  }
}