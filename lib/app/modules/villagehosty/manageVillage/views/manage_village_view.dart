import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../responsive.dart';
import '../../../../data/responses/village_service_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/utils.dart';
import '../../../address/views/address_view.dart';
import '../controllers/manage_village_controller.dart';

class ManageVillageView extends StatelessWidget {
  ManageVillageView({super.key});
  final ManageVillageController controller = Get.put(ManageVillageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "หมู่บ้านพลเมืองดีวิถีประชาธิปไตย",
                color: Colors.white,
                scale: 0.9,
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
                    child: ManageDataTableVillage(),
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
                    child: ManageDataTableVillage(),
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
  final ManageVillageController controller = Get.put(ManageVillageController());
  final _formKeyVillage = GlobalKey<FormState>();
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
                  actionMenu(_formKeyVillage),
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
          key: _formKeyVillage,
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
                        text: "ชื่อหมู่บ้าน",
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
                    controller: controller.villageName,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก ชื่อหมู่บ้าน';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "บ้านเลขที่/หมู่บ้าน",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.villageNo,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: defaultPadding),
                  AddressView(showPostCode: false),
                  CustomText(
                    text: "จำนวนครัวเรือน",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.villageTotal,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "Facebook/Location",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.villageLocation,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "รูปแบบกิจกรรม",
                              color: Colors.black87.withOpacity(.9),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            TextFormField(
                              controller: controller.villageTypeAct,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: defaultPadding),
                            CustomText(
                              text: "รายละเอียด",
                              color: Colors.black87.withOpacity(.9),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            TextFormField(
                              controller: controller.villageGoalAct2,
                              keyboardType: TextInputType.text,
                              maxLines: 3,
                            ),
                            const SizedBox(height: defaultPadding),
                          ],
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      IconButton(
                        icon: const Icon(Icons.add_sharp),
                        onPressed: () {
                          controller.addTypeActToChip(
                            controller.villageTypeAct.text,
                            controller.villageGoalAct2.text,
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
                      children: controller.typeActChips.obs.value
                          .map((chip) => Chip(
                                backgroundColor: Colors.blue.shade100,
                                label: Text(chip),
                                onDeleted: () =>
                                    controller.deleteTypeActToChip(chip),
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
              //     final isValid = _formKeyVillage.currentState!.validate();
              //     if (isValid) {
              //       if (controller.addressController.selectedProvince.value !=
              //               '' &&
              //           controller.addressController.selectedAmphure.value !=
              //               '' &&
              //           controller.addressController.selectedTambol.value !=
              //               '') {
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
              //             content: const Text('กรุณาเลือก จังหวัด/อำเภอ/ตำบล'),
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
                  controller.addressController.selectedAmphure.value = '';
                  controller.addressController.selectedTambol.value = '';
                  controller.filePath.value = '';
                  controller.villageList.clear();
                  controller.villageController.offset.value = 0;
                  controller.villageController.currentPage = 1;
                  controller.villageController.listVillageStatistics.clear();
                  controller.resetForm();
                  controller.dashboardController.listProvinceSummary.clear();
                  await controller.dashboardController
                      .listProvinceSummaryDashboard();
                  await controller.infoCardController.getSummaryInfo();
                  await controller.villageController.listVillage();
                  Get.back();
                  Get.toNamed(Routes.VILLAGEHOSTY);
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
              if (controller.addressController.selectedProvince.value != '' &&
                  controller.addressController.selectedAmphure.value != '' &&
                  controller.addressController.selectedTambol.value != '') {
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
                    content: const Text('กรุณาเลือก จังหวัด/อำเภอ/ตำบล'),
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

class ManageDataTableVillage extends StatelessWidget {
  ManageDataTableVillage({
    super.key,
  });
  final ManageVillageController controller = Get.put(ManageVillageController());

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
            controller.villageList.obs.value.length,
            (index) => Responsive.isLargeScreen(context)
                ? villageDataRow(
                    index,
                    controller.villageList.obs.value[index],
                    controller,
                  )
                : villageDataRowSmall(
                    index,
                    controller.villageList.obs.value[index],
                    controller,
                  ),
            // (index) => StationDataRow(
            //     index, controller.villageList.obs.value[index]),
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
    label: CustomText(text: "ชื่อหมู่บ้าน", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "บ้านเลขที่/หมู่บ้าน", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "จังหวัด/อำเภอ/ตำบล", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "จำนวนครัวเรือน", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow villageDataRow(
  int index,
  VillageData villageData,
  ManageVillageController controller,
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
    onSelectChanged: (value) {
      controller.selectDataFromTable(index, villageData.id!);
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
              villageData.villageName!,
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
              villageData.villageNo!,
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
              "${villageData.province}/${villageData.amphure}/${villageData.district}",
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
              formatterItem.format(villageData.villageTotal),
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

DataRow villageDataRowSmall(
  int index,
  VillageData villageData,
  ManageVillageController controller,
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
    onSelectChanged: (value) {
      controller.selectDataFromTable(index, villageData.id!);
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
              villageData.villageName!,
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
