import 'package:flutter/material.dart';
import 'package:swifthome/animation/FadeAnimation.dart';
import 'package:swifthome/models/service.dart';
import 'package:swifthome/pages/cleaning.dart';
import 'package:swifthome/profile/profile.dart';

class SelectService extends StatefulWidget {
  const SelectService({Key? key}) : super(key: key);

  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  List<Service> services = [
    Service('Cleaning',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Plumber',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Electrician',
        'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Painter',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
    Service('Gardener',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Tailor', 'https://img.icons8.com/fluency/2x/sewing-machine.png'),
    Service('Maid', 'https://img.icons8.com/color/2x/housekeeper-female.png'),
    Service('Driver',
        'https://img.icons8.com/external-sbts2018-lineal-color-sbts2018/2x/external-driver-women-profession-sbts2018-lineal-color-sbts2018.png'),
    Service('Cook',
        'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-cooking-daily-routine-wanicon-flat-wanicon.png'),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    // Extracting the user email from FirebaseAuth instance

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SwiftHome',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Welcome Message Section
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Welcome to SwiftHome! \n Please select a service...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 13, 13, 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Service Grid Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeAnimation(
                      (1.0 + index) / 4,
                      serviceContainer(
                        services[index].imageURL,
                        services[index].name,
                        index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: selectedService >= 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CleaningPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              backgroundColor: Colors.blue,
            )
          : null,
    );
  }

  Widget serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedService = (selectedService == index) ? -1 : index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blue.shade50
              : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.blue
                : Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(image, height: 60),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                name,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
