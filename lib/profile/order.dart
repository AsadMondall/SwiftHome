import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy order information
    final List<Map<String, String>> orders = [
      {
        'Order ID': '001',
        'Date': '2024-01-01',
        'Amount': '\$100.00',
        'Status': 'Delivered'
      },
      {
        'Order ID': '002',
        'Date': '2024-02-01',
        'Amount': '\$150.00',
        'Status': 'Shipped'
      },
      {
        'Order ID': '003',
        'Date': '2024-03-01',
        'Amount': '\$200.00',
        'Status': 'Processing'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Info'),
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text('Order ID: ${order['Order ID']}'),
                    subtitle: Text('Date: ${order['Date']}'),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Amount: ${order['Amount']}'),
                        Text('Status: ${order['Status']}'),
                      ],
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
