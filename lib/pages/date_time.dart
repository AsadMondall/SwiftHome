import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swifthome/pages/cleaning.dart';
import 'package:swifthome/pages/cost.dart';
import 'package:swifthome/profile/profile.dart';

class DateAndTime extends StatefulWidget {
  final List<int> selectedRooms;

  const DateAndTime({Key? key, required this.selectedRooms}) : super(key: key);

  @override
  _DateAndTimeState createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  int _selectedRepeat = 0;
  DateTime _selectedDate = DateTime.now();
  final List<int> _selectedExtraCleaning = [];

  final List<String> _repeat = [
    'No repeat',
    'Every day',
    'Every week',
    'Every month'
  ];

  final List<List<dynamic>> _extraCleaning = [
    ['Washing', 'https://img.icons8.com/office/2x/washing-machine.png', 10],
    ['Fridge', 'https://img.icons8.com/cotton/2x/fridge.png', 8],
    [
      'Oven',
      'https://img.icons8.com/external-becris-lineal-color-becris/2x/external-oven-kitchen-cooking-becris-lineal-color-becris.png',
      8
    ],
    [
      'Vehicle',
      'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png',
      20
    ],
    [
      'Windows',
      'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-window-interiors-kiranshastry-lineal-color-kiranshastry-1.png',
      20
    ],
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          _selectedDate.hour,
          _selectedDate.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: _selectedDate.hour,
        minute: _selectedDate.minute,
      ),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  String getFormattedDateTime() {
    return DateFormat('d MMMM yyyy, hh:mm a').format(_selectedDate);
  }

  void _navigateBackToCleaning() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CleaningPage(),
      ),
    );
  }

  void _navigateToCost() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CostPage(
            selectedRooms: widget.selectedRooms,
            selectedDate: _selectedDate,
            selectedRepeat: _selectedRepeat,
            selectedExtraCleaning: _selectedExtraCleaning),
      ),
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCost,
        child: Icon(Icons.arrow_forward_ios),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
                  child: Text(
                    'Select Date and Time',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        getFormattedDateTime(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_today,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () => _selectTime(context),
                      icon: Icon(
                        Icons.access_time,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Repeat",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _repeat.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRepeat = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: _selectedRepeat == index
                                ? Colors.blue.shade400
                                : Colors.grey.shade100,
                          ),
                          margin: EdgeInsets.only(right: 20),
                          child: Center(
                            child: Text(
                              _repeat[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: _selectedRepeat == index
                                    ? Colors.white
                                    : Colors.grey.shade800,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Additional Service",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _extraCleaning.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectedExtraCleaning.contains(index)) {
                              _selectedExtraCleaning.remove(index);
                            } else {
                              _selectedExtraCleaning.add(index);
                            }
                          });
                        },
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _selectedExtraCleaning.contains(index)
                                ? Colors.blue.shade400
                                : Colors.grey.shade100,
                          ),
                          margin: EdgeInsets.only(right: 20),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                _extraCleaning[index][1],
                                height: 40,
                              ),
                              SizedBox(height: 10),
                              Text(
                                _extraCleaning[index][0],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: _selectedExtraCleaning.contains(index)
                                      ? Colors.white
                                      : Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "+\$${_extraCleaning[index][2]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedExtraCleaning.contains(index)
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
