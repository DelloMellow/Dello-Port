import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/screens/liftoff/liftoff_input_screen.dart';
import 'package:kp_project/widgets/my_card.dart';
import 'package:kp_project/widgets/my_dropdown.dart';

class LiftoffScreen extends StatefulWidget {
  const LiftoffScreen({super.key});

  @override
  State<LiftoffScreen> createState() => _LiftoffScreenState();
}

class _LiftoffScreenState extends State<LiftoffScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: silver,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            //LiftOff Information Card
            const MyCard(
              title: "LiftOff",
              description:
                  "Proses pengangkatan kontainer dari area penumpukan menuju kendaraan atau sarana transportasi lainnya untuk menuju ke lokasi tujuan",
            ),

            const SizedBox(
              height: 50,
            ),

            //Select No. Container Section
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: backgroundColor,
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(0),
              child: Column(
                children: [
                  //No. Container Dropdown
                  // const MyDropdown(
                  //   label: "No. Container",
                  //   collectionPath: "Dummy Container",
                  // ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Select Button
                  MaterialButton(
                    minWidth: double.infinity,
                    color: steelBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LiftOffInputScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Select",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
