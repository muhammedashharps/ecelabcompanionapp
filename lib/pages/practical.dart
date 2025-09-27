import 'package:flutter/material.dart';
import 'package:ececompanion/models/practice.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class Practical extends StatefulWidget {
  const Practical({super.key});

  @override
  State<Practical> createState() => _PracticalState();
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
class _PracticalState extends State<Practical> {
  List <practicalResources> emergencyCat = practicalResources.getResources();
  @override

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change this color as needed
      statusBarIconBrightness: Brightness.dark, // Adjust icon brightness
    ));
    return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ upper(),
                    const SizedBox(height:40),
                    secondary(),
                    const SizedBox(height:20),
                    data("Newsletters", "https://drive.google.com/drive/folders/1vOBq1YGBJCiCEoW4CL7AedpDwRz4KxJr?usp=sharing", Icons.mail),
                    const SizedBox(height:20),
                    data("MOOC Course Details", "https://forms.gle/kJK8bAQgxKSvNFwo7", Icons.earbuds),
                    const SizedBox(height:20),
                    data("Internship Details", "https://forms.gle/Zah4rryQ97GRFMGf9", Icons.account_balance),
                    const SizedBox(height:20),
                    data("Higher Study Details", "https://forms.gle/YdJgEwpsdwDBKPU79", Icons.accessibility_new),
                    const SizedBox(height:20),
                    data("Event Details", "https://forms.gle/tawu1ziWUXjgdhwv8", Icons.account_tree_rounded),
                    const SizedBox(height:50),
                    const Text("Theory Sparks, Practice Ignites",textAlign: TextAlign.left, style: TextStyle(color: Colors.grey)),
                    const SizedBox(height:30),
                    third()
                  ],

                ),
              ),
            ),

      );

  }

  Widget upper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(onTap:(){Get.back();},child: const Icon(Icons.arrow_back_outlined)),
          const SizedBox(width:20),
          const Text("Resources", style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 17, letterSpacing: 1.3
          )),

        ]
    );
  }

  Widget secondary() {
    return Container(
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff62cff4).withOpacity(0.2),
              blurRadius: 40,// Shadow color
              offset: const Offset(0, 10), // Shadow position
            ),
          ],),
        child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: ()=> openUrl(context,"https://chat.whatsapp.com/CFuFAN4zzv0BVGIb64iVQ7"),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        Icon(Icons.message, color: Colors.green,size: 35,),
                        SizedBox(width:10),
                        Text("Join Whatsapp Study Groups", style: TextStyle(fontWeight: FontWeight.bold))]),
                  Icon(Icons.arrow_forward_ios_outlined, size: 18, color: Colors.grey,)
                ]
            ),
          ),
        )
    );
  }

  Widget data(String name, String link, IconData icons) {
    return Container(
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff62cff4).withOpacity(0.2),
              blurRadius: 40,// Shadow color
              offset: const Offset(0, 10), // Shadow position
            ),
          ],),
        child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: ()=> openUrl(context,link),
            child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        Icon(icons, color: Colors.green,size: 35,),
                        SizedBox(width:10),
                        Text(name, style: TextStyle(fontWeight: FontWeight.bold))]),
                  Icon(Icons.arrow_forward_ios_outlined, size: 18, color: Colors.grey,)
                ]
            ),
          ),
        )
    );
  }

  Widget third() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true, scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: ()=> openUrl(context,emergencyCat[index].url),
          child: Container(
            height:100,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: const Color(0xff62cff4).withOpacity(0.2),
                blurRadius: 20,// Shadow color
                offset: const Offset(0, 4), // Shadow position
              ),
            ] ,borderRadius: BorderRadius.circular(10.0), color: emergencyCat[index].containerColor.withOpacity(0.5),
          ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        const SizedBox(width:10),
                        Text(emergencyCat[index].name, style: const TextStyle(fontWeight: FontWeight.bold))]
                  ),
                  const Icon(Icons.arrow_forward_outlined, size: 22, color: Colors.black,)
                ],
              ),
            ),
        ));
      },
      separatorBuilder: (context, index) => const SizedBox(height:15),
      itemCount: emergencyCat.length,

    );





  }
}

