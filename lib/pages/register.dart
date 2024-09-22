import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _register() async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Optionally, you can save additional user information in Firestore here

      // After successful registration, navigate to the login page
      Navigator.pushReplacementNamed(
          context, '/login'); // Replace current route with login page
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'weak-password') {
          _errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          _errorMessage = 'The account already exists for that email.';
        } else {
          _errorMessage = 'Failed to register: ${e.message}';
        }
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SwiftHome',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/logo.png', // Adjust the path as per your project structure
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Register',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 182, 231, 250),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 182, 231, 250),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone No',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 182, 231, 250),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 182, 231, 250),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 182, 231, 250),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromARGB(255, 182, 231, 250),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 33, 33, 33),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 241, 122, 3),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
