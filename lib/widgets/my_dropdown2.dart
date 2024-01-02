import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/widgets/my_snackbar.dart';

class MyDropdown2 extends StatefulWidget {
  final String label;
  final String collectionPath;
  final TextEditingController controller;
  final bool isLiftOff;
  final bool isRelease;

  const MyDropdown2({
    super.key,
    required this.label,
    required this.collectionPath,
    required this.controller,
    this.isLiftOff = false,
    this.isRelease = false,
  });

  @override
  State<MyDropdown2> createState() => _MyDropdown2State();
}

class _MyDropdown2State extends State<MyDropdown2> {
  late List<String> dropdownItems = [];
  String? selectedItem;
  bool isError = false;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    _fetchDropdownItems();
  }

  //method untuk mengambil collection dari firestore untuk dimunculkan kedalam dropdown item
  Future<void> _fetchDropdownItems() async {
    try {
      setState(() {
        isLoading = true;
      });

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(widget.collectionPath);

      if (widget.isLiftOff) {
        QuerySnapshot querySnapshot = await collectionReference
            .where('isLiftOff', isEqualTo: false)
            .get();

        dropdownItems = ['Select an Item'] +
            querySnapshot.docs
                .map((doc) => doc.get("name").toString())
                .toList();
      }

      if (widget.isRelease) {
        QuerySnapshot querySnapshot = await collectionReference
            .where('isReleased', isEqualTo: false)
            .get();

        dropdownItems = ['Select an Item'] +
            querySnapshot.docs
                .map((doc) => doc.get("name").toString())
                .toList();
      }

      // Set default value if available
      if (dropdownItems.isNotEmpty && selectedItem != "") {
        selectedItem = 'Select an Item';
        widget.controller.text = selectedItem!;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showErrorMessage("Error fetching dropdown items: $e");
    }
  }

  //munculin snackbar kalau ada error
  void showErrorMessage(String message) {
    MySnackBar.show(context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text Label
          Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          //Spacer
          const SizedBox(height: 5),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          //Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: isError ? Colors.grey : Colors.red),
                color: isError ? silver : lightRed),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                value: selectedItem,
                items: dropdownItems
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                    isError = value != "Select an Item";
                    widget.controller.text = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
