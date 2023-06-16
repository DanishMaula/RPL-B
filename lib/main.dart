import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpl_b/data/model/event.dart';
import 'package:rpl_b/data/model/people.dart';
import 'package:rpl_b/provider/detail_provider.dart';
import 'package:rpl_b/provider/event_provider.dart';
import 'package:rpl_b/provider/memories_provider.dart';
import 'package:rpl_b/provider/people_provider.dart';
import 'package:rpl_b/provider/auth_provider.dart';
import 'package:rpl_b/ui/auth/login_page.dart';
import 'package:rpl_b/ui/detail/detail_page.dart';
import 'package:rpl_b/ui/home/home_page.dart';
import 'package:rpl_b/ui/see_all/see_all_event_page.dart';
import 'package:rpl_b/ui/see_all/see_all_memories_page.dart';
import 'package:rpl_b/ui/see_all/see_all_people_page.dart';
import 'package:rpl_b/ui/upload_photo_page.dart';
import 'package:rpl_b/ui/view_photo.dart';
import 'package:rpl_b/utils/style_manager.dart';
import 'package:rpl_b/utils/type.dart';
import 'data/model/memories.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    _user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PeopleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MemoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(),
        ),
      ],
      child: buildMaterialApp(),
    );
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginPage.routeName
          : HomePage.routeName,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle:
              getBlackTextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        SeeAllEventPage.routeName: (context) => SeeAllEventPage(
              listEvent:
                  ModalRoute.of(context)?.settings.arguments as List<Event>,
            ),
        SeeAllPeoplePage.routeName: (context) => SeeAllPeoplePage(
              listPeople:
                  ModalRoute.of(context)?.settings.arguments as List<People>,
            ),
        SeeAllMemoriesPage.routeName: (context) => SeeAllMemoriesPage(
              listMemories:
                  ModalRoute.of(context)?.settings.arguments as List<Memories>,
            ),
        UploadPhotoPage.routeName: (context) => UploadPhotoPage(
              type: ModalRoute.of(context)?.settings.arguments as PhotoType,
              event: ModalRoute.of(context)?.settings.arguments as String,
            ),
        DetailPage.routeName: (context) => DetailPage(
              map: ModalRoute.of(context)?.settings.arguments as Map<PhotoType, String>,
            ),
        ViewPhoto.routeName: (context) => ViewPhoto(
              imageProvider: ModalRoute.of(context)?.settings.arguments
                  as ImageProvider<Object>?,
            )
      },
    );
  }
}
