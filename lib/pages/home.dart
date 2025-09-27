import 'package:ececompanion/pages/exams.dart';
import 'package:ececompanion/pages/manuals.dart';
import 'package:ececompanion/pages/practical.dart';
import 'package:ececompanion/pages/projects.dart';
import 'package:ececompanion/pages/vlabs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';

import '../models/popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  final String name ="adad";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categoryDetails = [];
  Future <void> _initData() async {
    String data= await DefaultAssetBundle.of(context).loadString("json/categories.json");
    setState(() {
      categoryDetails = jsonDecode(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.storage.request();
    await Permission.notification.request();
  }

  void _showDepartmentInfo() {
    DepartmentInfoDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FDFF),
      body:  SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.417,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.076, left: 30),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.23,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0xff62cff4), Color(0xff2c67f2)]),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50))
                        ),
                        child: const Text("ECE Student Companion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        right: MediaQuery.of(context).size.width * 0.04,
                        left: MediaQuery.of(context).size.width * 0.04,
                        bottom: 10,
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.26,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: const Color(0xff62cff4).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 4))],
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(30))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FittedBox(fit: BoxFit.scaleDown, child: Text("Explore, Experiment, Excel", style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 18, fontWeight: FontWeight.w700))),
                                const SizedBox(height: 5),
                                FittedBox(fit: BoxFit.scaleDown, child: Text("Master Your Skills\nwith these Curated Resources", style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 15, fontWeight: FontWeight.w500))),
                                const SizedBox(height: 5),
                                MaterialButton(
                                    onPressed: () { Get.to(transition: Transition.downToUp, () => const Practical()); },
                                    height: 55,
                                    minWidth: 200,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                    color: const Color(0xff62cff4),
                                    child: const Text("Links & Resources", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                                ),
                              ],
                            )
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height * 0.285,
                          left: MediaQuery.of(context).size.height * 0.35,
                          child: Lottie.asset('json/bulb.json', height: 85, repeat: true, frameRate: FrameRate.max)
                      )
                    ],
                  )
              ),
              const SizedBox(height: 25),
              Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Categories", style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 18, fontWeight: FontWeight.w700)),
                        GestureDetector(
                          onTap: _showDepartmentInfo,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xff62cff4).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.info_outline,
                              color: const Color(0xff2c67f2),
                              size: 20,
                            ),
                          ),
                        ),
                      ]
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 180,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 25,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                              transition: Transition.rightToLeft,
                                  () => index == 0 ? const ManualPage() :
                              index == 1 ? const ProjectPage() :
                              index == 2 ? const ExamsPage() :
                              index == 3 ? const VLabPage() :
                              const HomePage()
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: const Color(0xff62cff4).withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 4))]
                            ),
                            child: Column(
                                children: [
                                  SizedBox(height: 110, width: 100, child: Image.asset(categoryDetails[index]["img"])),
                                  const SizedBox(height: 20),
                                  Text(categoryDetails[index]["title"], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
                                ]
                            )
                        ),
                      );
                    },
                    itemCount: categoryDetails.length
                ),
              ),
              SizedBox(height: 20), // Add some bottom padding
            ]
        ),
      ),

    );
  }
}