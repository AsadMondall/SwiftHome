import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swifthome/pages/start.dart'; // Adjust the path to your start page

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();

            // Clear the login info from shared preferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('email');
            await prefs.remove('password');

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      StartPage()), // Adjust the path to your start page
              (Route<dynamic> route) => false,
            );
          },
          child: Text('Confirm Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
