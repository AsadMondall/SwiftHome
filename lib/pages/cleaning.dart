import 'package:flutter/material.dart';
import 'package:swifthome/animation/FadeAnimation.dart';
import 'package:swifthome/pages/date_time.dart';
import 'package:swifthome/profile/profile.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  // Rooms to clean
  List<dynamic> _rooms = [
    [
      'Living Room',
      'https://img.icons8.com/officel/2x/living-room.png',
      Colors.red,
      0
    ],
    [
      'Bedroom',
      'https://img.icons8.com/fluency/2x/bedroom.png',
      Colors.orange,
      1
    ],
    ['Bathroom', 'https://img.icons8.com/color/2x/bath.png', Colors.blue, 1],
    ['Kitchen', 'https://img.icons8.com/dusk/2x/kitchen.png', Colors.purple, 0],
    ['Office', 'https://img.icons8.com/color/2x/office.png', Colors.green, 0]
  ];

  List<int> _selectedRooms = [];

  void _navigateToDateAndTime() {
    if (_selectedRooms.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DateAndTime(selectedRooms: _selectedRooms),
        ),
      );
    } else {
      // Handle case where no rooms are selected
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('No Rooms Selected'),
          content: Text('Please select at least one room to proceed.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
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
      floatingActionButton: _selectedRooms.isNotEmpty
          ? FloatingActionButton(
              onPressed: _navigateToDateAndTime,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_selectedRooms.length}',
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
                    'Where do you want cleaned?',
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
            itemCount: _rooms.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation(
                (1.2 + index) / 4,
                room(_rooms[index], index),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget room(List room, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedRooms.contains(index)) {
            _selectedRooms.remove(index);
          } else {
            _selectedRooms.add(index);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _selectedRooms.contains(index)
              ? room[2].shade50.withOpacity(0.5)
              : Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  room[1],
                  width: 35,
                  height: 35,
                ),
                SizedBox(width: 10.0),
                Text(
                  room[0],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                _selectedRooms.contains(index)
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
            (_selectedRooms.contains(index) && room[3] >= 1)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "How many ${room[0]}s?",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int idx) {
                            final int index = idx + 1;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  room[3] = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.all(10.0),
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: room[3] == index
                                      ? room[2].withOpacity(0.5)
                                      : room[2].shade200.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    index.toString(),
                                    style: const TextStyle(
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
