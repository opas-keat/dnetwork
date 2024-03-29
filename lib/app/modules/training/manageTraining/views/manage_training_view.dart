import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../responsive.dart';
import '../../../../data/responses/training_service_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/utils.dart';
import '../../../address/views/address_view.dart';
import '../controllers/manage_training_controller.dart';

class ManageTrainingView extends StatelessWidget {
  ManageTrainingView({super.key});
  final ManageTrainingController controller =
      Get.put(ManageTrainingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "การฝึกอบรม",
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_sharp,
                  ),
                ),
              ],
            )
          : null,
      drawer: !Responsive.isLargeScreen(context) ? MainDrawer() : null,
      body: SafeArea(
        child: Responsive.isLargeScreen(context)
            ? Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ManageDataTableTraining(),
                  ),
                  Expanded(
                    child: ManageDataDetail(),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ManageDataTableTraining(),
                  ),
                  accentDivider,
                  Expanded(
                    flex: 3,
                    child: ManageDataDetail(),
                  ),
                ],
              ),
      ),
    );
  }
}

class ManageDataDetail extends StatelessWidget {
  ManageDataDetail({
    super.key,
  });
  final ManageTrainingController controller =
      Get.put(ManageTrainingController());
  final _formKeyTraining = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: defaultPadding),
                  actionMenu(_formKeyTraining),
                  const Padding(
                    padding: EdgeInsets.only(left: defaultPadding),
                    child: CustomText(
                      text: "รายละเอียด",
                      weight: FontWeight.bold,
                      scale: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding / 2),
        Form(
          key: _formKeyTraining,
          child: Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "ชื่อโครงการฝึกอบรม",
                        color: Colors.black87.withOpacity(.9),
                      ),
                      CustomText(
                        text: "*",
                        color: Colors.red.withOpacity(.9),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.trainingName,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก ชื่อโครงการฝึกอบรม';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "วันที่เริ่ม",
                        color: Colors.black87.withOpacity(.9),
                      ),
                      CustomText(
                        text: "*",
                        color: Colors.red.withOpacity(.9),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.trainingDateForm,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onTap: () async {
                      DateTime? newDateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (newDateTime != null) {
                        controller.trainingDateForm.text =
                            DateFormat('dd/MM/yyyy').format(newDateTime);
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก วันที่เริ่ม';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "วันที่สิ้นสุด",
                        color: Colors.black87.withOpacity(.9),
                      ),
                      CustomText(
                        text: "*",
                        color: Colors.red.withOpacity(.9),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.trainingDateTo,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onTap: () async {
                      DateTime? newDateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (newDateTime != null) {
                        controller.trainingDateTo.text =
                            DateFormat('dd/MM/yyyy').format(newDateTime);
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก วันที่สิ้นสุด';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "ประเภทการฝึกอบรม",
                        color: Colors.black87.withOpacity(.9),
                      ),
                      CustomText(
                        text: "*",
                        color: Colors.red.withOpacity(.9),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Obx(
                    () => DropdownButtonFormField<String>(
                      isDense: true,
                      isExpanded: true,
                      value: controller.selectedTrainingType.value,
                      onChanged: (newValue) {
                        controller.selectedTrainingType.value = newValue!;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาเลือก ตำแหน่งใน ศส.ปชต.';
                        }
                        return null;
                      },
                      items: controller.trainingTypeList.obs.value.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            textScaler: const TextScaler.linear(0.9),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  AddressView(
                    showAmphure: false,
                    showTambol: false,
                    showPostCode: false,
                  ),
                  CustomText(
                    text: "จำนวนผู้อบรม",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.trainingTotal,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      CustomText(
                        text: "เอกสารแนบ",
                        color: Colors.black87.withOpacity(.9),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      IconButton(
                        icon: const Icon(Icons.add_sharp),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ElevatedButton.icon(
              //   onPressed: () async {
              //     final isValid = _formKeyTraining.currentState!.validate();
              //     if (isValid) {
              //       if (controller.addressController.selectedProvince.value !=
              //           '') {
              //         Get.dialog(
              //           const Center(
              //             child: CircularProgressIndicator(),
              //           ),
              //           barrierDismissible: false,
              //         );
              //         await controller.save();
              //         Get.back();
              //       } else {
              //         Get.dialog(
              //           AlertDialog(
              //             content: const Text('กรุณาเลือก จังหวัด'),
              //             actions: [
              //               TextButton(
              //                 child: const Text("ปิด"),
              //                 onPressed: () => Get.back(),
              //               ),
              //             ],
              //           ),
              //         );
              //       }
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //         vertical: defaultPadding, horizontal: defaultPadding / 2),
              //   ),
              //   icon: const Icon(
              //     Icons.save_sharp,
              //   ),
              //   label: const CustomText(
              //     text: "บันทึก",
              //     color: Colors.white,
              //   ),
              // ),
              ElevatedButton.icon(
                onPressed: () async {
                  Get.dialog(
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false,
                  );
                  controller.selectedIndexFromTable = -1;
                  controller.addressController.selectedProvince.value = '';
                  controller.filePath.value = '';
                  controller.trainingList.clear();
                  controller.trainingController.offset.value = 0;
                  controller.trainingController.currentPage = 1;
                  controller.trainingController.listTrainingStatistics.clear();
                  controller.resetForm();
                  await controller.infoCardController.getSummaryInfo();
                  await controller.trainingController.listTrainingType();
                  await controller.trainingController.listTraining();
                  Get.back();
                  Get.toNamed(Routes.TRAINING);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding / 2),
                ),
                icon: const Icon(
                  Icons.exit_to_app_sharp,
                ),
                label: const CustomText(
                  text: "ย้อนกลับ",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row actionMenu(
    GlobalKey<FormState> formKey,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.add_sharp),
          onPressed: () async {
            final isValid = formKey.currentState!.validate();
            if (isValid) {
              if (controller.addressController.selectedProvince.value != '') {
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  barrierDismissible: false,
                );
                await controller.save();
                Get.back();
              } else {
                Get.dialog(
                  AlertDialog(
                    content: const Text('กรุณาเลือก จังหวัด'),
                    actions: [
                      TextButton(
                        child: const Text("ปิด"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                );
              }
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit_sharp),
          onPressed: () async {
            Get.dialog(
              const Center(
                child: CircularProgressIndicator(),
              ),
              barrierDismissible: false,
            );
            await controller.edit();
            Get.back();
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete_sharp),
          onPressed: () async {
            if (controller.selectedId > 0) {
              final result = await Get.dialog(
                AlertDialog(
                  content: const CustomText(
                    text: "ยืนยันการลบข้อมูล ?",
                    scale: 1.2,
                  ),
                  actions: [
                    TextButton(
                      child: const CustomText(
                        text: "ยืนยัน",
                        scale: 1.2,
                        color: Colors.red,
                      ),
                      onPressed: () => Get.back(result: 'Y'),
                    ),
                    TextButton(
                      child: const CustomText(
                        text: "ปิด",
                        scale: 1.2,
                        color: Colors.green,
                      ),
                      onPressed: () => Get.back(result: "N"),
                    ),
                  ],
                ),
              );
              if (result == 'Y') {
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  barrierDismissible: false,
                );
                await controller.delete();
                Get.back();
              }
            }
          },
        ),
        InkWell(
          hoverColor: Colors.white,
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
              maxHeight: 640,
              maxWidth: 480,
            );
            if (pickedFile != null) {
              controller.fileUpload.value = pickedFile;
              controller.filePath.value = controller.fileUpload.value.path;
              controller.update();
            }
          },
          child: Obx(() => SizedBox(
                height: 100,
                width: 100,
                child: (controller.filePath.isNotEmpty)
                    ? Image.network(
                        controller.filePath.value,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      )
                    : Image.network(
                        'assets/images/undraw_Add_files_re_v09g.png',
                        fit: BoxFit.fitHeight,
                      ),
              )),
        ),
      ],
    );
  }
}

class ManageDataTableTraining extends StatelessWidget {
  ManageDataTableTraining({
    super.key,
  });
  final ManageTrainingController controller =
      Get.put(ManageTrainingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black38,
          ),
        ),
      ),
      child: Obx(
        () => DataTable2(
          columnSpacing: defaultPadding,
          dividerThickness: 2,
          showBottomBorder: true,
          showCheckboxColumn: false,
          headingRowColor: MaterialStateProperty.resolveWith(
              (states) => Colors.grey.shade200),
          columns:
              Responsive.isLargeScreen(context) ? listColumn : listColumnSmall,
          rows: List.generate(
            controller.trainingList.obs.value.length,
            (index) => Responsive.isLargeScreen(context)
                ? trainingDataRow(
                    index,
                    controller.trainingList.obs.value[index],
                    controller,
                  )
                : trainingDataRowSmall(
                    index,
                    controller.trainingList.obs.value[index],
                    controller,
                  ),
          ),
        ),
      ),
    );
  }
}

List<DataColumn> listColumn = [
  const DataColumn2(
    label: CustomText(text: "ลำดับ", scale: 0.9),
    fixedWidth: 50,
  ),
  const DataColumn2(
    label: CustomText(text: "ชื่อโครงการฝึกอบรม", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "วันที่เริ่ม", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "วันที่สิ้นสุด", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "ประเภทการฝึกอบรม", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "จำนวนผู้อบรม", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "จังหวัด", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow trainingDataRow(
  int index,
  TrainingData trainingData,
  ManageTrainingController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    color: MaterialStateProperty.resolveWith(
      (states) {
        if ((index) == controller.selectedIndexFromTable) {
          return Colors.amber.shade200;
        } else if (index % 2 == 0) {
          return Colors.blue[50];
        } else {
          return Colors.white;
        }
      },
    ),
    onSelectChanged: (value) async {
      await controller.selectDataFromTable(index, trainingData.id!);
    },
    cells: [
      DataCell(
        Text(
          formatterItem.format(index + 1),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              trainingData.trainingName!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              trainingData.trainingDateForm!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              trainingData.trainingDateTo!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              trainingData.trainingType!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Wrap(
          children: [
            Text(
              trainingData.province!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          formatterItem.format(trainingData.trainingTotal),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

List<DataColumn> listColumnSmall = [
  const DataColumn2(
    label: CustomText(text: "ชื่อ", scale: 0.9),
    size: ColumnSize.M,
  ),
];

DataRow trainingDataRowSmall(
  int index,
  TrainingData trainingData,
  ManageTrainingController controller,
) {
  return DataRow.byIndex(
    index: index + 1,
    color: MaterialStateProperty.resolveWith(
      (states) {
        if ((index) == controller.selectedIndexFromTable) {
          return Colors.amber.shade200;
        } else if (index % 2 == 0) {
          return Colors.blue[50];
        } else {
          return Colors.white;
        }
      },
    ),
    cells: [
      DataCell(
        Wrap(
          children: [
            Text(
              trainingData.trainingName!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
