import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/modules/address/views/address_view.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../responsive.dart';
import '../../../../data/responses/station_service_response.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/utils.dart';
import '../controllers/manage_station_controller.dart';

class ManageStationView extends StatelessWidget {
  ManageStationView({Key? key}) : super(key: key);
  final ManageStationController controller = Get.put(ManageStationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "ศส.ปชต.",
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
                    child: ManageStationDataTable(controller: controller),
                  ),
                  Expanded(
                    child: ManageStationDetail(),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ManageStationDataTable(controller: controller),
                  ),
                  accentDivider,
                  Expanded(
                    flex: 3,
                    child: ManageStationDetail(),
                  ),
                ],
              ),
      ),
    );
  }
}

class ManageStationDataTable extends StatelessWidget {
  const ManageStationDataTable({
    super.key,
    required this.controller,
  });

  final ManageStationController controller;

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
      child: Obx(() => DataTable2(
            columnSpacing: defaultPadding,
            dividerThickness: 2,
            showBottomBorder: true,
            showCheckboxColumn: false,
            headingRowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.grey.shade200),
            columns: Responsive.isLargeScreen(context)
                ? listColumn
                : listColumnLayoutSmall,
            // rows: [],
            rows: List.generate(
              controller.stationList.obs.value.length,
              (index) => Responsive.isLargeScreen(context)
                  ? stationDataRow(
                      index,
                      controller.stationList.obs.value[index],
                      controller,
                    )
                  : stationDataRowLayoutSmall(
                      index,
                      controller.stationList.obs.value[index],
                      controller,
                    ),
            ),
          )),
    );
  }
}

class ManageStationDetail extends StatelessWidget {
  ManageStationDetail({
    super.key,
  });

  final ManageStationController controller = Get.put(ManageStationController());
  final _formKeyStation = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // flex: 2,
              child: Container(
                // color: Colors.cyan,
                // padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(flex: 1),
                        IconButton(
                          icon: const Icon(Icons.add_sharp),
                          onPressed: () async {
                            final isValid =
                                _formKeyStation.currentState!.validate();
                            if (isValid) {
                              if (controller.addressController.selectedProvince
                                          .value !=
                                      '' &&
                                  controller.addressController.selectedAmphure
                                          .value !=
                                      '' &&
                                  controller.addressController.selectedTambol
                                          .value !=
                                      '') {
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
                                    content: const Text(
                                        'กรุณาเลือก จังหวัด/อำเภอ/ตำบล'),
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
                        const Spacer(flex: 1),
                        IconButton(
                          icon: const Icon(Icons.edit_sharp),
                          onPressed: () async {
                            final isValid =
                                _formKeyStation.currentState!.validate();
                            if (isValid) {
                              if (controller.addressController.selectedProvince
                                          .value !=
                                      '' &&
                                  controller.addressController.selectedAmphure
                                          .value !=
                                      '' &&
                                  controller.addressController.selectedTambol
                                          .value !=
                                      '') {
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
                                    content: const Text(
                                        'กรุณาเลือก จังหวัด/อำเภอ/ตำบล'),
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
                        const Spacer(flex: 1),
                        IconButton(
                          icon: const Icon(Icons.delete_sharp),
                          onPressed: () {
                            controller.deleteDataFromTable();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    const Padding(
                      padding: EdgeInsets.only(left: defaultPadding / 2),
                      child: CustomText(
                        text: "รายละเอียด",
                        weight: FontWeight.bold,
                        scale: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const Spacer(flex: 1),
            Expanded(
              // flex: 1,
              child: InkWell(
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
                    controller.update();
                  }
                },
                child: Obx(
                  () => SizedBox(
                    height: 100,
                    child: (controller.fileUpload.value.path.isNotEmpty)
                        ? Image.network(
                            controller.fileUpload.value.path,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          )
                        : Image.network(
                            'assets/images/undraw_Add_files_re_v09g.png',
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Expanded(
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
                      text: "ชื่อ ศส.ปชต.",
                      color: Colors.black87.withOpacity(.9),
                    ),
                    CustomText(
                      text: "*",
                      color: Colors.red.withOpacity(.9),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding / 2),
                Form(
                  key: _formKeyStation,
                  child: TextFormField(
                    controller: controller.stationName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(.8),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultPadding / 2),
                        borderSide:
                            const BorderSide(color: Colors.black54, width: 1),
                      ),
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // validator: (value) {
                    //   if (GetUtils.isNull(value))
                    //     return "is not valid";
                    //   else
                    //     return null;
                    // },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก ชื่อ ศส.ปชต.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: defaultPadding),
                CustomText(
                  text: "ที่ตั้ง ศส.ปชต.",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                TextFormField(
                  controller: controller.stationLocation,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(.8),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultPadding / 2),
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                AddressView(showPostCode: false),
                CustomText(
                  text: "Facebook/Location",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                TextFormField(
                  controller: controller.stationFacebook,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(.8),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(defaultPadding / 2),
                      borderSide:
                          const BorderSide(color: Colors.black54, width: 1),
                    ),
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                CustomText(
                  text: "ผลการดำเนินการ ศส.ปชต.",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.stationProcess,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(.8),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultPadding / 2),
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1),
                          ),
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 14, 12, 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: defaultPadding / 2),
                    IconButton(
                      icon: const Icon(Icons.add_sharp),
                      onPressed: () {
                        controller.addProcessToChip(
                          controller.stationProcess.text,
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
                    children: controller.processChips.obs.value
                        .map((chip) => Chip(
                              backgroundColor: Colors.blue.shade100,
                              label: Text(chip),
                              onDeleted: () => controller.deleteProcessToChip(
                                chip,
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                CustomText(
                  text: "ข้อมูลอบรม ศส.ปชต.",
                  color: Colors.black87.withOpacity(.9),
                ),
                const SizedBox(height: defaultPadding / 2),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.stationTraining,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(.8),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultPadding / 2),
                            borderSide: const BorderSide(
                                color: Colors.black54, width: 1),
                          ),
                          isCollapsed: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 14, 12, 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: defaultPadding / 2),
                    IconButton(
                      icon: const Icon(Icons.add_sharp),
                      onPressed: () {
                        controller.addTrainingToChip(
                          controller.stationTraining.text,
                        );
                      },
                    ),
                    // Ink(
                    //   decoration: const ShapeDecoration(
                    //     color: Colors.lightBlue,
                    //     shape: CircleBorder(),
                    //   ),
                    //   child: IconButton(
                    //     icon: const Icon(Icons.add_sharp),
                    //     color: Colors.white,
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: defaultPadding / 2),
                Obx(
                  () => Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: controller.trainingChips.obs.value
                        .map((chip) => Chip(
                              backgroundColor: Colors.blue.shade100,
                              label: Text(chip),
                              onDeleted: () => controller.deleteTrainingToChip(
                                chip,
                              ),
                            ))
                        .toList(),
                  ),
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
                    // Ink(
                    //   decoration: const ShapeDecoration(
                    //     color: Colors.lightBlue,
                    //     shape: CircleBorder(),
                    //   ),
                    //   child: IconButton(
                    //     icon: const Icon(Icons.add_sharp),
                    //     color: Colors.white,
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // const Spacer(flex: 1),
        Container(
          // color: Colors.blueAccent,
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final isValid = _formKeyStation.currentState!.validate();
                  if (isValid) {
                    if (controller.addressController.selectedProvince.value !=
                            '' &&
                        controller.addressController.selectedAmphure.value !=
                            '' &&
                        controller.addressController.selectedTambol.value !=
                            '') {
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
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding / 2),
                ),
                icon: const Icon(
                  Icons.save_sharp,
                ),
                label: const CustomText(
                  text: "บันทึก",
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  controller.addressController.selectedProvince.value = '';
                  controller.addressController.selectedAmphure.value = '';
                  controller.addressController.selectedTambol.value = '';
                  controller.stationList.clear();
                  controller.stationController.offset.value = 0;
                  controller.stationController.currentPage = 1;
                  controller.stationController.listStationStatistics.clear();
                  await controller.infoCardController.getSummaryInfo();
                  await controller.trainingController.listTrainingType();
                  Get.toNamed(Routes.STATION);
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
}

List<DataColumn> listColumnLayoutSmall = [
  const DataColumn2(
    label: CustomText(text: "ชื่อ ศส.ปชต.", scale: 0.9),
    size: ColumnSize.M,
  ),
];

DataRow stationDataRowLayoutSmall(
  int index,
  StationData stationData,
  ManageStationController controller,
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
      controller.selectDataFromTable(index, stationData.id!);
    },
    cells: [
      DataCell(
        Wrap(
          children: [
            Text(
              stationData.name!,
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

List<DataColumn> listColumn = [
  const DataColumn2(
    label: CustomText(text: "ลำดับ", scale: 0.9),
    fixedWidth: 50,
  ),
  const DataColumn2(
    label: CustomText(text: "ชื่อ ศส.ปชต.", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "ที่ตั้ง", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "จังหวัด", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "อำเภอ", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "ตำบล", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "Facebook/Location", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: CustomText(text: "ผลการดำเนินการ ศส.ปชต.", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
  const DataColumn2(
    label: CustomText(text: "ข้อมูลอบรม ศส.ปชต.", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow stationDataRow(
  int index,
  StationData stationData,
  ManageStationController controller,
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
      // controller.selectDataFromTable(index);
      controller.selectDataFromTable(index, stationData.id!);
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
              stationData.name!,
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
              stationData.location!,
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
              stationData.province!,
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
              stationData.amphure!,
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
              stationData.district!,
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
              stationData.facebook!,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        // Wrap(
        //   children: [
        //     Text(
        //       stationData.process!.split('|').first,
        //       style: const TextStyle(
        //         fontSize: 12,
        //       ),
        //     ),
        //   ],
        // ),
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          direction: Axis.vertical,
          children: stationData.process!
              .split('|')
              .map((chip) => Text(
                    chip,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ))
              .toList(),
        ),
      ),
      DataCell(
        // Wrap(
        //   children: [
        //     Text(
        //       stationData.training!.split('|').first,
        //       style: const TextStyle(
        //         fontSize: 12,
        //       ),
        //     ),
        //   ],
        // ),
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          direction: Axis.vertical,
          children: stationData.training!
              .split('|')
              .map((chip) => Text(
                    chip,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ))
              .toList(),
        ),
      ),
    ],
  );
}
