import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swifthome/firebase_options.dart';
import 'package:swifthome/pages/login.dart';
import 'package:swifthome/pages/register.dart';
import 'package:swifthome/pages/select_service.dart';
import 'package:swifthome/pages/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(SwiftHomeApp());
}

class SwiftHomeApp extends StatelessWidget {
  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwiftHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
              future: _checkLoginStatus(),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (snapshot.data == true) {
                    return SelectService();
                  } else {
                    return StartPage();
                  }
                }
              },
            ),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/Select_Service': (context) => SelectService(),
      },
    );
  }
}
