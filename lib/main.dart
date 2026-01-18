import 'package:flutter/material.dart';

void main() {
  myDefaultParams();
  myFactoryConstructor();
  myInitializerConstructor();
  myMixins();
  myAssert();
  myCollections();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Основи Dart'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Пункт 1
              Text(
                '1. Оператори синтаксичного цукру (?? та ??=)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '?? — повертає праве значення, якщо ліве null. ??= — присвоює значення змінній лише якщо вона null. Зменшує кількість умовних перевірок в коді.',
              ),
              SizedBox(height: 16),

              // Пункт 2
              Text(
                '2. Лямбда-функції та замикання',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Лямбда — короткий запис функцій у вигляді (параметри) => вираз. Замикання — функція зберігає доступ до змінних із зовнішньої області видимості.',
              ),
              SizedBox(height: 16),

              // Пункт 3
              Text(
                '3. Використання параметрів за замовчуванням ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Параметру можна вказати значення за замовчуванням, якщо при виклику функції його не передали. Покращує гнучкість і скорочує кількість перевантажених функцій.'
              ),
              SizedBox(height: 16),

              // Пункт 4
              Text(
                '4.1 Різні варіанти конструкторів',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                  "Фабричний конструктор (factory) може повертати не лише нові об'єкти, а й існуючі. Дозволяє контролювати процес створення екземплярів.",
              ),
              SizedBox(height: 16),

              Text(
                '4.2 Різні варіанти конструкторів',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                  "Конструктор з ініціалізаційним списком (:) дозволяє ініціалізувати поля перед виконанням тіла конструктора.Корисно для final полів та обчислень при створенні об'єкта.",
              ),
              SizedBox(height: 16),

              // Пункт 5
              Text(
                '5. Використання міксинів',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                  'Міксини дозволяють додавати методи та властивості до класу без спадкування. Використовуються з ключовим словом with.',
              ),
              SizedBox(height: 16),

              // Пункт 6
              Text(
                '6. Використання ключового слова assert',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                  'assert використовується для перевірки умов у debug-режимі. Допомагає виявити неправильні значення під час розробки.',
              ),
              SizedBox(height: 16),

              // Пункт 7
              Text(
                '7.  Робота з різними типами колекцій',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('List — впорядкований список елементів.'),
              Text('Set — множина унікальних значень.'),
              Text('Map — структура «ключ → значення».'),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}

/// Пункт 1
void myNullOperators() {
  String? name;

  String displayName = name ?? 'Гість';

  name ??= 'Anton';

  print('displayName: $displayName');
  print('name після ??=: $name');
}

/// Пункт 2
void myLambdaAndClosure() {
  var doubleNumber = (int n) => n * 2;
  int result = doubleNumber(5);

  Function makeAdder(int x) {
    return (int y) {
      return x + y;
    };
  }

  var add5 = makeAdder(5);
  int sum = add5(3);

  print('result (doubleNumber(5)): $result');
  print('sum (add5(3)): $sum');
}

/// Пункт 3
void myDefaultParams() {
  int add(int a, [int b = 10]) {
    return a + b;
  }

  int result1 = add(5);
  int result2 = add(5, 3);

  print('add(5) = $result1');
  print('add(5, 3) = $result2');
}

/// Пункт 4.1
class User {
  String name;

  User(this.name);

  factory User.fromName(String name) {
    return User(name);
  }
}

void myFactoryConstructor() {
  User user1 = User('Anton');
  User user2 = User.fromName('Tanya');

  print('user1.name = ${user1.name}');
  print('user2.name = ${user2.name}');
}

/// Пункт 4.2
class Point {
  int x;
  int y;
  int sum;

  Point(this.x, this.y) : sum = x + y;
}

void myInitializerConstructor() {
  Point p = Point(2, 3);

  print('x = ${p.x}');
  print('y = ${p.y}');
  print('sum = ${p.sum}');
}

/// Пункт 5
mixin CanSayHello {
  void sayHello() {
    print('Привіт!');
  }
}

class Person with CanSayHello {
  String name;

  Person(this.name);
}

void myMixins() {
  Person p = Person('Anton');

  print('Імʼя: ${p.name}');
  p.sayHello();
}

/// Пункт 6
void myAssert() {
  int age = 20;

  assert(age >= 0);

  print('age = $age');
}

/// Пункт 7
void myCollections() {
  List<int> numbers = [1, 2, 3];
  numbers.add(4);

  Set<int> uniqueNumbers = {1, 2, 2, 3};

  Map<String, int> ages = {
    'Anton': 20,
    'Tanya': 18,
  };

  print('numbers: $numbers');
  print('uniqueNumbers: $uniqueNumbers');
  print('ages: $ages');
}
