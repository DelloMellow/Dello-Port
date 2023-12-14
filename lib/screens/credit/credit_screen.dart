import 'package:flutter/material.dart';
import 'package:kp_project/constant/colors.dart';
import 'package:kp_project/constant/variable.dart';
import 'package:kp_project/screens/credit/developer.dart';
import 'package:kp_project/screens/credit/intern_location.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: silver,
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(appName),
        centerTitle: true,
        bottom: TabBar(
          controller: _controller,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: steelBlue),
          onTap: (value) {
            _controller.animateTo(_selectedIndex +=
                1); //buat pindahin tab jadi selected indexnya +1
          },
          tabs: const [
            //untuk icon dan text dari tabbar
            Tab(text: "Developer", icon: Icon(Icons.person)),
            Tab(text: "Intern Location", icon: Icon(Icons.location_on)),
          ],
        ),
      ),
      body: Center(
        child: TabBarView(
          controller: _controller,
          children: const [
            //isi dari masing-masing tab bar
            Developer(),
            InternLocation(),
          ],
        ),
      ),
    );
  }
}
