import 'package:flutter/material.dart';
import 'package:swifthome/profile/basic_info.dart';
import 'package:swifthome/profile/bill_info.dart';
import 'package:swifthome/profile/logout.dart'; // Import the logout page
import 'package:swifthome/profile/order.dart';
import 'package:swifthome/profile/user_dashboard.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          ProfileOption(
            icon: Icons.person,
            text: 'Basic Info',
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BasicInfoPage()),
              );
            },
          ),
          ProfileOption(
            icon: Icons.dashboard,
            text: 'Dashboard',
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
              );
            },
          ),
          ProfileOption(
            icon: Icons.shopping_cart,
            text: 'Order',
            color: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderPage()),
              );
            },
          ),
          ProfileOption(
            icon: Icons.receipt,
            text: 'Bill Info',
            color: Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BillInfoPage()),
              );
            },
          ),
          ProfileOption(
            icon: Icons.logout,
            text: 'Logout',
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogoutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Function() onTap;

  const ProfileOption({
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600),
        onTap: onTap,
      ),
    );
  }
}
