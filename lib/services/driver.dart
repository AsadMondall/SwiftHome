import 'package:flutter/material.dart';
import 'package:swifthome/animation/FadeAnimation.dart';
import 'package:swifthome/pages/date_time.dart';
import 'package:swifthome/profile/profile.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  // Driving tasks
  List<dynamic> _tasks = [
    [
      'Personal Driver',
      'https://img.icons8.com/fluency/2x/car.png',
      Colors.red,
      0
    ],
    [
      'Delivery Driver',
      'https://img.icons8.com/fluency/2x/delivery.png',
      Colors.orange,
      1
    ],
    [
      'Taxi Service',
      'https://img.icons8.com/fluency/2x/taxi.png',
      Colors.blue,
      1
    ],
    [
      'Ride Sharing',
      'https://img.icons8.com/fluency/2x/ride.png',
      Colors.purple,
      0
    ],
    [
      'Chauffeur Service',
      'https://img.icons8.com/fluency/2x/chauffeur.png',
      Colors.green,
      0
    ]
  ];

  List<int> _selectedTasks = [];

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
      floatingActionButton: _selectedTasks.length > 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DateAndTime(
                            selectedRooms: [],
                          )),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_selectedTasks.length}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ],
              ),
              backgroundColor: Colors.blue,
            )
          : null,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FadeAnimation(
                1,
                Padding(
                  padding: EdgeInsets.only(
                      top: 40.0, right: 20.0, left: 20.0, bottom: 10.0),
                  child: Text(
                    'What driving service do you need?',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: _tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation(
                (1.2 + index) / 4,
                task(_tasks[index], index),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget task(List task, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedTasks.contains(index)) {
            _selectedTasks.remove(index);
          } else {
            _selectedTasks.add(index);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _selectedTasks.contains(index)
              ? task[2].shade50.withOpacity(0.5)
              : Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  task[1],
                  width: 35,
                  height: 35,
                ),
                SizedBox(width: 10.0),
                Text(
                  task[0],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                _selectedTasks.contains(index)
                    ? Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            (_selectedTasks.contains(index) && task[3] >= 1)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "How many ${task[0]} tasks?",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  task[3] = index + 1;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.all(10.0),
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: task[3] == index + 1
                                      ? task[2].withOpacity(0.5)
                                      : task[2].shade200.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
