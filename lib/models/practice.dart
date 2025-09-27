import 'package:flutter/material.dart';

class practicalResources {
  String name;
  Color containerColor;
  String url;


  practicalResources({
    required this.name,
    required this.containerColor,
    required this.url
  });

  static List <practicalResources> getResources() {
    List <practicalResources> practicalData = [];
    practicalData.add(practicalResources(url:"https://www.allaboutcircuits.com/",name: "All About Circuits", containerColor: const Color(
        0xA0E0FF0C)));
    practicalData.add(practicalResources(url:"https://www.youtube.com/watch?v=r-X9coYTOV4&list=PLah6faXAgguOeMUIxS22ZU4w5nDvCl5gs",name: "Beginner Electronics Tutorials", containerColor: const Color(
        0xFFDB56E1)));
    practicalData.add(practicalResources(url:"https://nssce.knimbus.com/user#/home",name: "Knimbus eLibrary Platform", containerColor: const Color(
        0xff0cead8)));
    practicalData.add(practicalResources(url:"https://www.build-electronic-circuits.com/",name: "Learn Basic Electronics", containerColor: const Color(0xff66a1ff)));
    practicalData.add(practicalResources(url:"https://www.youtube.com/watch?v=fJWR7dBuc18&list=PLGs0VKk2DiYw-L-RibttcvK-WBZm8WLEP",name: "Arduino Tutorials",  containerColor: const Color(0xffffcf98)));
    practicalData.add(practicalResources(url:"https://www.youtube.com/watch?v=Sg4GMVMdOPo&list=PLZPZq0r_RZOOkUQbat8LyQii36cJf2SWT",name: "Basics of Python", containerColor: const Color(0xff46C2A5)));

    practicalData.add(practicalResources(url:"https://www.youtube.com/watch?v=nrbBmoINqtk&list=PLZPZq0r_RZOOzY_vR4zJM32SqsSInGMwe",name: "Beginner C Tutorials", containerColor: const Color(
        0xff0cead8)));
    practicalData.add(practicalResources(url:"https://drive.google.com/drive/folders/1-Gp8vqpZPMKfgcD9zu5EVzQG_1_7j3R1?usp=drive_link",name: "LTSpice Tutorials",containerColor:const Color(0xffffcf98)));

    return practicalData;

  }
}
