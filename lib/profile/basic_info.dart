import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BasicInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Basic Info'),
          backgroundColor: Color.fromARGB(255, 241, 122, 3),
        ),
        body: Center(
          child: Text('No user information available.'),
        ),
      );
    }

    // Assuming that user additional information is stored in user's profile
    final String email = user.email ?? 'N/A';
    final String phoneNumber = user.phoneNumber ?? 'N/A';
    // Replace with actual logic to retrieve addresses and password
    final String addresses = '123 Main St, City, Country'; // Placeholder
    final String password = '******'; // Placeholder, never show real passwords

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Info'),
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            InfoRow(label: 'Email', value: email),
            InfoRow(label: 'Password', value: password),
            InfoRow(label: 'Phone Number', value: phoneNumber),
            InfoRow(label: 'Addresses', value: addresses),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
