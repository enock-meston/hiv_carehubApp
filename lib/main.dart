import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiv_carehub/screens/auth/login.dart';
import 'package:hiv_carehub/screens/main_fragment.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> _checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('id');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HIVCARE-HUB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
            255, 203, 2, 26)),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: _checkUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          } else if (snapshot.data == true) {
            return MainFragment();
          } else {
            return LoginFragment();
          }
        },
      ),
    );
  }
}



