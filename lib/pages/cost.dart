import 'package:flutter/material.dart';
import 'package:swifthome/google_MAP/map_visualization.dart'; // Import MapScreen
import 'package:swifthome/pages/payment.dart';
import 'package:swifthome/profile/profile.dart';

class CostPage extends StatefulWidget {
  final List<int> selectedRooms;
  final DateTime selectedDate;
  final int selectedRepeat;
  final List<int> selectedExtraCleaning;

  const CostPage({
    Key? key,
    required this.selectedRooms,
    required this.selectedDate,
    required this.selectedRepeat,
    required this.selectedExtraCleaning,
  }) : super(key: key);

  @override
  _CostPageState createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  double _totalCost = 0.0;
  final double _baseCostPerRoom = 800; // Base cost per room
  final double _repeatCostMultiplier = 1.2; // Multiplier for repeat options
  final Map<int, String> _repeatLabels = {
    0: 'No repeat',
    1: 'Every day',
    2: 'Every week',
    3: 'Every month',
  };

  final Map<int, String> _roomLabels = {
    0: 'Living Room',
    1: 'Bedroom',
    2: 'Bathroom',
    3: 'Kitchen',
    4: 'Office',
  };

  final Map<int, double> _extraCleaningCosts = {
    0: 10.0, // Washing
    1: 8.0, // Fridge
    2: 8.0, // Oven
    3: 20.0, // Vehicle
    4: 20.0, // Windows
  };

  @override
  void initState() {
    super.initState();
    _calculateTotalCost();
  }

  void _calculateTotalCost() {
    // Calculate total cost based on selected options
    double baseCost = 0.0;

    // Calculate base cost for selected rooms
    widget.selectedRooms.forEach((index) {
      baseCost += _baseCostPerRoom;
    });

    // Calculate additional cost for repeat option
    double repeatCost =
        baseCost * (_repeatCostMultiplier * widget.selectedRepeat);

    // Calculate additional cost for selected extra cleaning services
    double extraCleaningCost = 100;
    widget.selectedExtraCleaning.forEach((index) {
      extraCleaningCost += _extraCleaningCosts[index]!;
    });

    // Calculate total cost
    _totalCost = baseCost + repeatCost + extraCleaningCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SwiftHome',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MapScreen(), // Embed MapScreen here
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Cost',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\BDT ${_totalCost.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 214, 37)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  _buildDetailsList(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Make Payment',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDetailsList() {
    List<Widget> items = [];
    items.add(_buildDetailItem('Service Name', 'Cleaning'));

    // Add selected rooms
    items.add(_buildDetailItem('Rooms',
        widget.selectedRooms.map((index) => _roomLabels[index]!).join(', ')));

    // Add selected date and time
    items.add(_buildDetailItem('Date & Time', widget.selectedDate.toString()));

    // Add repeat option
    items
        .add(_buildDetailItem('Repeat', _repeatLabels[widget.selectedRepeat]!));

    // Add extra cleaning services
    if (widget.selectedExtraCleaning.isNotEmpty) {
      items.add(_buildDetailItem(
          'Extra Cleaning',
          widget.selectedExtraCleaning
              .map((index) =>
                  '${_extraCleaningCosts[index]}\$ for ${_extraCleaningCosts.keys.elementAt(index)}')
              .join(', ')));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
              text: '$title: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
            ),
          ],
        ),
      ),
    );
  }
}
