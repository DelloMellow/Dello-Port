import 'package:flutter/material.dart';
import 'package:kp_project/constant/variable.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Intern Location Detail',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Image(
              image: AssetImage('lib/images/logo_temas.png'),
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              internLocationName,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              internLocationDetail,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              internLocationPhone,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
