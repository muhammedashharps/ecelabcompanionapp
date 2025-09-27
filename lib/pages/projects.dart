import 'package:ececompanion/pages/practical.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/webview_loading.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List projectDetails = [];

  Future<void> _initData() async {
    String projectData = await DefaultAssetBundle.of(context).loadString("json/projects.json");
    setState(() {
      projectDetails = jsonDecode(projectData);
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.blue, // Change this color as needed
    statusBarIconBrightness: Brightness.light, // Adjust icon brightness
    ));
    _initData();

  }

  Future<void> _requestPermissions() async {
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEAF7FC),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: 65,
                child: const Row(
                  children: [
                    Spacer(),
                    Text("Projects", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    Spacer(),
                  ],
                ),
              ),
               GridView.builder(
                 physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                  padding: const EdgeInsets.all(40),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 260,
                    mainAxisSpacing: 25,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff62cff4).withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff62cff4).withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            height: 100,
                            width: 130,
                            child: Image.asset(projectDetails[index]["img"]),
                          ),
                          const SizedBox(height: 10),
                          Text(maxLines: 1,projectDetails[index]["title"], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                          const SizedBox(height: 5),
                          Text(projectDetails[index]["year"], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 10)),
                          const Spacer(),
                          MaterialButton(
                            onPressed: () {
                              if (["8051 Projects Ideas", "555 Timer IC Projects"].contains(projectDetails[index]["title"])) {

                                _openWebView(projectDetails[index]["url"], projectDetails[index]["title"] );

                              } else {
                                openUrl(context, projectDetails[index]["url"]);
                              }
                            },
                            height: 30,
                            minWidth: 170,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            color: const Color(0xff62cff4),
                            child: const Text("View", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: projectDetails.length,
                ),

            ],
          ),
        ),
      ),
    );
  }

  void _openWebView(String url, String title) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    String resultString = '${connectivityResult.first}';
    if (resultString == "ConnectivityResult.none") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Check your Internet Connection and Try Again"),
          duration: Duration(seconds: 4),
        ),
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebViewContainer(url: url, title: title),
      ));
    }
  }


}
