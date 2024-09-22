import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for completed and current orders
    final List<Map<String, String>> completedOrders = [
      {
        'Service Name': 'Cleaning',
        'Service Provider Name': 'Khalid Hussain',
        'Payment Status': 'Paid',
        'Date': '2024-01-01',
      },
      {
        'Service Name': 'Plumber',
        'Service Provider Name': 'Malek Hussain',
        'Payment Status': 'Not Paid',
        'Date': '2024-02-01',
      },
    ];

    final List<Map<String, String>> currentOrders = [
      {
        'Service Name': 'Painter',
        'Service Provider Name': 'Masud Rana',
        'Payment Status': 'Paid',
        'Date': '2024-04-01',
      },
      {
        'Service Name': 'Carpenter',
        'Service Provider Name': 'Raihan Ahmed',
        'Payment Status': 'Not Paid',
        'Date': '2024-05-01',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Completed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: completedOrders.length,
                itemBuilder: (context, index) {
                  final order = completedOrders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Service Name: ${order['Service Name']}'),
                      subtitle: Text(
                        'Service Provider: ${order['Service Provider Name']}\nPayment Status: ${order['Payment Status']}\nDate: ${order['Date']}',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Current Order',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: currentOrders.length,
                itemBuilder: (context, index) {
                  final order = currentOrders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Service Name: ${order['Service Name']}'),
                      subtitle: Text(
                        'Service Provider: ${order['Service Provider Name']}\nPayment Status: ${order['Payment Status']}\nDate: ${order['Date']}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
