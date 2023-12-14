import 'package:flutter/material.dart';
import 'package:kp_project/screens/credit/map_view.dart';

class InternLocation extends StatefulWidget {
  const InternLocation({super.key});

  @override
  State<InternLocation> createState() => _InternLocationState();
}

class _InternLocationState extends State<InternLocation> {
  @override
  Widget build(BuildContext context) {
    return const MapView();
  }
}
