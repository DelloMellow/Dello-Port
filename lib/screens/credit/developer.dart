import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';

class Developer extends StatelessWidget {
  const Developer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //color: backgroundColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: darkBlue,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: const Column(
                  children: [
                    //Profile Image
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('lib/images/profile.jpg'),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          devName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          devNIM,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          devMajority,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          devEmail,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'lib/images/oshi_no_ko.gif',
              height: 170,
            ),
          ],
        ),
      ),
    );
  }
}
