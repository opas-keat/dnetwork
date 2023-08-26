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
  ManageVillageView({Key? key}) : super(key: key);
  final ManageVillageController controller = Get.put(ManageVillageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "หมู่บ้าน วิถี ประชาธิปไตย",
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
                  actionMenu(),
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
          key: controller.formKey,
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
                    text: "Facebook/Location",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.villageLocation,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  Get.dialog(
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    barrierDismissible: false,
                  );
                  final result = await controller.save();
                  Get.back();
                  result
                      ? Get.offAllNamed(Routes.VILLAGEHOSTY)
                      : Get.snackbar(
                          'Error',
                          controller.villageError.value,
                          backgroundColor: accentColor,
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          icon: const Icon(
                            Icons.lock_person_outlined,
                            color: Colors.white,
                          ),
                          isDismissible: true,
                          margin: const EdgeInsets.all(
                            defaultPadding,
                          ),
                        );
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
                onPressed: () {
                  controller.addressController.selectedProvince.value = '';
                  controller.addressController.selectedAmphure.value = '';
                  controller.addressController.selectedTambol.value = '';
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

  Row actionMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.add_sharp),
          onPressed: () async {
            Get.dialog(
              const Center(
                child: CircularProgressIndicator(),
              ),
              barrierDismissible: false,
            );
            await controller.save();
            Get.back();
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
            Get.dialog(
              const Center(
                child: CircularProgressIndicator(),
              ),
              barrierDismissible: false,
            );
            await controller.delete();
            Get.back();
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
              controller.update();
            }
          },
          child: Obx(() => SizedBox(
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
