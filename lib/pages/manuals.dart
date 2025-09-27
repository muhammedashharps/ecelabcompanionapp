import 'package:ececompanion/pages/practical.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:ececompanion/models/pdfreader.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/webview_loading.dart';


class ManualPage extends StatefulWidget {
  const ManualPage({super.key});

  @override
  State<ManualPage> createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  List manualDetails = [];
  Future <void> _initData() async {
    String manualData= await DefaultAssetBundle.of(context).loadString("json/manuals.json");
    setState(() {
      manualDetails = jsonDecode(manualData);
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
  Future<bool> _checkIfFileExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool _isUrl(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEAF7FC),
        body: Column(
            children :[
              Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top:15, left:18),
                  width:MediaQuery.of(context).size.width,
                  height: 65,
                  child:
                  const Row(
                    children: [
                      Spacer(),Text("Manuals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),Spacer()
                    ],
                  )
              ),
              Expanded(
                child: GridView.builder(padding: const EdgeInsets.all(20),gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,



                ),
                    itemBuilder:(context, index) {
                      return  Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white,boxShadow:[BoxShadow(color: const Color(0xff62cff4).withOpacity(0.2),blurRadius: 20,offset: const Offset(0,4))]),
                          child:
                          Column(
                              children :[
                                Container(padding: const EdgeInsets.all(20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.white, boxShadow:[BoxShadow(color: const Color(0xff62cff4).withOpacity(0.2),blurRadius: 20,offset: const Offset(0,4))]),height:100, width:130, child: Image.asset(manualDetails[index]["img"])),
                                const SizedBox(height: 10),
                                Text(manualDetails[index]["subtitle"], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                const SizedBox(height:20),
                                MaterialButton(onPressed: () async {
                                  String pdfPath = manualDetails[index]["pdf"];

                                  if (_isUrl(pdfPath)) {
                                    // Handle URL - open in webview
                                    openUrl(context, manualDetails[index]["pdf"]);
                                  } else {
                                    // Handle local asset - check if file exists first
                                    bool fileExists = await _checkIfFileExists(pdfPath);
                                    if (fileExists) {
                                      Get.to(() => PDFViewerScreen(assetPath: pdfPath));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.white,
                                          content: Text("Coming Soon", style: TextStyle(color: Colors.black)),
                                        ),
                                      );
                                    }
                                  }
                                },

                                  height:30,minWidth: 150,elevation: 0,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),color: const Color(0xff62cff4),child:const Text("View", style: TextStyle(color:Colors.white, fontWeight: FontWeight.w600)),),
                              ]

                          )


                      );
                    },
                    itemCount: manualDetails.length),
              ),

            ]
        ),



      ),
    );
  }

}