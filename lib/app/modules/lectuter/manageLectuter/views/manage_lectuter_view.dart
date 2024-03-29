import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../responsive.dart';
import '../../../../data/responses/lectuter_service_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/utils.dart';
import '../../../address/views/address_view.dart';
import '../controllers/manage_lectuter_controller.dart';

class ManageLectuterView extends StatelessWidget {
  ManageLectuterView({super.key});
  final ManageLectuterController controller =
      Get.put(ManageLectuterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "วิทยากรประชาธิปไตย",
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
                    child: ManageDataTableLectuter(),
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
                    child: ManageDataTableLectuter(),
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
  final ManageLectuterController controller =
      Get.put(ManageLectuterController());
  final _formKeyLectuter = GlobalKey<FormState>();
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
                  actionMenu(_formKeyLectuter),
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
          key: _formKeyLectuter,
          child: Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressView(
                    showPostCode: false,
                    showAmphure: false,
                    showTambol: false,
                  ),
                  CustomText(
                    text: "คำนำหน้า",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.lectuterPreName,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "ชื่อ",
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
                    controller: controller.lectuterFirstName,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก ชื่อ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "นามสกุล",
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
                    controller: controller.lectuterSurName,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก นามสกุล';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "เบอร์โทร",
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
                    controller: controller.lectuterTelephone,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก เบอร์โทร';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "LINE ID",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.lectuterLine,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "Facebook",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.lectuterFacebook,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "หน่วยงาน",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.lectuterAgency,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "สังกัดวิทยากร",
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
                      value: controller.selectedLectuterAffiliate.value,
                      onChanged: (newValue) {
                        controller.selectedLectuterAffiliate.value = newValue!;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาเลือก สังกัดวิทยากร';
                        }
                        return null;
                      },
                      items: controller.lectuterAffiliateList.obs.value
                          .map((item) {
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
                  CustomText(
                    text: "ประสบการณ์การเป็นวิทยากร",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.lectuterExp,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      IconButton(
                        icon: const Icon(Icons.add_sharp),
                        onPressed: () {
                          controller.addLectuterExpToChip(
                            controller.lectuterExp.text,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Obx(
                    () => Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: controller.lectuterExpChips.obs.value
                          .map((chip) => Chip(
                                backgroundColor: Colors.blue.shade100,
                                label: Text(chip),
                                onDeleted: () =>
                                    controller.deleteLectuterExpToChip(chip),
                              ))
                          .toList(),
                    ),
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
              //     final isValid = _formKeyLectuter.currentState!.validate();
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
                  controller.lectuterList.clear();
                  controller.lectuterController.offset.value = 0;
                  controller.lectuterController.currentPage = 1;
                  controller.lectuterController.listLectuterStatistics.clear();
                  controller.resetForm();
                  controller.dashboardController.listProvinceSummary.clear();
                  await controller.dashboardController
                      .listProvinceSummaryDashboard();
                  await controller.infoCardController.getSummaryInfo();
                  await controller.lectuterController.listLectuterAffiliate();
                  await controller.lectuterController.listLectuter();
                  Get.back();
                  Get.toNamed(Routes.LECTUTER);
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
            final isValid = _formKeyLectuter.currentState!.validate();
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

class ManageDataTableLectuter extends StatelessWidget {
  ManageDataTableLectuter({
    super.key,
  });
  final ManageLectuterController controller =
      Get.put(ManageLectuterController());

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
            controller.lectuterList.obs.value.length,
            (index) => Responsive.isLargeScreen(context)
                ? lectuterDataRow(
                    index,
                    controller.lectuterList.obs.value[index],
                    controller,
                  )
                : lectuterDataRowSmall(
                    index,
                    controller.lectuterList.obs.value[index],
                    controller,
                  ),
            // (index) => StationDataRow(
            //     index, controller.commissList.obs.value[index]),
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
    label: CustomText(text: "คำนำหน้า", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "ชื่อ", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "นามสกุล", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "หน่วยงาน", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "สังกัดวิทยากร", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "เบอร์ไทร", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow lectuterDataRow(
  int index,
  LectuterData lectuterData,
  ManageLectuterController controller,
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
      // controller.selectDataFromTable(index);
      await controller.selectDataFromTable(index, lectuterData.id!);
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
              lectuterData.lectuterPreName!,
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
              lectuterData.lectuterFirstName!,
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
              lectuterData.lectuterSurName!,
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
              lectuterData.lectuterAgency!,
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
              lectuterData.lectuterAffiliate!,
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
              lectuterData.lectuterTelephone!,
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

List<DataColumn> listColumnSmall = [
  const DataColumn2(
    label: CustomText(text: "ชื่อ", scale: 0.9),
    size: ColumnSize.M,
  ),
];

DataRow lectuterDataRowSmall(
  int index,
  LectuterData lectuterData,
  ManageLectuterController controller,
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
              lectuterData.name!,
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
