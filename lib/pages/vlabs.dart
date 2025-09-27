import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class VLabPage extends StatefulWidget {
  const VLabPage({super.key});

  @override
  State<VLabPage> createState() => _VLabState();
}

class _VLabState extends State<VLabPage> {
  List vlabDetails = [];
  Future <void> _initData() async {
    String vlabData= await DefaultAssetBundle.of(context).loadString("json/vlab.json");
    setState(() {
      vlabDetails = jsonDecode(vlabData);
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

    // Set the status bar color for this screen
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue, // Change this color as needed
      statusBarIconBrightness: Brightness.light, // Adjust icon brightness
    ));
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
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffEAF7FC),
          body: SingleChildScrollView(
            child: Column(
                children :[
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(top:15, left:18),
                      width:MediaQuery.of(context).size.width,
                      height: 65,
                      child:
                      const Row(

                        children: [
                          Spacer(),Text("Virtual Labs", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),Spacer()
                        ],
                      )
                  ),
                  GridView.builder(physics: const NeverScrollableScrollPhysics(),padding: const EdgeInsets.all(70), shrinkWrap: true,gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 100,
                      mainAxisExtent: 290

                    ),
                        itemBuilder:(context, index) {
                      return Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white,boxShadow:[BoxShadow(color: const Color(0xff62cff4).withOpacity(0.2),blurRadius: 20,offset: const Offset(0,4))]),
                                child:
                                Column(
                                    children :[
                                      Container(padding: const EdgeInsets.all(10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: Colors.white, boxShadow:[BoxShadow(color: const Color(0xff62cff4).withOpacity(0.2),blurRadius: 20,offset: const Offset(0,4))]),height:100, width:130, child: Image.asset(vlabDetails[index]["img"])),
                                      const SizedBox(height: 20),
                                      FittedBox(fit: BoxFit.scaleDown,child: Text(vlabDetails[index]["title"], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
                                      const Spacer(),
                                      MaterialButton(onPressed: ()=> openUrl(context,vlabDetails[index]["url"]),height:30,minWidth: 180,elevation: 0,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),color: const Color(0xff62cff4),child:const Text("Visit", style: TextStyle(color:Colors.white, fontWeight: FontWeight.w600)),)
                                    ]
                                )
                          );
                        },
                        itemCount: vlabDetails.length),

                ]
            ),
          )


      ),
    );
  }
}
