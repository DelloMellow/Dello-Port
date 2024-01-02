import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/screens/credit/location_bottom_sheet.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //map controller
  late GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
        });
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(-6.143972673655266, 106.89023332863667), //lokasi
        zoom: 100.0,
      ),
      markers: {
        //penanda warna merah di maps
        Marker(
            markerId: const MarkerId('1'),
            position: const LatLng(-6.143972673655266, 106.89023332863667),
            infoWindow: const InfoWindow(
              title: 'Intern Location',
              snippet: internLocationName,
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (BuildContext context) {
                  return const LocationBottomSheet();
                },
              );
            }),
      },
    );
  }
}
