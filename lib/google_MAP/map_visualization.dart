import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swifthome/google_MAP/directions_model.dart';
import 'package:swifthome/google_MAP/directions_repository.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;
  Marker? _origin;
  List<Marker> _laborerMarkers = [];
  Directions? _info;
  LatLng? _currentPosition;
  static const List<LatLng> laborerLocations = [
    LatLng(22.7005, 90.3537), // Choumatha
    LatLng(22.5721, 90.1870), // Jhalokathi
    LatLng(22.6701, 90.3489), // Rupatoli
  ];

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  void _setCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _addLaborerMarkers();
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition!, zoom: 14.5),
        ),
      );
    });
  }

  void _addLaborerMarkers() {
    setState(() {
      _laborerMarkers = laborerLocations.map((location) {
        return Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          infoWindow: InfoWindow(title: 'Laborer'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
      }).toList();
    });

    _drawPolylines();
  }

  void _drawPolylines() async {
    for (LatLng laborerLocation in laborerLocations) {
      final directions = await DirectionsRepository(dio: Dio()).getDirections(
        origin: _currentPosition!,
        destination: laborerLocation,
      );
      setState(() {
        _info = directions;
      });
    }
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google Maps'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _currentPosition ??
                  LatLng(22.7133, 90.3496), // Default to Barishal
              zoom: 14.5,
            ),
            onMapCreated: (controller) {
              _googleMapController = controller;
              _addLaborerMarkers();
            },
            markers: {
              if (_currentPosition != null)
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: _currentPosition!,
                  infoWindow: InfoWindow(title: 'Your Location'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                ),
              ..._laborerMarkers,
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: PolylineId('overview_polyline'),
                  color: Colors.green,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _currentPosition ??
                        LatLng(22.7133, 90.3496), // Default to Barishal
                    zoom: 14.5,
                  ),
                ),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
