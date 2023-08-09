import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatelessWidget {
  final DocumentSnapshot documentSnapshot2;
  const LocationMap({super.key, required this.documentSnapshot2});

  @override
  Widget build(BuildContext context) {
    var titik = <Marker>{};

    titik.add(
      Marker(
        markerId: const MarkerId("marker bidan"),
        position: LatLng(double.parse(documentSnapshot2['latitude']),
            double.parse(documentSnapshot2['longitude'])),
        infoWindow: InfoWindow(
          title: documentSnapshot2['name'],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Praktek MAndiri Bidan'),
      ),
      body: GoogleMap(
        // circles: circle,
        markers: titik,
        mapToolbarEnabled: true,
        mapType: MapType.hybrid,
        trafficEnabled: true,
        zoomControlsEnabled: true,
        buildingsEnabled: true,
        indoorViewEnabled: true,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(documentSnapshot2['latitude']),
              double.parse(documentSnapshot2['longitude'])),
          zoom: 14,
        ),
      ),
    );
  }
}













































    // var circle = <Circle>{};
    // circle.add(
    //   const Circle(
    //     center: LatLng(-6.161139024293343, 106.747268722285),
    //     radius: 1000,
    //     strokeColor: Colors.red,
    //     strokeWidth: 4,
    //     circleId: CircleId("Circle1"),
    //   ),
    // );