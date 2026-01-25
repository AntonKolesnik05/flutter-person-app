import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Хедер
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Логотип
                Image.asset('assets/images/logo.png', width: 45, height: 45),

                SizedBox(width: 8),

                // Назва сайту (розтягується)
                Expanded(
                  child: Text(
                    'YouTube',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: "Bebas",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(121, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  iconSize: 30,
                  onPressed: () {
                    print('Пошук натиснули');
                  },
                ),

                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  iconSize: 30,
                  onPressed: () {
                    print('Сповіщення натиснули');
                  },
                ),

                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  iconSize: 30,
                  onPressed: () {
                    print('Меню натиснули');
                  },
                ),
              ],
            ),
          ),
          //відео 1
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/preview-1.jpg',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Flutter in 100 seconds',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Fireship • 931K переглядів • 5 років назад',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //відео 2
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Image.asset(
                    'assets/images/preview-2.jpg',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Dart in 100 seconds',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Fireship • 1M переглядів • 4 роки назад',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //відео 3
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/preview-3.jpg',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'React in 100 seconds',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Fireship • 1.6M переглядів • 5 років назад',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
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
