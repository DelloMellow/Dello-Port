import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/widgets/my_button.dart';
import 'package:kp_project/widgets/my_dropdown.dart';
import 'package:kp_project/widgets/my_dropdown2.dart';
import 'package:kp_project/widgets/my_inputfield.dart';

class ReceivingInputScreen extends StatefulWidget {
  const ReceivingInputScreen({super.key});

  @override
  State<ReceivingInputScreen> createState() => _ReceivingInputScreenState();
}

class _ReceivingInputScreenState extends State<ReceivingInputScreen> {
  //Controller
  final containerController = TextEditingController();
  final companyController = TextEditingController();
  final vesselController = TextEditingController();
  final voyageController = TextEditingController();
  final podController = TextEditingController();
  final typeSizeController = TextEditingController();
  final conditionController = TextEditingController();
  final weightController = TextEditingController();
  final commodityController = TextEditingController();
  final remarkController = TextEditingController();
  TextEditingController vesselNameController = TextEditingController();

  String selectedVessel = "";

  @override
  void initState() {
    super.initState();
    selectedVessel = "Ark Royal";
  }

  @override
  Widget build(BuildContext context) {
    
    //String? selectedVessel;

    // void onVesselSelected(String? value) {
    //   setState(() {
    //     selectedVessel = value!;
    //   });
    // }

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
              //Container Number Input Field
              MyInputField(
                controller: containerController,
                label: "No. Container",
                hintText: "Enter Container Number",
                inputType: TextInputType.text,
              ),

              //Company Input Field
              MyInputField(
                controller: companyController,
                label: "Company",
                hintText: "Enter Company",
                inputType: TextInputType.text,
              ),

              //Vessel Name Dropdown
              MyDropdown(
                value: vesselNameController.text,
                label: "Vessel Name",
                collectionPath: 'Vessel',
                selectedValue: selectedVessel,
                onChanged: (newValue) {
                  setState(() {
                    selectedVessel = newValue!;
                    //print(selectedVessel);
                  });
                },
                //onChanged: onVesselSelected,
              ),

              //Voyage Dropdown
              // MyDropdown2(
              //   label: "Voyage in",
              //   collectionPath: "Vessel",
              //   documentId: selectedVessel!,
              //   subCollectionPath: "Voyage",
              // ),

              //Port of Discharge Dropdown
              // const MyDropdown(
              //   label: "Port of Destination",
              //   collectionPath: "Port of Destination",
              // ),

              //Type Size Dropdown
              // const MyDropdown(
              //   label: "Type Size",
              //   collectionPath: "Type Size",
              // ),

              //Condition Dropdown
              // const MyDropdown(
              //   label: "Condition",
              //   collectionPath: "Condition",
              // ),

              //Weight Input Field
              MyInputField(
                controller: weightController,
                label: "Weight (Ton)",
                hintText: "Enter Weight",
                inputType: TextInputType.number,
              ),

              //Commodity Dropdown
              // const MyDropdown(
              //   label: "Commodity",
              //   collectionPath: "Commodity",
              // ),

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
