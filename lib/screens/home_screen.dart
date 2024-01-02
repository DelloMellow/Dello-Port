import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/screens/credit/credit_screen.dart';
import 'package:kp_project/screens/liftoff/liftoff_screen.dart';
import 'package:kp_project/screens/receiving/receiving_screen.dart';
import 'package:kp_project/screens/release/release_screen.dart';
import 'package:kp_project/widgets/my_confirm_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  int currentPageIndex = 0;

  //logout method
  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  //show dialog method
  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyConfirmDialog(
          iconColor: Colors.red,
          titleText: "Are you sure?",
          contentText:
              "Are you sure want to logout? \nYou have to login again to access the system.",
          confirmText: "Logout",
          onConfirm: logOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(appName),
        centerTitle: true,
      ),

      //Drawer atau Hamburger menu
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  //Header untuk drawer
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: darkBlue,
                    ),
                    accountName: const Text(
                      "Hello, ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      "${user.email}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    //currentAccountPicture: const FlutterLogo(),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: silver,
                      child: Icon(
                        Icons.person,
                        size: 72,
                        color: steelBlue,
                      ),
                    ),
                  ),

                  //menu 1: Home
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      size: 30,
                    ),
                    title: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  //menu 2: Credit
                  ListTile(
                    leading: const Icon(
                      Icons.info,
                      size: 28,
                    ),
                    title: const Text(
                      "Credit",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      //menuju ke credit screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreditScreen()),
                      );
                    },
                  ),

                  //menu 3: Log out
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 28,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      //keluarin confirm dialog
                      showLogoutDialog();
                    },
                  ),
                ],
              ),
            ),

            //app version
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
              child: const Text(
                "Version $appVersion",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),

      //Bottom Navigation Menu
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 97, 148, 181),
        backgroundColor: powderBlue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          //menu Receiving
          NavigationDestination(
            icon: Icon(Icons.call_received_rounded),
            selectedIcon: Icon(
              Icons.call_received_rounded,
              color: Colors.white70,
            ),
            label: 'Receiving',
          ),

          //menu Liftoff
          NavigationDestination(
            icon: Icon(Icons.forklift),
            selectedIcon: Icon(
              Icons.forklift,
              color: Colors.white70,
            ),
            label: 'Liftoff',
          ),

          //menu Release
          NavigationDestination(
            icon: Icon(Icons.local_shipping_outlined),
            selectedIcon: Icon(
              Icons.local_shipping,
              color: Colors.white70,
            ),
            label: 'Release',
          ),
        ],
      ),

      body: const <Widget>[
        ReceivingScreen(),
        LiftoffScreen(),
        ReleaseScreen(),
      ][currentPageIndex],
    );
  }
}
