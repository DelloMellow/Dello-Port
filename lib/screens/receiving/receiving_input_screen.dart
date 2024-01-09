import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/repositories/camera_repository.dart';
import 'package:kp_project/screens/helper.dart';
import 'package:kp_project/widgets/my_button.dart';
import 'package:kp_project/widgets/my_dropdown.dart';
import 'package:kp_project/widgets/my_inputfield.dart';

class ReceivingInputScreen extends StatefulWidget {
  const ReceivingInputScreen({
    super.key,
    this.containerNumber,
  });

  final String? containerNumber;

  @override
  State<ReceivingInputScreen> createState() => _ReceivingInputScreenState();
}

class _ReceivingInputScreenState extends State<ReceivingInputScreen> {
  //Controller
  TextEditingController containerController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController vesselNameController = TextEditingController();
  TextEditingController voyageController = TextEditingController();
  TextEditingController podController = TextEditingController();
  TextEditingController typeSizeController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController commodityController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  //database
  final db = FirebaseFirestore.instance;

  //Image Picker
  late final CameraRepository _cameraRepository;
  late List<XFile> images = [];

  //validation check
  late bool isNull;
  late bool notSelectedYet;

  @override
  void initState() {
    super.initState();
    _cameraRepository =
        CameraRepository(context, onImagesChanged: _updateImages);
    if (widget.containerNumber != null) {
      containerController.text = widget.containerNumber!;
    }
  }

  void _updateImages(List<XFile> updatedImages) {
    setState(() {
      images = updatedImages;
    });
  }

  void validation() {
    if ((containerController.text.isEmpty ||
        companyController.text.isEmpty ||
        weightController.text.isEmpty)) {
      isNull = true;
    } else {
      setState(() {
        isNull = false;
      });
    }

    if ((vesselNameController.text == 'Select an Item') ||
        (voyageController.text == 'Select an Item') ||
        (podController.text == 'Select an Item') ||
        (typeSizeController.text == 'Select an Item') ||
        (conditionController.text == 'Select an Item') ||
        (commodityController.text == 'Select an Item')) {
      notSelectedYet = true;
    } else {
      setState(() {
        notSelectedYet = false;
      });
    }

    if (isNull) {
      showErrorMessage(
          context, "No. Container, Company, and Weight Cannot be Empty !");
    }

    if (notSelectedYet) {
      showErrorMessage(
          context, "You need to select one of the options in the dropdown !");
    }
  }

  void submit() async {
    validation(); //lakukan check dulu

    const CircularProgressIndicator(); //tampilin loading

    if (!isNull && !notSelectedYet) {
      final List<String> imagePaths =
          images.map((image) => image.path).toList();

      final containerData = <String, dynamic>{
        "name": containerController.text,
        "company": companyController.text,
        "vessel": vesselNameController.text,
        "voyage in": voyageController.text,
        "port of destination": podController.text,
        "type size": typeSizeController.text,
        "condition": conditionController.text,
        "weight": weightController.text,
        "commodity": commodityController.text,
        "remark": remarkController.text,
        "isLiftOff": false,
        "images": imagePaths,
      };

      QuerySnapshot duplicateDocs = await db
          .collection('Container')
          .where('name',
              isEqualTo:
                  containerData['name']) // Ganti dengan field yang sesuai
          .get();

      if (duplicateDocs.docs.isNotEmpty) {
        // ignore: use_build_context_synchronously
        showErrorMessage(context,
            '${containerController.text} already added to Receiving List!');
      } else {
        //masukkin datanya kedalam database
        db
            .collection("Container")
            .doc(containerController.text)
            .set(
              containerData,
            )
            .then(
          (value) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: steelBlue,
                icon: const Icon(
                  Icons.verified_outlined,
                  size: 180,
                  color: white,
                  weight: 5,
                ),
                title: const Text(
                  "Success",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                actions: const [
                  Column(
                    children: [
                      Center(
                        child: Text(
                          "Your Data is Submitted",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ).catchError(
          (error) {
            showErrorMessage(context, "Error writing document: $error");
          },
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    containerController.dispose();
    companyController.dispose();
    vesselNameController.dispose();
    voyageController.dispose();
    podController.dispose();
    typeSizeController.dispose();
    conditionController.dispose();
    weightController.dispose();
    commodityController.dispose();
    remarkController.dispose();
  }

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
                label: "Vessel Name",
                collectionPath: 'Vessel',
                controller: vesselNameController,
              ),

              MyDropdown(
                label: "Voyage In",
                collectionPath: "Voyage",
                //documentId: "Voyage 1",
                controller: voyageController,
              ),

              // //Port of Discharge Dropdown
              MyDropdown(
                label: "Port of Destination",
                collectionPath: "Port of Destination",
                controller: podController,
              ),

              // //Type Size Dropdown
              MyDropdown(
                label: "Type Size",
                collectionPath: "Type Size",
                controller: typeSizeController,
              ),

              // //Condition Dropdown
              MyDropdown(
                label: "Condition",
                collectionPath: "Condition",
                controller: conditionController,
              ),

              //Weight Input Field
              MyInputField(
                controller: weightController,
                label: "Weight (Ton)",
                hintText: "Enter Weight",
                inputType: TextInputType.number,
              ),

              // //Commodity Dropdown
              MyDropdown(
                label: "Commodity",
                collectionPath: "Commodity",
                controller: commodityController,
              ),

              //Remark Input Field
              MyInputField(
                controller: remarkController,
                label: "Remark (Optional)",
                hintText: "Enter Remark Here",
                inputType: TextInputType.multiline,
                maxLine: 5,
                isOptional: true,
              ),

              //Attachment
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        onPressed: () async {
                          await _cameraRepository.showOption(images);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  for (var data in images)
                    TextButton(
                      child: Text(data.name),
                      onPressed: () {
                        //memunculkan preview dari gambarnya
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                Image.file(
                                  File(data.path),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //Submit Button
              MyButton(
                text: "Submit",
                onPressed: submit,
                buttonColor: steelBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
