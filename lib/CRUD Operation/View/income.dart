import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/homeController.dart';
import 'homeContent.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // controller.getSelectedRecord(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    HomeController controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  customaAppBar(width, controller, context),
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
                              'Your Income',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${controller.totalIncome.value} /-',
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
                              color: Color(0xff09B9D6), shape: BoxShape.circle),
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
                    'Income Overview : ${((controller.totalIncome.value + controller.totalExpense.value > 0) ? (controller.totalIncome.value / (controller.totalIncome.value + controller.totalExpense.value)) * 100 : 0.0).toStringAsFixed(2)} %',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: width * 0.041),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Recent Income',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: width * 0.041),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 50),
                      child: Obx(
                        () => ListView.builder(
                            itemCount: controller.data.length,
                            itemBuilder: (context, index) {
                              if (controller.data[index]['isIncome'] == 1) {
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
                                                width: 12))),
                                    child: ListTile(
                                      onTap: () {
                                        controller.txtCategory.text =
                                            controller.data[index]['category'];
                                        controller.txtAmount.text = controller
                                            .data[index]['amount']
                                            .toString();
                                        controller.groupValue.value =
                                            (controller.data[index]
                                                        ['isIncome'] ==
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
                                                    'Category',TextInputType.text),
                                                const SizedBox(height: 18),
                                                buildTextField(
                                                    controller.txtAmount,
                                                    'Amount',TextInputType.number),
                                                const SizedBox(height: 10),
                                                Obx(
                                                  () => Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Radio(
                                                              value: "Income",
                                                              groupValue:
                                                                  controller
                                                                      .groupValue
                                                                      .value,
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .setIncome(
                                                                        value!);
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
                                                              onChanged:
                                                                  (value) {
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
                                                  if (controller
                                                              .txtAmount.text !=
                                                          '' &&
                                                      controller.txtCategory
                                                              .text !=
                                                          '') {
                                                    double amount =
                                                        double.parse(controller
                                                            .txtAmount.text);
                                                    int isIncome = controller
                                                                .groupValue
                                                                .value ==
                                                            'Income'
                                                        ? 1
                                                        : 0;
                                                    String category = controller
                                                        .txtCategory.text;
                                                    String img =
                                                        'https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80'; //controller.fileImage.value!.path.toString();
                                                    int id = controller
                                                        .data[index]['id'];
                                                    controller.updateRecord(
                                                        amount,
                                                        isIncome,
                                                        category,
                                                        img,
                                                        id);
                                                    Get.back();
                                                    showMsg(
                                                        'Record update successfully');
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
                                        backgroundColor: controller.data[index]
                                                    ['isIncome'] ==
                                                1
                                            ? Colors.green.shade100
                                            : Colors.red.shade100,
                                        child: Icon(
                                          controller.data[index]['isIncome'] ==
                                                  1
                                              ? Icons.attach_money
                                              : Icons.money_off,
                                          color: controller.data[index]
                                                      ['isIncome'] ==
                                                  1
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
                                          style:
                                              TextStyle(color: Colors.white)),
                                      trailing: IconButton(
                                          onPressed: () {
                                            controller.deleteRecord(
                                                controller.data[index]['id']);
                                            showMsg(
                                                'Record delete successfully');
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                          )),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding customaAppBar(
      double width, HomeController controller, BuildContext context) {
    return Padding(
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
    );
  }
}
