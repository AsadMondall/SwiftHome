import 'package:flutter/material.dart';
import 'package:swifthome/pages/select_service.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Payment Method',
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPaymentMethod(
              context,
              'bKash',
              'assets/bkash.png',
            ),
            SizedBox(height: 20),
            _buildPaymentMethod(
              context,
              'Nagad',
              'assets/nagad.png',
            ),
            SizedBox(height: 20),
            _buildPaymentMethod(
              context,
              'Rocket',
              'assets/rocket.png',
            ),
            SizedBox(height: 20),
            _buildPaymentMethod(
              context,
              'Credit/Debit Card',
              'assets/card.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
      BuildContext context, String name, String assetPath) {
    return InkWell(
      onTap: () {
        // Handle payment method selection
        _showPaymentConfirmation(context, name);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade50,
        ),
        child: Row(
          children: [
            Image.asset(
              assetPath,
              width: 50,
              height: 50,
            ),
            SizedBox(width: 20),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  void _showPaymentConfirmation(BuildContext context, String methodName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Confirmation'),
          content: Text('Confirm your payment via $methodName.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate back to dashboard or home screen after payment confirmation
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SelectService()),
                  (route) => false,
                );
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
