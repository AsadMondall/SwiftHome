import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:swifthome/animation/FadeAnimation.dart';
import 'package:swifthome/models/service.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Service> services = [
    Service(
      'Cleaning',
      'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png',
    ),
    Service(
      'Plumber',
      'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png',
    ),
    Service(
      'Electrician',
      'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png',
    ),
    Service(
      'Painter',
      'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png',
    ),
    Service(
      'Carpenter',
      'https://img.icons8.com/fluency/2x/drill.png',
    ),
    Service(
      'Gardener',
      'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png',
    ),
    Service(
      'Tailor',
      'https://img.icons8.com/fluency/2x/sewing-machine.png',
    ),
    Service(
      'Maid',
      'https://img.icons8.com/color/2x/housekeeper-female.png',
    ),
    Service(
      'Driver',
      'https://img.icons8.com/external-sbts2018-lineal-color-sbts2018/2x/external-driver-women-profession-sbts2018-lineal-color-sbts2018.png',
    ),
  ];

  int selectedService = 4;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startServiceSelectionTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startServiceSelectionTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        selectedService = Random().nextInt(services.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwiftHome',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 122, 3),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'A Home Service Application \n Available services at a glance...',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 1, 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildServiceGrid(),
            _buildBottomContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          return FadeAnimation(
            (1.0 + index) / 4,
            _serviceContainer(services[index], index),
          );
        },
      ),
    );
  }

  Widget _buildBottomContainer(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          topRight: Radius.circular(80),
        ),
      ),
      child: Column(
        children: [
          //const SizedBox(height: 5),
          FadeAnimation(
            1.5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Center(
                child: Text(
                  'Easy, reliable way to take \ncare of your home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 33, 33),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeAnimation(
            1.5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                child: Text(
                  'We provide you with the best people to help take care of your home.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.5,
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: MaterialButton(
                elevation: 0,
                color: Color.fromARGB(255, 241, 122, 3),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceContainer(Service service, int index) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.white : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.blue.shade100
                : Colors.grey.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(service.imageURL, height: 30),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                service.name,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
