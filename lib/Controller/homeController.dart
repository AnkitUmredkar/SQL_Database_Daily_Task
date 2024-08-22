import 'package:budget_tracker_daily_task/Helper/dbHelper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  void onInit(){
    super.onInit();
    initDb();
  }

  Future initDb()async{
    await DbHelper.dbHelper.database;
  }

  Future insertRecord()async{
    await DbHelper.dbHelper.insertData();
  }
}