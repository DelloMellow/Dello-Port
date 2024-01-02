import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/widgets/my_snackbar.dart';

class MyDropdown extends StatefulWidget {
  final String label;
  final String collectionPath;
  final TextEditingController controller;

  const MyDropdown({
    Key? key,
    required this.label,
    required this.collectionPath,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
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

      QuerySnapshot querySnapshot = await collectionReference.get();

      dropdownItems = ['Select an Item'] +
          querySnapshot.docs.map((doc) => doc.get("name").toString()).toList();

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
                    //print(selectedItem);
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
