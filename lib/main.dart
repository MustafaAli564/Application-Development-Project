import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/favProvider.dart';
import 'package:recipe_app/Providers/qty.dart';
import 'package:recipe_app/pages/MainScreen.dart';
import 'package:recipe_app/pages/authpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Favprovider()),
        ChangeNotifierProvider(create: (_)=>QtyProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: MainScreen(),
        // home: Authpage(),
        home: LoginPage(),
      ),
    );
  }
}