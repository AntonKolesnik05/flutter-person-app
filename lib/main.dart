import 'package:flutter/material.dart';

void main() {
  Person person = Person(firstName: "Anton", lastName: "Kolisnyk");

  runApp(MyApp(person: person));
}

class Person {
  String _firstName;
  String _lastName;


  Person({required String firstName, required String lastName})
      : _firstName = firstName,
        _lastName = lastName;

  String get firstName {
    return _firstName;
  }

  String get lastName {
    return _lastName;
  }

  set firstName(String value) {
    _firstName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  String get fullName {
    return _firstName + " " + _lastName;
  }
}

class MyApp extends StatelessWidget {
  final Person person;

  const MyApp({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My first flutter project"),
        ),
        body: Center(
          child: Text(
            person.fullName,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
