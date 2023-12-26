import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rentcar/halaman_riwayat.dart';
import 'package:rentcar/login.dart';
import 'package:rentcar/setting_screen.dart';
import 'package:rentcar/firebase_options.dart';
import 'package:rentcar/home_page.dart';
import 'package:rentcar/introduction_page.dart';
import 'package:rentcar/profile.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeModeData(),
        ),
      ],
      child: Builder(builder: (ctx) {
        return MaterialApp(
          title: 'Your App Title',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // Your theme configuration for light mode
            useMaterial3: true,
            brightness: Brightness.light,
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: "Serif",
              ),
              bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          darkTheme: ThemeData(
            // Your theme configuration for dark mode
            useMaterial3: true,
            brightness: Brightness.dark,
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: "Serif",
              ),
              bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          themeMode: Provider.of<ThemeModeData>(ctx).themeMode,
          initialRoute: '/', // Set initial route
          routes: {
            '/': (context) => StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IntroductionPage();
                    } else {
                      return Login();
                    }
                  },
                ),
            // '/introduction': (context) => IntroductionPage(),
            '/history': (context) => LihatData(),
            '/home': (context) => HomePage(),
            '/profile': (context) => Profil(),
            // Add more routes as needed
          },
        );
      }),
    );
  }
}

