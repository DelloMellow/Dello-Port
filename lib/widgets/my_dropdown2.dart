import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kp_project/widgets/my_snackbar.dart';

class MyDropdown2 extends StatefulWidget {
  const MyDropdown2({
    Key? key,
    required this.label,
    required this.collectionPath,
    required this.documentId,
    required this.subCollectionPath,
    // required this.onChanged,
    this.isEnable = true,
  }) : super(key: key);

  final String label;
  final String collectionPath;
  final String documentId;
  final String subCollectionPath;
  // final ValueChanged<String?> onChanged;
  final bool isEnable;

  @override
  State<MyDropdown2> createState() => _MyDropdown2State();
}

class _MyDropdown2State extends State<MyDropdown2> {
  late String dropdownValue;
  late Future<List<String>> firestoreOptions;

  @override
  void initState() {
    super.initState();
    dropdownValue = '';
    firestoreOptions = getFirestoreOptions();
  }

  //Mengambil collection dari firestore untuk dimasukkan kedalam dropdownmenu
  Future<List<String>> getFirestoreOptions() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(widget.collectionPath).doc(widget.documentId).collection(widget.subCollectionPath)
          .get();
      final List<String> options = querySnapshot.docs
          .map((doc) => doc.get('name'))
          .cast<String>()
          .toList();
      return options;
    } catch (e) {
      showErrorMessage('Error fetching Firestore data: $e');
      return [];
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
          //Label Text
          Text(
            widget.label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),

          //Spacer
          const SizedBox(height: 5),

          //Builder untuk dropdown yg dihubungkan dengan firestore
          FutureBuilder<List<String>>(
            future: firestoreOptions,
            builder: (context, snapshot) {
              //memunculkan loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No data available');
              } else {
                //ambil data pertama dari firestore
                dropdownValue = snapshot.data!.first;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      isExpanded: true,
                      items: snapshot.data!
                          .map<DropdownMenuItem<String>>((String option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: widget
                              .isEnable //kalau misalnya isEnable = false maka akan disable
                          ? (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            }
                          : null,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
