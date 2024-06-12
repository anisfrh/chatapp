import 'dart:io';

import 'package:chat_app2/screen/auth_screen.dart';
import 'package:chat_app2/screen/chat_screen.dart';
import 'package:chat_app2/screen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyC5z8c-1xdFtsew7G6_BBE1j-dTId4yLi8',
          appId: '1:448635918929:android:74322bbf3fbf5e9ed93670',
          messagingSenderId: '448635918929',
          projectId: 'chatlagii',
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: snapshot.connectionState != ConnectionState.done
            ? const SplashScreen()
            : StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }
                  if (userSnapshot.hasData) {
                    return const ChatScreen();
                  }
                  return const AuthScreen();
                })
          );
        }
    );
  }
}


