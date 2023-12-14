import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/widgets/my_button.dart';
import 'package:kp_project/widgets/my_inputfield.dart';

class ReleaseDetailScreen extends StatelessWidget {
  const ReleaseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyController = TextEditingController();

    return Scaffold(
      backgroundColor: silver,
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(appName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: [
              //Container Number Text Field
              MyInputField(
                controller: dummyController,
                label: "No. Container",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Company Text Field
              MyInputField(
                controller: dummyController,
                label: "Company",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Vessel Name Text Field
              MyInputField(
                controller: dummyController,
                label: "Vessel Name",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Voyage Text Field
              MyInputField(
                controller: dummyController,
                label: "Voyage In",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Port of Destination Text Field
              MyInputField(
                controller: dummyController,
                label: "Port of Destination",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Type Size Text Field
              MyInputField(
                controller: dummyController,
                label: "Type Size",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Condition Text Field
              MyInputField(
                controller: dummyController,
                label: "Condition",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Weight Text Field
              MyInputField(
                controller: dummyController,
                label: "Weight (Ton)",
                inputType: TextInputType.number,
                isEnable: false,
              ),

              //Commodity Text Field
              MyInputField(
                controller: dummyController,
                label: "Commodity",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              const SizedBox(
                height: 10,
              ),

              //Submit Button
              MyButton(
                text: "Release",
                onPressed: () {}, //tambahin method release disini
                buttonColor: steelBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
