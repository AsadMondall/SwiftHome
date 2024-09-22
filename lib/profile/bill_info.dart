import 'package:flutter/material.dart';

class BillInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy billing information
    final String accountNumber = '123456789';
    final String billingAddress = '123 Main St, City, Country';
    final List<Map<String, String>> bills = [
      {'Date': '2024-01-01', 'Amount': '\$100.00', 'Status': 'Paid'},
      {'Date': '2024-02-01', 'Amount': '\$150.00', 'Status': 'Due'},
      {'Date': '2024-03-01', 'Amount': '\$200.00', 'Status': 'Paid'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Info'),
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Billing Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            InfoRow(label: 'Account Number', value: accountNumber),
            InfoRow(label: 'Billing Address', value: billingAddress),
            const SizedBox(height: 16),
            const Text(
              'Bill History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  final bill = bills[index];
                  return ListTile(
                    title: Text('Date: ${bill['Date']}'),
                    subtitle: Text('Amount: ${bill['Amount']}'),
                    trailing: Text('Status: ${bill['Status']}'),
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
