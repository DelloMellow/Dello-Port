import 'package:flutter/material.dart';
import 'package:kp_project/widgets/my_snackbar.dart';

void showErrorMessage(BuildContext context, String message) {
  MySnackBar.show(context, message: message);
}