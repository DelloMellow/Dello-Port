import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/screens/helper.dart';
import 'package:kp_project/screens/release/release_detail_screen.dart';
import 'package:kp_project/widgets/my_card.dart';
import 'package:kp_project/widgets/my_dropdown2.dart';

class ReleaseScreen extends StatefulWidget {
  const ReleaseScreen({super.key});

  @override
  State<ReleaseScreen> createState() => _ReleaseScreenState();
}

class _ReleaseScreenState extends State<ReleaseScreen> {
  TextEditingController containerController = TextEditingController();
  late bool notSelectedYet;

  void validation() {
    if (containerController.text == "Select an Item") {
      notSelectedYet = true;
    } else {
      notSelectedYet = false;
    }
  }

  void selectContainer() {
    validation();

    if (!notSelectedYet) {
      Navigator.of(context)
          .push(
        MaterialPageRoute(
          builder: (context) =>
              ReleaseDetailScreen(documentID: containerController.text),
        ),
      )
          .then((value) {
        setState(
          () {
            containerController.clear();
          },
        );
      });
    } else {
      showErrorMessage(
        context,
        "You need to select one of the options in the dropdown !",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: silver,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            //Release Information Card
            const MyCard(
              title: "Release",
              description:
                  "Proses yang dilakukan untuk melepaskan kontainer dari area penumpukan atau kendaraan setelah selesai proses pemuatan atau distribusi.",
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
                  MyDropdown2(
                    key: UniqueKey(),
                    label: "No. Container",
                    collectionPath: "Container",
                    controller: containerController,
                    isRelease: true,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Select Button
                  MaterialButton(
                    minWidth: double.infinity,
                    color: steelBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: selectContainer,
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
