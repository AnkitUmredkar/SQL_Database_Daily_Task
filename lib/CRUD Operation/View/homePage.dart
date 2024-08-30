import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Controller/homeController.dart';

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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0],
              colors: [
                Color(0xffD83B44), // A shade of red
                Color(0xFF351A2B), // A darker shade of red
                Color(0xFF131424), // A very dark, almost black shade
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            )),
                        Text(
                          'My Wallet',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            return checkoutBill(controller, context);
                          },
                          icon: const Icon(Icons.currency_rupee),
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 30),
                    decoration: BoxDecoration(
                        color: const Color(0xff131426),
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${(controller.totalExpense.value < controller.totalIncome.value) ? (controller.totalIncome.value - controller.totalExpense.value).toString() : 0.0} /-',
                              style: TextStyle(
                                  fontSize: width * 0.054,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: Color(0xff09B9D6),
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Your Statement',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white,fontSize: width * 0.041),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.getSelectedRecord(1);
                         },
                          child: _buildOverviewItem(
                            icon: Icons.attach_money,
                            label: 'Income',
                            percentage: (controller.totalIncome.value +
                                        controller.totalExpense.value >
                                    0)
                                ? (controller.totalIncome.value /
                                        (controller.totalIncome.value +
                                            controller.totalExpense.value)) *
                                    100
                                : 0.0,
                            color: Colors.green.shade600,
                              width: width
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.getSelectedRecord(0);
                          },
                          child: _buildOverviewItem(
                            icon: Icons.money_off,
                            label: 'Expenses',
                            percentage: (controller.totalIncome.value +
                                        controller.totalExpense.value >
                                    0)
                                ? (controller.totalExpense.value /
                                        (controller.totalIncome.value +
                                            controller.totalExpense.value)) *
                                    100
                                : 0.0,
                            color: Colors.red.shade600,
                              width: width
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.getRecords();
                          } ,
                          child: _buildOverviewItem(
                            icon: Icons.money_off,
                            label: 'Savings',
                            percentage: (controller.totalExpense.value <
                                    controller.totalIncome.value)
                                ? ((controller.totalIncome.value -
                                            controller.totalExpense.value) *
                                        100 /
                                        (controller.totalIncome.value +
                                            controller.totalExpense.value))
                                    .toDouble()
                                : 0.0,
                            color: Colors.blue.shade600,
                            width: width
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white,fontSize: width * 0.041),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 6),
                      child: ListView.builder(
                          itemCount: controller.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 3),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.indigo.withOpacity(0.4),
                                    border: Border(
                                        right: BorderSide(
                                            color: Colors.amber.shade700,
                                            width: 18))),
                                child: ListTile(
                                  onTap: () {
                                    controller.txtCategory.text =
                                        controller.data[index]['category'];
                                    controller.txtAmount.text = controller
                                        .data[index]['amount']
                                        .toString();
                                    controller.groupValue.value =
                                        (controller.data[index]['isIncome'] ==
                                                1)
                                            ? 'Income'
                                            : 'Expense';
                                    // controller.fileImage.value =
                                    //     File(controller.data[index]['img']);
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text(
                                          'Update Record',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // GestureDetector(
                                            //   onTap: () async {
                                            //     ImagePicker imagePicker =
                                            //         ImagePicker();
                                            //     controller.xFileImage.value =
                                            //         (await imagePicker
                                            //             .pickImage(
                                            //                 source: ImageSource
                                            //                     .gallery));
                                            //     controller.pickImage();
                                            //   },
                                            //   child: Obx(
                                            //     () => CircleAvatar(
                                            //       radius: 28,
                                            //       backgroundImage: controller
                                            //                   .fileImage
                                            //                   .value !=
                                            //               null
                                            //           ? FileImage(controller
                                            //               .fileImage.value!)
                                            //           : null,
                                            //       child: controller.fileImage
                                            //                   .value ==
                                            //               null
                                            //           ? const Icon(
                                            //               Icons.add_a_photo)
                                            //           : null,
                                            //     ),
                                            //   ),
                                            // ),
                                            const SizedBox(height: 8),
                                            buildTextField(
                                                controller.txtCategory,
                                                'Category'),
                                            const SizedBox(height: 18),
                                            buildTextField(
                                                controller.txtAmount,
                                                'Amount'),
                                            const SizedBox(height: 10),
                                            Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Radio(
                                                          value: "Expense",
                                                          groupValue:
                                                              controller
                                                                  .groupValue
                                                                  .value,
                                                          onChanged: (value) {
                                                            controller
                                                                .setIncome(
                                                                    value!);
                                                          }),
                                                      // const SizedBox(
                                                      //   width: 4,
                                                      // ),
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
                                              style: TextStyle(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (controller.txtAmount.text != '' && controller.txtCategory.text != '') {
                                                double amount = double.parse(controller.txtAmount.text);
                                                int isIncome = controller.groupValue.value == 'Income' ? 1 : 0;
                                                String category = controller.txtCategory.text;
                                                String img = 'https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80';//controller.fileImage.value!.path.toString();
                                                int id = controller.data[index]['id'];
                                                controller.updateRecord(
                                                    amount,
                                                    isIncome,
                                                    category,
                                                    img,
                                                    id);
                                                Get.back();
                                                showMsg('Record update successfully');
                                              } else {
                                                showMsg(
                                                    'All field must be required');
                                              }
                                            },
                                            child: const Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: controller.data[index]['isIncome'] == 1
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                    child: Icon(
                                      controller.data[index]['isIncome'] == 1
                                          ? Icons.attach_money
                                          : Icons.money_off,
                                      color: controller.data[index]['isIncome'] == 1
                                          ? Colors.green.shade900
                                          : Colors.red.shade900,
                                    ),
                                  ),
                                  //todo img which is store in database
                                  // Container(
                                  //   height: 55,
                                  //   width: 55,
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(
                                  //           color: (controller.data[index]
                                  //           ['isIncome'] ==
                                  //               1)
                                  //               ? Colors.green
                                  //               : Colors.red,
                                  //           width: 1.5),
                                  //       image: DecorationImage(
                                  //         fit: BoxFit.cover,
                                  //         image: FileImage(File(
                                  //             controller
                                  //                 .data[index]['img'])),
                                  //       ),
                                  //       shape: BoxShape.circle),
                                  // ),
                                  title: Text(
                                    controller.data[index]['category'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                      controller.data[index]['amount']
                                          .toString(),
                                      style: TextStyle(color: Colors.white)),
                                  trailing: IconButton(
                                      onPressed: () {
                                        controller.deleteRecord(
                                            controller.data[index]['id']);
                                        showMsg('Record delete successfully');
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      )),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
                    buildTextField(controller.txtCategory, 'Category'),
                    const SizedBox(height: 10),
                    buildTextField(controller.txtAmount, 'Amount'),
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
    );
  }

  Future<bool?> showMsg(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  void checkoutBill(HomeController controller, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Total Budget',
          style: TextStyle(fontSize: 20),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Income : ₹ ${controller.totalIncome.value.toString()}'),
            const SizedBox(height: 10),
            Text('Expense : ₹ ${controller.totalExpense.value.toString()}'),
            const SizedBox(height: 10),
            Text(
                'Total Savings : ₹ ${(controller.totalExpense.value < controller.totalIncome.value) ? (controller.totalIncome.value - controller.totalExpense.value).toString() : 0}'),
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
        ],
      ),
    );
  }

  TextField buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black87,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1.5,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

Widget _buildOverviewItem({
  required IconData icon,
  required String label,
  required double percentage,
  required Color color,
  required double width
}) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade300.withOpacity(0.18),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeWidth: 12,
            ),
          ),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.03,
              color: Colors.white,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
