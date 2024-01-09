import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/widgets/my_button.dart';
import 'package:kp_project/widgets/my_snackbar.dart';
import 'package:kp_project/widgets/my_textfield.dart';
import 'package:rive/rive.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap; //untuk switch antara login dan register screen
  const RegisterScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //controller
  StateMachineController? controller;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  void registerUser(
    BuildContext context,
    String email,
    String password,
    String confirmPassword,
  ) async {
    //proses register
    try {
      //show loading
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      //validasi apakah password dan confirm password sama
      if (password == confirmPassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        showErrorMessage("Password Don't Match With Confirm Password!");
      }
      //hilangin loading
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Mengaktifkan trigFail
      if (trigFail != null) {
        trigFail!.change(true);
        // Menonaktifkan isHandsUp
        if (isHandsUp != null) {
          isHandsUp!.change(false);
        }
      }

      Navigator.pop(context);

      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        showErrorMessage("All Text Field Cannot be Empty!");
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage("Email Already in Use!");
      } else if (e.code == 'user-not-found') {
        showErrorMessage("User Not Found!");
      } else if (e.code == 'invalid-email') {
        showErrorMessage("Invalid Email Format!");
      } else {
        showErrorMessage("Email Already in Use!");
      }
    }
  }

  void showErrorMessage(String message) {
    MySnackBar.show(context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //register animation
                SizedBox(
                  width: size.width,
                  height: 250,
                  child: RiveAnimation.asset(
                    "lib/images/animated-login-character.riv",
                    stateMachines: const ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                          artboard, "Login Machine");
                      if (controller == null) return;

                      artboard.addController(controller!);
                      isChecking = controller?.findInput("isChecking");
                      isHandsUp = controller?.findInput("isHandsUp");
                      trigSuccess = controller?.findInput("trigSuccess");
                      trigFail = controller?.findInput("trigFail");
                    },
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //username TextField
                MyTextField(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    hintText: "Email",
                    icon: Icons.mail,
                    onChanged: (value) {
                      if (isHandsUp != null) {
                        isHandsUp!.change(false);
                      }
                      if (isChecking == null) return;

                      isChecking!.change(true);
                    }),

                const SizedBox(
                  height: 10,
                ),

                //Password Text Field
                MyTextField(
                    controller: passwordController,
                    obscureText: true,
                    inputType: TextInputType.visiblePassword,
                    hintText: "Password",
                    icon: Icons.lock,
                    onChanged: (value) {
                      if (isChecking != null) {
                        isChecking!.change(false);
                      }
                      if (isHandsUp == null) return;

                      isHandsUp!.change(true);
                    }),

                const SizedBox(
                  height: 10,
                ),

                //Confirm Password Text Field
                MyTextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    inputType: TextInputType.visiblePassword,
                    hintText: "Confirm Password",
                    icon: Icons.lock,
                    onChanged: (value) {
                      if (isChecking != null) {
                        isChecking!.change(false);
                      }
                      if (isHandsUp == null) return;

                      isHandsUp!.change(true);
                    }),

                const SizedBox(
                  height: 20,
                ),

                //Register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: MyButton(
                    text: 'Register',
                    onPressed: () {
                      registerUser(
                        context,
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //already have account, login now
                SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {},
                        child: GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Login Now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
