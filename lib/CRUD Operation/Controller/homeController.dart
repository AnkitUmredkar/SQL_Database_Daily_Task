import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Helper/dbHelper.dart';
import '../View/homePage.dart';

class HomeController extends GetxController
{

  late TabController tabController;
  RxList data = [].obs;//,permenentList = [].obs;
  RxBool isIncome = false.obs;
  RxString groupValue = 'Income'.obs;
  RxDouble totalIncome = 0.0.obs,totalExpense = 0.0.obs;
  Rx<File?> fileImage = Rx<File?>(null);
  Rx<XFile?> xFileImage = Rx<XFile?>(null);
  RxInt currentIndex = 0.obs;

  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtCategory = TextEditingController();

  @override
  void onInit(){
    super.onInit();
    initDb();
  }

  void changePageByIndex(newIndex){
    currentIndex.value = newIndex;
  }

  void setIncome(String value)
  {
    groupValue.value = value.toString();
  }

  Future initDb()async{
    await DbHelper.dbHelper.database;
    await getRecords();
  }

  Future insertRecord(amount, isIncome, category,img)async{
    await DbHelper.dbHelper.insertData(amount, isIncome, category,img);
    await getRecords();
  }

  Future getRecords()async{
    totalExpense.value = 0.0;
    totalIncome.value = 0.0;
    data.value = await DbHelper.dbHelper.viewAllData();
    // permenentList.value = await DbHelper.dbHelper.viewAllData();
    for (var elem in data) {
      if (elem['isIncome'] == 1) {
        totalIncome.value += elem['amount'];
      } else {
        totalExpense.value += elem['amount'];
      }
    }
    update();
    totalIncome.refresh();
    totalExpense.refresh();
    return data;
  }

  Future getSelectedRecord(int isIncome) async {
    data.value = await DbHelper.dbHelper.getSelectedData(isIncome);
  }

  Future deleteRecord(int id) async {
    await DbHelper.dbHelper.deleteData(id);
    await getRecords();
  }

  Future updateRecord(amount, isIncome, category, img, id) async {
    await DbHelper.dbHelper.updateData(amount, isIncome, category, img, id);
    await getRecords();
  }

  void pickImage(){
    fileImage.value = File(xFileImage.value!.path);
  }

}