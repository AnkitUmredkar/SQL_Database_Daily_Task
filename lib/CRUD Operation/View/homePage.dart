import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../Controller/homeController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade800,
          toolbarHeight: 70,
          centerTitle: true,
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: const Text(
            'Budget',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.currency_rupee,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                  child: ListView.builder(
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Card(
                              color: Colors.indigo.shade50,
                              child: ListTile(
                                onTap: () {
                                    controller.txtCategory.text =
                                    controller.data[index]['category'];
                                    controller.txtAmount.text = controller
                                        .data[index]['amount']
                                        .toString();
                                    controller.groupValue.value =
                                    (controller.data[index]['isIncome'] == 1)
                                        ? 'Income'
                                        : 'Expense';
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
                                            const SizedBox(height: 8),
                                            buildTextField(controller.txtCategory,
                                                'Category'),
                                            const SizedBox(height: 18),
                                            buildTextField(
                                                controller.txtAmount, 'Amount'),
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
                                                          groupValue: controller
                                                              .groupValue.value,
                                                          onChanged: (value) {
                                                            controller.setIncome(
                                                                value!);
                                                          }),
                                                      // const SizedBox(
                                                      //   width: 4,
                                                      // ),
                                                      const Text('Income'),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.min,
                                                    children: [
                                                      Radio(
                                                          value: "Expense",
                                                          groupValue: controller
                                                              .groupValue.value,
                                                          onChanged: (value) {
                                                            controller.setIncome(
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
                                              style:
                                              TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if(controller.txtAmount.text != '' && controller.txtCategory.text != ''){
                                                int id =
                                                controller.data[index]['id'];
                                                double amount = double.parse(
                                                    controller.txtAmount.text);
                                                int isIncome =
                                                controller.groupValue.value ==
                                                    'Income'
                                                    ? 1
                                                    : 0;
                                                String category =
                                                    controller.txtCategory.text;
                                                controller.updateData(
                                                    amount, isIncome, category, id);
                                                Get.back();
                                                Fluttertoast.showToast(
                                                  msg: 'Record update successfully',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16,
                                                );
                                              }
                                              else{
                                                Fluttertoast.showToast(
                                                  msg: 'All field must be required',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 16,
                                                );
                                              }
                                            },
                                            child: const Text(
                                              'Save',
                                              style:
                                              TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                },
                                leading: Container(
                                  padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: controller.data[index]['isIncome'] == 1
                                          ? Colors.greenAccent.shade100
                                          : Colors.redAccent.shade100,
                                      shape: BoxShape.circle
                                    ),
                                  child: Text(controller.data[index]['id'].toString(),
                                  ),
                                ),
                                title: Text(controller.data[index]['category']),
                                subtitle: Text(controller.data[index]['amount'].toString()),
                                trailing: IconButton(
                                    onPressed: () {
                                      controller.deleteRecord(
                                          controller.data[index]['id']);
                                      Fluttertoast.showToast(
                                        msg: 'Record delete successfully',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16,
                                      );
                                    },
                                    icon: Icon(Icons.delete,color: Colors.indigo.shade400,)),
                              ),
                            ),
                          )),
                ),
              ),
              const SizedBox(height: 75),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 29),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.totalIncome.value =
                        controller.totalExpense.value = 0;
                    for (var elem in controller.data) {
                      if (elem['isIncome'] == 1) {
                        controller.totalIncome.value += elem['amount'];
                      } else {
                        controller.totalExpense.value += elem['amount'];
                      }
                    }
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
                            Text(
                                'Income : ₹ ${controller.totalIncome.value.toString()}'),
                            const SizedBox(height: 10),
                            Text(
                                'Expense : ₹ ${controller.totalExpense.value.toString()}'),
                            const SizedBox(height: 10),
                            Text(
                                'Total Savings : ₹ ${(controller.totalIncome.value - controller.totalExpense.value).toString()}'),
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
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(8.5, 8.5),
                          color: Colors.black87,
                          blurRadius: 10),
                    ]),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          size: 19,
                        ),
                        Text(' Checkout Budget')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: GestureDetector(
                  onTap: () {
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
                            buildTextField(controller.txtCategory, 'Category'),
                            const SizedBox(height: 10),
                            buildTextField(controller.txtAmount, 'Amount'),
                            const SizedBox(height: 10),
                            Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio(
                                          value: "Income",
                                          groupValue:
                                              controller.groupValue.value,
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
                                          groupValue:
                                              controller.groupValue.value,
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
                                double amount =
                                    double.parse(controller.txtAmount.text);
                                int isIncome =
                                    controller.groupValue.value == 'Income'
                                        ? 1
                                        : 0;
                                String category = controller.txtCategory.text;
                                controller.insertRecord(
                                    amount, isIncome, category);
                                Fluttertoast.showToast(
                                  msg: 'Record added successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16,
                                );
                                Get.back();
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'All field must be required',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16,
                                );
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
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          offset: Offset(8.5, 8.5),
                          color: Colors.black87,
                          blurRadius: 10),
                    ]),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.add), Text(' Add Record')],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
