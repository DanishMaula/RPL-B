import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/provider/login_provider.dart';
import 'package:rpl_b/provider/upload_photo_provider.dart';
import 'package:rpl_b/ui/auth/login_page.dart';
import 'package:rpl_b/ui/home_page.dart';
import 'package:rpl_b/ui/see_all_page.dart';
import 'package:rpl_b/ui/upload_photo_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadPhotoProvider(),
        ),
      ],
      child: buildMaterialApp(),
    );
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          HomePage.routeName: (context) => const HomePage(),
          SeeAllPage.routeName: (context) => const SeeAllPage(),
          UploadPhotoPage.routeName: (context) => const UploadPhotoPage(),
        });
  }
}
