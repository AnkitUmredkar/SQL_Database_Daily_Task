import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/homeController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('HomePage'),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        homeController.insertRecord();
      },child: const Icon(Icons.add),),
      ),
    );
  }
}
