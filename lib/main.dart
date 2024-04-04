import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/models/doctor.dart';
import 'package:project/screens/authenticate/authenticate.dart';
import 'package:project/screens/dat_lich_details_screen.dart';
import 'package:project/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()
      //   MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'App',
      //   theme: ThemeData(
      //       primarySwatch: Colors.purple,
      //       scaffoldBackgroundColor: Color.fromARGB(255, 244, 242, 242),
      //       accentColor: Color.fromARGB(255, 214, 194, 135),
      //       textTheme: const TextTheme(
      //         headline6: TextStyle(
      //             fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      //       )),
      //   home: MyApp(),
      // )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<MyUser?>.value(
    //   catchError: (_, __) {},
    //   value: AuthService().user,
    //   initialData: null,
    //   child: const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Authenticate(),
    //   ),
    // );
    return MultiProvider(
      providers: [
        StreamProvider<MyUser?>.value(
          catchError: (_, __) {},
          value: AuthService().user,
          initialData: null,
          // child: const MaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   home: Authenticate(),
          // )
        ),
        StreamProvider<MyDoctor?>.value(
          catchError: (_, __) {},
          value: AuthServiceDoctor().doctor,
          initialData: null,
          // child: const MaterialApp(
          //   home: Authenticate(),
          // )
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Authenticate(),
      ),
    );
  }
}
