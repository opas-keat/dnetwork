import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../responsive.dart';
import '../../../../data/responses/network_service_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/search_station.dart';
import '../../../../shared/utils.dart';
import '../controllers/manage_network_controller.dart';

class ManageNetworkView extends StatelessWidget {
  ManageNetworkView({Key? key}) : super(key: key);
  final ManageNetworkController controller = Get.put(ManageNetworkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "ภาคีเครือข่าย",
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
                    child: ManageDataTableNetwork(),
                  ),
                  Expanded(
                    child: ManageDataDetailNetwork(),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ManageDataTableNetwork(),
                  ),
                  accentDivider,
                  Expanded(
                    flex: 3,
                    child: ManageDataDetailNetwork(),
                  ),
                ],
              ),
      ),
    );
  }
}

class ManageDataTableNetwork extends StatelessWidget {
  ManageDataTableNetwork({
    super.key,
  });
  final ManageNetworkController controller = Get.put(ManageNetworkController());
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
            controller.networkList.obs.value.length,
            (index) => Responsive.isLargeScreen(context)
                ? networkDataRow(
                    index,
                    controller.networkList.obs.value[index],
                    controller,
                  )
                : networkDataRowSmall(
                    index,
                    controller.networkList.obs.value[index],
                    controller,
                  ),
          ),
        ),
      ),
    );
  }
}

class ManageDataDetailNetwork extends StatelessWidget {
  ManageDataDetailNetwork({
    super.key,
  });
  final ManageNetworkController controller = Get.put(ManageNetworkController());
  final _formKeyNetwork = GlobalKey<FormState>();
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
                  actionMenu(_formKeyNetwork),
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
          key: _formKeyNetwork,
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
                  TextFormField(
                    controller: controller.networkStationName,
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
                    onTap: () async {
                      final result = await Get.dialog(
                        SearchStation(),
                        barrierDismissible: false,
                      );
                      controller.networkStationName.text = result.name;
                      controller.networkProvince.text = result.province;
                      controller.networkAmphure.text = result.amphure;
                      controller.networkTambol.text = result.district;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาเลือก ชื่อ ศส.ปชต.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "จังหวัด",
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
                    controller: controller.networkProvince,
                    keyboardType: TextInputType.text,
                    enabled: false,
                    readOnly: true,
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
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "อำเภอ",
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
                    controller: controller.networkAmphure,
                    keyboardType: TextInputType.text,
                    enabled: false,
                    readOnly: true,
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
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "ตำบล",
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
                    controller: controller.networkTambol,
                    keyboardType: TextInputType.text,
                    enabled: false,
                    readOnly: true,
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
                    style: const TextStyle(color: Colors.black),
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
                    controller: controller.networkFirstName,
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
                    controller: controller.networkSurName,
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
                        return 'กรุณากรอก นามสกุล';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "เลขที่บัตรประชาชน",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.networkIdCard,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(13),
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
                    text: "ว/ด/ป เกิด",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.networkBirthYear,
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
                    text: "ที่อยู่",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextFormField(
                    controller: controller.networkLocation,
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
                    controller: controller.networkTelephone,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณากรอก เบอร์โทร';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "ว/ด/ป ที่แต่งตั้ง",
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
                    controller: controller.networkDate,
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
                        return 'กรุณากรอก ว/ด/ป ที่แต่งตั้ง';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomText(
                        text: "ตำแหน่งใน ศส.ปชต.",
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
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(.8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                          borderSide:
                              const BorderSide(color: Colors.black54, width: 1),
                        ),
                        isCollapsed: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 14, 12, 12),
                      ),
                      value: controller.selectedNetworkPosition.value,
                      onChanged: (newValue) {
                        controller.selectedNetworkPosition.value = newValue!;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาเลือก ตำแหน่งใน ศส.ปชต.';
                        }
                        return null;
                      },
                      items:
                          controller.networkPositionList.obs.value.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            textScaleFactor: 0.9,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "ตำแหน่งอื่นในชุมชน",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Obx(
                          () => DropdownButtonFormField<String>(
                            isDense: true,
                            isExpanded: true,
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
                            value:
                                controller.selectedNetworkPositionCommu.value,
                            onChanged: (newValue) {
                              controller.selectedNetworkPositionCommu.value =
                                  newValue!;
                            },
                            items: controller.networkPositionCommuList.obs.value
                                .map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  textScaleFactor: 0.9,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      IconButton(
                        icon: const Icon(Icons.add_sharp),
                        onPressed: () {
                          controller.addPositionCommuToChip(
                              controller.networkPositionCommu.text);
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
                      children: controller.networkPositionCommuChips.obs.value
                          .map((chip) => Chip(
                                backgroundColor: Colors.blue.shade100,
                                label: Text(chip),
                                onDeleted: () =>
                                    controller.deletePositionCommuToChip(chip),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  CustomText(
                    text: "ประสบการณ์มีส่วนร่วมในการเลือกตั้ง",
                    color: Colors.black87.withOpacity(.9),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.networkExp,
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
                          controller
                              .addNetworkExpToChip(controller.networkExp.text);
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
                      children: controller.networkExpChips.obs.value
                          .map((chip) => Chip(
                                backgroundColor: Colors.blue.shade100,
                                label: Text(chip),
                                onDeleted: () =>
                                    controller.deleteNetworkExpToChip(chip),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // ElevatedButton.icon(
                        //   onPressed: () async {
                        //     final isValid =
                        //         _formKeyNetwork.currentState!.validate();
                        //     if (isValid) {
                        //       Get.dialog(
                        //         const Center(
                        //           child: CircularProgressIndicator(),
                        //         ),
                        //         barrierDismissible: false,
                        //       );
                        //       await controller.save();
                        //       Get.back();
                        //     }
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: defaultPadding,
                        //         horizontal: defaultPadding / 2),
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
                            controller.networkList.clear();
                            controller.networkController.offset.value = 0;
                            controller.networkController.currentPage = 1;
                            controller.networkController.listNetworkStatistics
                                .clear();
                            await controller.infoCardController
                                .getSummaryInfo();
                            await controller.networkController
                                .listNetworkPosition();
                            await controller.networkController.listNetwork();
                            Get.toNamed(Routes.NETWORK);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding,
                                horizontal: defaultPadding / 2),
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
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
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
              Get.dialog(
                const Center(
                  child: CircularProgressIndicator(),
                ),
                barrierDismissible: false,
              );
              await controller.save();
              Get.back();
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

List<DataColumn> listColumn = [
  const DataColumn2(
    label: CustomText(text: "ลำดับ", scale: 0.9),
    fixedWidth: 50,
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
    label: CustomText(text: "ตำแหน่งใน ศศ.ปชต.", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "ว/ด/ป แต่งตั้ง", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "เบอร์โทร", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow networkDataRow(
  int index,
  NetworkData networkData,
  ManageNetworkController controller,
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
      controller.selectDataFromTable(index, networkData.id!);
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
              networkData.networkFirstName!,
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
              networkData.networkSurName!,
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
              networkData.networkPosition!,
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
              networkData.networkDate!,
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
              networkData.networkTelephone!,
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

DataRow networkDataRowSmall(
  int index,
  NetworkData networkData,
  ManageNetworkController controller,
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
      controller.selectDataFromTable(index, networkData.id!);
    },
    cells: [
      DataCell(
        Wrap(
          children: [
            Text(
              networkData.networkFirstName!,
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
