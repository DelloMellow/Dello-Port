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
import 'package:kp_project/widgets/position_inputfield.dart';

class LiftOffInputScreen extends StatefulWidget {
  const LiftOffInputScreen({
    super.key,
    required this.documentID,
  });

  final String documentID;

  @override
  State<LiftOffInputScreen> createState() => _LiftOffInputScreenState();
}

class _LiftOffInputScreenState extends State<LiftOffInputScreen> {
  //Controller
  TextEditingController containerController = TextEditingController();
  TextEditingController vesselNameController = TextEditingController();
  TextEditingController voyageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController bayController = TextEditingController();
  TextEditingController rowController = TextEditingController();
  TextEditingController tierController = TextEditingController();

  //validation check
  late bool isNull;
  late bool notSelectedYet;

  //firestore database
  final db = FirebaseFirestore.instance;

  //Image Picker
  late final CameraRepository _cameraRepository;
  late List<XFile> images = [];

  @override
  void initState() {
    super.initState();
    getContainerData();
    _cameraRepository =
        CameraRepository(context, onImagesChanged: _updateImages);
  }

  void _updateImages(List<XFile> updatedImages) {
    setState(() {
      images = updatedImages;
    });
  }

  @override
  void dispose() {
    super.dispose();
    containerController.dispose();
    vesselNameController.dispose();
    voyageController.dispose();
    locationController.dispose();
    remarkController.dispose();
    blockController.dispose();
    bayController.dispose();
    rowController.dispose();
    tierController.dispose();
  }

  void getContainerData() async {
    final collectionReference =
        db.collection("Container").doc(widget.documentID);
    collectionReference.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        //memasukkan value dari firestore kedalam inputtextfield
        containerController.text = data["name"];
        vesselNameController.text = data["vessel"];
        voyageController.text = data['voyage in'];

        setState(() {});
      },
      onError: (error) {
        showErrorMessage(context, "Error: $error");
      },
    );
  }

  void validation() {
    if (locationController.text == "Select an Item") {
      notSelectedYet = true;
    } else {
      notSelectedYet = false;
    }

    if ((blockController.text.isEmpty) ||
        (bayController.text.isEmpty) ||
        (rowController.text.isEmpty) ||
        (tierController.text.isEmpty)) {
      isNull = true;
    } else {
      isNull = false;
    }

    if (isNull) {
      showErrorMessage(context, "Position Information Cannot be Empty !");
    }

    if (notSelectedYet) {
      showErrorMessage(
        context,
        "You need to select one of the options in the dropdown !",
      );
    }
  }

  void submit() {
    //lakukan check dulu
    validation();

    const CircularProgressIndicator();

    if (!isNull && !notSelectedYet) {
      final positionData = <String, String>{
        "block": blockController.text,
        "bay": bayController.text,
        "row": rowController.text,
        "tier": tierController.text,
      };

      final List<String> imagePaths =
          images.map((image) => image.path).toList();

      final containerData = <String, dynamic>{
        "name": containerController.text,
        "vessel": vesselNameController.text,
        "voyage in": voyageController.text,
        "location": locationController.text,
        "position": positionData,
        "remark": remarkController.text,
        "isLiftOff": true,
        "images": imagePaths,
      };

      //masukkin datanya kedalam database
      db
          .collection("Container")
          .doc(containerController.text)
          .set(
            containerData,
            SetOptions(merge: true),
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

          setState(() {});
        },
      ).catchError(
        (error) {
          showErrorMessage(context, "Error writing document: $error");
        },
      );
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              //Container Number Input Field
              MyInputField(
                label: "No. Container",
                inputType: TextInputType.text,
                controller: containerController,
                isEnable: false,
              ),

              //Vessel Name Dropdown
              MyInputField(
                label: "Vessel Name",
                inputType: TextInputType.text,
                controller: vesselNameController,
                isEnable: false,
              ),

              //Voyage In Dropdown
              MyInputField(
                label: "Voyage In",
                inputType: TextInputType.text,
                controller: voyageController,
                isEnable: false,
              ),

              //Location Dropdown
              MyDropdown(
                label: "Location",
                collectionPath: "Location",
                controller: locationController,
              ),

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
