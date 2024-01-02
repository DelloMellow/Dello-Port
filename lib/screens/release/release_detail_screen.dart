import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/screens/helper.dart';
import 'package:kp_project/widgets/my_button.dart';
import 'package:kp_project/widgets/my_confirm_dialog.dart';
import 'package:kp_project/widgets/my_inputfield.dart';

class ReleaseDetailScreen extends StatefulWidget {
  const ReleaseDetailScreen({
    super.key,
    required this.documentID,
  });

  final String documentID;

  @override
  State<ReleaseDetailScreen> createState() => _ReleaseDetailScreenState();
}

class _ReleaseDetailScreenState extends State<ReleaseDetailScreen> {
  //controller
  TextEditingController containerController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController vesselNameController = TextEditingController();
  TextEditingController voyageController = TextEditingController();
  TextEditingController podController = TextEditingController();
  TextEditingController typeSizeController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController commodityController = TextEditingController();

  //firestore database
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getContainerData();
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
  }

  void getContainerData() async {
    final collectionReference =
        db.collection("Container").doc(widget.documentID);
    collectionReference.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        //memasukkan value dari firestore kedalam inputtextfield
        containerController.text = data["name"];
        companyController.text = data["company"];
        vesselNameController.text = data["vessel"];
        voyageController.text = data['voyage in'];
        podController.text = data["port of destination"];
        typeSizeController.text = data["type size"];
        conditionController.text = data["condition"];
        weightController.text = data["weight"];
        commodityController.text = data["commodity"];

        setState(() {});
      },
      onError: (error) {
        showErrorMessage(context, "Error: $error");
      },
    );
  }

  void confirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyConfirmDialog(
          iconColor: Colors.amber,
          titleText: "Are you sure?",
          contentText:
              "Are you sure want to release thi container? \nMake sure all information is correct.",
          confirmText: "Release",
          onConfirm: release,
          buttonColor: Colors.amber,
        );
      },
    );
  }

  void release() {
    final containerData = <String, bool>{
      "isReleased": true,
    };

    //masukkin datanya kedalam database
    db
        .collection("Container")
        .doc(containerController.text)
        .set(
          containerData,
          SetOptions(merge: true),
        )
        .then((value) {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                    "Container is Released",
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
    }).catchError(
      (error) {
        showErrorMessage(context, "Error writing document: $error");
      },
    );
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
              //Container Number Text Field
              MyInputField(
                controller: containerController,
                label: "No. Container",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Company Text Field
              MyInputField(
                controller: companyController,
                label: "Company",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Vessel Name Text Field
              MyInputField(
                controller: vesselNameController,
                label: "Vessel Name",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Voyage Text Field
              MyInputField(
                controller: voyageController,
                label: "Voyage In",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Port of Destination Text Field
              MyInputField(
                controller: podController,
                label: "Port of Destination",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Type Size Text Field
              MyInputField(
                controller: typeSizeController,
                label: "Type Size",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Condition Text Field
              MyInputField(
                controller: conditionController,
                label: "Condition",
                inputType: TextInputType.text,
                isEnable: false,
              ),

              //Weight Text Field
              MyInputField(
                controller: weightController,
                label: "Weight (Ton)",
                inputType: TextInputType.number,
                isEnable: false,
              ),

              //Commodity Text Field
              MyInputField(
                controller: commodityController,
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
                onPressed: confirmation,
                buttonColor: steelBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
