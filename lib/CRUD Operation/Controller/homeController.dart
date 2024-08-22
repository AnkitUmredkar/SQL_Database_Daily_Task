import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Helper/dbHelper.dart';

class HomeController extends GetxController
{
  RxList data = [].obs;
  RxBool isIncome = false.obs;
  RxString groupValue = 'Income'.obs;
  RxDouble totalIncome = 0.0.obs,totalExpense = 0.0.obs;

  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtCategory = TextEditingController();

  void onInit(){
    super.onInit();
    initDb();
  }

  // HomeController(){
  //   initDb();
  // }

  void setIncome(String value)
  {
    groupValue.value = value.toString();
  }

  Future initDb()async{
    await DbHelper.dbHelper.database;
    await getRecords();
  }

  Future insertRecord(amount, isIncome, category)async{
    await DbHelper.dbHelper.insertData(amount, isIncome, category);
    await getRecords();
  }

  Future getRecords()async{
    data.value = await DbHelper.dbHelper.readData();
    print(data.length.toString());
    return data;
  }

  Future deleteRecord(int id) async {
    await DbHelper.dbHelper.deleteData(id);
    await getRecords();
  }

  Future updateData(amount, isIncome, category, id) async {
    await DbHelper.dbHelper.updateData(amount, isIncome, category, id);
    await getRecords();
  }
}