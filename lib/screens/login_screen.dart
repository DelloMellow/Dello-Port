import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/widgets/my_button.dart';
import 'package:kp_project/widgets/my_snackbar.dart';
import 'package:kp_project/widgets/my_textfield.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap; //untuk switch antara login dan register screen
  const LoginScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controller
  StateMachineController? controller;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  //sign user in method
  void signUserIn(BuildContext context, String email, String password) async {
    //proses sign in
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

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

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

      if (email.isEmpty || password.isEmpty) {
        showErrorMessage("Email and Password Cannot be Empty!");
      } else if (e.code == 'wrong-password') {
        showErrorMessage("Wrong Password!");
      } else if (e.code == 'user-not-found') {
        showErrorMessage("User Not Found!");
      } else if (e.code == 'invalid-email') {
        showErrorMessage("Invalid Email Format!");
      } else {
        showErrorMessage("Wrong Password!");
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
                //login animation
                SizedBox(
                  width: size.width,
                  height: 300,
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

                //Email TextField
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
                  },
                ),

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
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                //login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: MyButton(
                    text: 'Login',
                    onPressed: () {
                      //sign user in
                      signUserIn(context, emailController.text,
                          passwordController.text);
                    },
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //not have account, register now
                SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't you have an account?"),
                      TextButton(
                        onPressed: () {
                          // todo register
                        },
                        child: GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Register Now",
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
