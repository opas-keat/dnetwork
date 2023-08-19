import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../responsive.dart';
import '../../../../data/responses/member_service_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/search_station.dart';
import '../../../../shared/utils.dart';
import '../../../address/views/address_view.dart';
import '../controllers/manage_member_controller.dart';

class ManageMemberView extends StatelessWidget {
  ManageMemberView({Key? key}) : super(key: key);
  final ManageMemberController controller = Get.put(ManageMemberController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "สมาชิก",
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
        child: Row(
          children: [
            if (Responsive.isLargeScreen(context))
              Expanded(
                flex: 3,
                child: Container(
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
                      columns: listColumn,
                      // rows: const [],
                      rows: List.generate(
                        controller.memberList.obs.value.length,
                        (index) => Responsive.isLargeScreen(context)
                            ? memberDataRow(
                                index,
                                controller.memberList.obs.value[index],
                                controller,
                              )
                            : memberDataRowLayoutSmall(
                                index,
                                controller.memberList.obs.value[index],
                                controller,
                              ),
                        // (index) => StationDataRow(
                        //     index, controller.members.obs.value[index]),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
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
                                  icon: const Icon(Icons.refresh_sharp),
                                  onPressed: () {
                                    controller.resetForm();
                                  },
                                ),
                                const Spacer(flex: 1),
                                IconButton(
                                  icon: const Icon(Icons.add_sharp),
                                  onPressed: () {
                                    controller.addDataToTable();
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
                              padding:
                                  EdgeInsets.only(left: defaultPadding / 2),
                              child: CustomText(
                                text: "รายละเอียด",
                                weight: FontWeight.bold,
                                scale: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
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
                          child: Obx(() => SizedBox(
                                height: 100,
                                child: (controller
                                        .fileUpload.value.path.isNotEmpty)
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
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Form(
                    key: controller.formKey,
                    child: Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
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
                              controller: controller.memberStationName,
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
                              onTap: () async {
                                final result = await Get.dialog(
                                  SearchStation(),
                                  barrierDismissible: false,
                                );
                                controller.memberStationName.text = result.name;
                                controller.memberProvince.text =
                                    result.address.split('/').first;
                                controller.memberAmphure.text =
                                    result.address.split('/')[1];
                                controller.memberTambol.text =
                                    result.address.split('/').last;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              controller: controller.memberProvince,
                              keyboardType: TextInputType.text,
                              enabled: false,
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
                              style: const TextStyle(color: Colors.black),
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'กรุณากรอก จังหวัด';
                              //   }
                              //   return null;
                              // },
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
                              controller: controller.memberAmphure,
                              keyboardType: TextInputType.text,
                              enabled: false,
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
                              controller: controller.memberTambol,
                              keyboardType: TextInputType.text,
                              enabled: false,
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
                              style: const TextStyle(color: Colors.black),
                            ),
                            // AddressView(showPostCode: false),
                            // CustomText(
                            //   text: "คำนำหน้า",
                            //   color: Colors.black87.withOpacity(.9),
                            // ),
                            // const SizedBox(height: defaultPadding / 2),
                            // TextFormField(
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //     fillColor: Colors.white.withOpacity(.8),
                            //     filled: true,
                            //     border: OutlineInputBorder(
                            //       borderRadius:
                            //           BorderRadius.circular(defaultPadding / 2),
                            //       borderSide: const BorderSide(
                            //           color: Colors.black54, width: 1),
                            //     ),
                            //     isCollapsed: true,
                            //     contentPadding:
                            //         const EdgeInsets.fromLTRB(12, 14, 12, 12),
                            //   ),
                            // ),
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
                              controller: controller.memberFirstName,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              controller: controller.memberSurName,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              controller: controller.memberIdCard,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(13),
                              ],
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
                              text: "ว/ด/ป เกิด",
                              color: Colors.black87.withOpacity(.9),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            TextFormField(
                              controller: controller.memberBirthYear,
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
                              text: "ที่อยู่",
                              color: Colors.black87.withOpacity(.9),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            TextFormField(
                              controller: controller.memberLocation,
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
                              controller: controller.memberDate,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              controller: controller.memberTelephone,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(.8),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        defaultPadding / 2),
                                    borderSide: const BorderSide(
                                        color: Colors.black54, width: 1),
                                  ),
                                  isCollapsed: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 14, 12, 12),
                                ),
                                value: controller.selectedMemberPosition.value,
                                onChanged: (newValue) {
                                  controller.selectedMemberPosition.value =
                                      newValue!;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาเลือก ตำแหน่งใน ศส.ปชต.';
                                  }
                                  return null;
                                },
                                items: controller.memberPositionList.obs.value
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
                            // TextFormField(
                            //   controller: controller.memberPosition,
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //     fillColor: Colors.white.withOpacity(.8),
                            //     filled: true,
                            //     border: OutlineInputBorder(
                            //       borderRadius:
                            //           BorderRadius.circular(defaultPadding / 2),
                            //       borderSide: const BorderSide(
                            //           color: Colors.black54, width: 1),
                            //     ),
                            //     isCollapsed: true,
                            //     contentPadding:
                            //         const EdgeInsets.fromLTRB(12, 14, 12, 12),
                            //   ),
                            // ),
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
                                      decoration: InputDecoration(
                                        fillColor: Colors.white.withOpacity(.8),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              defaultPadding / 2),
                                          borderSide: const BorderSide(
                                              color: Colors.black54, width: 1),
                                        ),
                                        isCollapsed: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 14, 12, 12),
                                      ),
                                      value: controller
                                          .selectedMemberPositionCommu.value,
                                      onChanged: (newValue) {
                                        controller.selectedMemberPositionCommu
                                            .value = newValue!;
                                      },
                                      items: controller
                                          .memberPositionCommuList.obs.value
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
                                  // child: TextFormField(
                                  //   controller: controller.memberPositionCommu,
                                  //   keyboardType: TextInputType.text,
                                  //   decoration: InputDecoration(
                                  //     fillColor: Colors.white.withOpacity(.8),
                                  //     filled: true,
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(
                                  //           defaultPadding / 2),
                                  //       borderSide: const BorderSide(
                                  //           color: Colors.black54, width: 1),
                                  //     ),
                                  //     isCollapsed: true,
                                  //     contentPadding: const EdgeInsets.fromLTRB(
                                  //         12, 14, 12, 12),
                                  //   ),
                                  // ),
                                ),
                                const SizedBox(width: defaultPadding / 2),
                                IconButton(
                                  icon: const Icon(Icons.add_sharp),
                                  onPressed: () {
                                    controller.addPositionCommuToChip(
                                        controller.memberPositionCommu.text);
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
                                children: controller
                                    .memberPositionCommuChips.obs.value
                                    .map((chip) => Chip(
                                          backgroundColor: Colors.blue.shade100,
                                          label: Text(chip),
                                          onDeleted: () => controller
                                              .deletePositionCommuToChip(chip),
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
                                    controller: controller.memberExp,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white.withOpacity(.8),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            defaultPadding / 2),
                                        borderSide: const BorderSide(
                                            color: Colors.black54, width: 1),
                                      ),
                                      isCollapsed: true,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          12, 14, 12, 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: defaultPadding / 2),
                                IconButton(
                                  icon: const Icon(Icons.add_sharp),
                                  onPressed: () {
                                    controller.addMemberExpToChip(
                                        controller.memberExp.text);
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
                                children: controller.memberExpChips.obs.value
                                    .map((chip) => Chip(
                                          backgroundColor: Colors.blue.shade100,
                                          label: Text(chip),
                                          onDeleted: () => controller
                                              .deleteMemberExpToChip(chip),
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
                    // color: Colors.blueAccent,
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
                            final result = await controller.saveMember();
                            Get.back();
                            result
                                ? Get.offAllNamed(Routes.MEMBER)
                                : Get.snackbar(
                                    'Error',
                                    controller.memberError.value,
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
                                vertical: defaultPadding,
                                horizontal: defaultPadding / 2),
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
                            Get.toNamed(Routes.MEMBER);
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
                ],
              ),
            ),
          ],
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
  // const DataColumn2(
  //   label: CustomText(text: "คำนำหน้า", scale: 0.9),
  //   size: ColumnSize.M,
  // ),
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
    label: CustomText(text: "เบอร์ไทร", scale: 0.9),
    size: ColumnSize.S,
    numeric: true,
  ),
];

DataRow memberDataRow(
  int index,
  MemberData memberData,
  ManageMemberController controller,
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
      controller.selectDataFromTable(index);
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
              memberData.memberFirstName!,
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
              memberData.memberSurName!,
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
              memberData.memberPosition!,
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
              memberData.memberDate!,
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
              memberData.memberTelephone!,
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

DataRow memberDataRowLayoutSmall(
  int index,
  MemberData memberData,
  ManageMemberController controller,
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
              memberData.memberFirstName!,
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
              memberData.memberSurName!,
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
              memberData.memberPosition!,
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
              memberData.memberDate!,
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
              memberData.memberTelephone!,
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
