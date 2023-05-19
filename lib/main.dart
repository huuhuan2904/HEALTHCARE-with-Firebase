import 'package:flutter/material.dart';
import 'package:project/overview_app_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'App',
    theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color.fromARGB(255, 244, 242, 242),
        accentColor: Color.fromARGB(255, 214, 194, 135),
        textTheme: const TextTheme(
          headline6: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        )),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn hình chính'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const OverViewAppScreen()));
          },
        ),
      ),
    );
  }
}
