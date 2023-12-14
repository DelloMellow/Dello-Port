import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/widgets/my_button.dart';
import 'package:kp_project/widgets/my_dropdown.dart';
import 'package:kp_project/widgets/my_inputfield.dart';
import 'package:kp_project/widgets/position_inputfield.dart';

class LiftOffInputScreen extends StatefulWidget {
  const LiftOffInputScreen({super.key});

  @override
  State<LiftOffInputScreen> createState() => _LiftOffInputScreenState();
}

class _LiftOffInputScreenState extends State<LiftOffInputScreen> {
  //Controller
  final containerController = TextEditingController();
  final locationController = TextEditingController();
  final remarkController = TextEditingController();
  final blockController = TextEditingController();
  final bayController = TextEditingController();
  final rowController = TextEditingController();
  final tierController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: silver,
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(appName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              //Container Number Input Field
              MyInputField(
                controller: containerController,
                label: "No. Container",
                hintText: "Enter Container Number",
                inputType: TextInputType.text,
              ),

              //Vessel Name Dropdown
              // const MyDropdown(
              //   label: "Vessel Name",
              //   collectionPath: "Vessel",
              // ),

              //Voyage In Dropdown
              // const MyDropdown(
              //   label: "Voyage In",
              //   collectionPath: "Dummy Voyage",
              // ),

              //Location Dropdown
              // const MyDropdown(
              //   label: "Location",
              //   collectionPath: "Dummy Location",
              // ),

              //Position Input Field
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //label text
                    const Text(
                      "Position",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),

                    //spacer
                    const SizedBox(
                      height: 5,
                    ),

                    //BBRT Input Field
                    Row(
                      children: [
                        //Block Input Field
                        Expanded(
                          flex: 1,
                          child: PositionInputField(
                            controller: blockController,
                            label: "Block",
                            hintText: "",
                            inputType: TextInputType.text,
                          ),
                        ),

                        //Spacer
                        const SizedBox(
                          width: 10,
                        ),

                        //Bay Input Field
                        Expanded(
                          flex: 1,
                          child: PositionInputField(
                            controller: bayController,
                            label: "Bay",
                            hintText: "",
                          ),
                        ),

                        //Spacer
                        const SizedBox(
                          width: 10,
                        ),

                        //Row Input Field
                        Expanded(
                          flex: 1,
                          child: PositionInputField(
                            controller: rowController,
                            label: "Row",
                            hintText: "",
                          ),
                        ),

                        //Spacer
                        const SizedBox(
                          width: 10,
                        ),

                        //Tier Input Field
                        Expanded(
                          flex: 1,
                          child: PositionInputField(
                            controller: tierController,
                            label: "Tier",
                            hintText: "",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Remark Input Field
              MyInputField(
                controller: remarkController,
                label: "Remark (Optional)",
                hintText: "Enter Remark Here",
                inputType: TextInputType.multiline,
                maxLine: 5,
              ),

              //Attachment
              Row(
                children: [
                  const Text(
                    "Attachment : ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  //Camera Button
                  MaterialButton(
                    minWidth: 150,
                    color: steelBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {}, //tambahin method untuk ke kamera disini
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //Submit Button
              MyButton(
                text: "Submit",
                onPressed: () {}, //tambahin method submit disini
                buttonColor: steelBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}