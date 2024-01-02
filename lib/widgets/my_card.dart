import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';

class MyCard extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String description;

  const MyCard({
    super.key,
    this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            if (imagePath != null) // Tampilkan gambar jika ada imagePath
              Expanded(
                flex: 1,
                child: Image.asset(imagePath!),
              ),
            if (imagePath != null) // Hanya tambahkan SizedBox jika ada gambar
              const SizedBox(
                width: 15,
              ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text Judul
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  // Text Isi
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
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
