import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/webview_loading.dart';


class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ManualPageState();
}

class _ManualPageState extends State<ExamsPage> {
  List examDetails = [];
  final InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      useOnDownloadStart: true,
    ),
  );



  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Change this color as needed
      statusBarIconBrightness: Brightness.light, // Adjust icon brightness
    ));
    _initData();
  }

  void openUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }




  Future<void> _initData() async {
    String examData = await DefaultAssetBundle.of(context).loadString("json/exams.json");
    setState(() {
      examDetails = jsonDecode(examData);
    });
  }



  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEAF7FC),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 18),
              width: MediaQuery.of(context).size.width,
              height: 65,
              child: const Row(
                children: [
                  Spacer(),
                  Text("Exams", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return Container(

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
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
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
                          child: Image.asset(examDetails[index]["img"]),
                        ),
                        const SizedBox(height: 10),
                        Text(examDetails[index]["title"], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                        const SizedBox(height: 20),
                        MaterialButton(
                          onPressed: () {
                            if (["GATE", "UPSC", "IELTS", "Semester 8" "M-TECH"].contains(examDetails[index]["title"])) {
                              openUrl(context, examDetails[index]["link"]);

                            } else {
                              _openWebView(examDetails[index]["link"], examDetails[index]["title"] );
                            }
                          },
                          height: 30,
                          minWidth: 150,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          color: const Color(0xff62cff4),
                          child: const Text("View", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: examDetails.length,
              ),
            ),
          ],
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
