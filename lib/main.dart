// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shopping_app/views/screens/authentication_screens/register_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Platform.isAndroid
//       ? await Firebase.initializeApp(
//           options: FirebaseOptions(
//               apiKey: "AIzaSyBylck1h-mkjrvqrZQa9sZPjn4IJY1R9I4",
//               appId: "1:532733769418:android:2036d36d9b29ab0ff6e633",
//               messagingSenderId: "532733769418",
//               projectId: "shopping-app-d6991",
//               storageBucket: "gs://shopping-app-d6991.firebasestorage.app"),
//         )
//       : await Firebase.initializeApp();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(statusBarColor: Colors.transparent),
//     );

//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: RegisterScreen(),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controller/category_controller.dart';
import 'package:shopping_app/views/screens/authentication_screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only once, Firebase will use google-services.json automatically
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen(),
        // home: CartScreen(),
        initialBinding: BindingsBuilder(() {
          Get.put<CategoryController>(CategoryController());
        }));
  }
}
