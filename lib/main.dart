import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kossan/firebase_options.dart';
import 'package:kossan/provider/booking_provider.dart';
import 'package:kossan/provider/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'package:kossan/provider/theme_provider.dart';
import 'package:kossan/screen/splash_screen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider(),),
        ChangeNotifierProvider(create: (context) => BookingProvider(),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: SplashScreen(),
    );
  }
}
