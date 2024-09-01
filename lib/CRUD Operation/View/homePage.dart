import 'dart:io';
import 'package:budget_tracker_daily_task/CRUD%20Operation/View/expense.dart';
import 'package:budget_tracker_daily_task/CRUD%20Operation/View/income.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Controller/homeController.dart';
import 'homeContent.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    HomeController controller = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   toolbarHeight: 70,
        //   centerTitle: true,
        //   leading: const Icon(
        //     Icons.menu,
        //     color: Colors.white,
        //   ),
        //   title: const Text(
        //     'Budget',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   actions: [
        //     IconButton(
        //         onPressed: () {},
        //         icon: const Icon(
        //           Icons.currency_rupee,
        //           color: Colors.white,
        //         ))
        //   ],
        //   bottom: TabBar(
        //       tabAlignment: TabAlignment.start,
        //       padding: EdgeInsets.zero,
        //       labelStyle: const TextStyle(
        //         color: Colors.white70,
        //       ),
        //       indicatorColor: Colors.transparent,
        //       //todo indicatorWeight: 1,
        //       unselectedLabelStyle: const TextStyle(
        //         fontWeight: FontWeight.normal,
        //         color: Colors.grey,
        //       ),
        //       unselectedLabelColor: Colors.white70,
        //       isScrollable: true,
        //       tabs: [
        //         GestureDetector(
        //           onTap: () {
        //
        //             controller.getSelectedRecord(1);
        //           },
        //           child: const Tab(
        //             child: Row(
        //               children: [Icon(Icons.attach_money), Text(' Income')],
        //             ),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             controller.getSelectedRecord(0);
        //           },
        //           child: const Tab(
        //               child: Row(
        //             children: [
        //               Icon(Icons.payments_outlined),
        //               Text(' Expense')
        //             ],
        //           )),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             controller.getRecords();
        //           },
        //           child: const Tab(
        //               child: Row(
        //             children: [Icon(Icons.savings), Text(' Savings')],
        //           )),
        //         ),
        //       ]),
        // ),
        body: Obx(
          () =>  IndexedStack(
            index: controller.currentIndex.value,
            children: const [
              HomeContent(),
              IncomePage(),
              ExpensePage(),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 45),
          child: FloatingActionButton(
            onPressed: () {
              // controller.fileImage = Rx<File?>(null);
              controller.txtCategory.clear();
              controller.txtAmount.clear();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add Record'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //todo ----------------------> image picker
                      // GestureDetector(
                      //   onTap: () async {
                      //     ImagePicker imagePicker = ImagePicker();
                      //     controller.xFileImage.value =
                      //     (await imagePicker
                      //         .pickImage(
                      //         source: ImageSource.gallery));
                      //     controller.pickImage();
                      //   },
                      //   child: Obx(
                      //         () =>
                      //         CircleAvatar(
                      //           radius: 28,
                      //           backgroundImage: controller.fileImage
                      //               .value !=
                      //               null
                      //               ? FileImage(
                      //               controller.fileImage.value!)
                      //               : null,
                      //           child: controller.fileImage.value ==
                      //               null
                      //               ? const Icon(Icons.add_a_photo)
                      //               : null,
                      //         ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      buildTextField(controller.txtCategory, 'Category',TextInputType.text),
                      const SizedBox(height: 10),
                      buildTextField(controller.txtAmount, 'Amount',TextInputType.number),
                      const SizedBox(height: 10),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                    value: "Income",
                                    groupValue: controller.groupValue.value,
                                    onChanged: (value) {
                                      controller.setIncome(value!);
                                    }),
                                const Text('Income'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                    value: "Expense",
                                    groupValue: controller.groupValue.value,
                                    onChanged: (value) {
                                      controller.setIncome(value!);
                                    }),
                                const Text('Expense'),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.txtAmount.text != '' &&
                            controller.txtCategory.text != '') {
                          double amount = double.parse(controller.txtAmount.text);
                          int isIncome =
                              controller.groupValue.value == 'Income' ? 1 : 0;
                          String category = controller.txtCategory.text;
                          String img = 'https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80';
                          controller.insertRecord(
                              amount, isIncome, category, img);
                          showMsg('Record added successfully');
                          Get.back();
                        } else {
                          showMsg('All field must be required');
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        bottomSheet: Obx(
          () =>  BottomNavigationBar(
              backgroundColor:  Colors.grey.shade900,
                onTap: controller.changePageByIndex,
                currentIndex: controller.currentIndex.value,
                selectedItemColor: Colors.amber.shade700,
                unselectedItemColor: Colors.white60,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.savings),label: 'Income'),
              BottomNavigationBarItem(icon: Icon(Icons.money_off),label: 'Expense'),
            ]),
        ),
      ),
    );
  }

}