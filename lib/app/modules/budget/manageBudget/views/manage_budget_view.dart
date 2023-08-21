import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../responsive.dart';
import '../../../../data/responses/budget_service_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/utils.dart';
import '../../../address/views/address_view.dart';
import '../controllers/manage_budget_controller.dart';

class ManageBudgetView extends StatelessWidget {
  ManageBudgetView({Key? key}) : super(key: key);
  final ManageBudgetController controller = Get.put(ManageBudgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Responsive.isLargeScreen(context)
          ? AppBar(
              centerTitle: true,
              title: const CustomText(
                text: "งบประมาณ รายรับ-รายจ่าย",
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
                        controller.budgetList.obs.value.length,
                        (index) => Responsive.isLargeScreen(context)
                            ? budgetDataRow(
                                index,
                                controller.budgetList.obs.value[index],
                                controller,
                              )
                            : budgetDataRowLayoutSmall(
                                index,
                                controller.budgetList.obs.value[index],
                                controller,
                              ),
                        // (index) => StationDataRow(
                        //     index, controller.budgetList.obs.value[index]),
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
                                  icon: const Icon(Icons.add_sharp),
                                  onPressed: () {
                                    controller.addDataToTable();
                                  },
                                ),
                                const Spacer(flex: 1),
                                IconButton(
                                  icon: const Icon(Icons.edit_sharp),
                                  onPressed: () {
                                    controller.editData();
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
                                  text: "ประเภทงบประมาณ",
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
                                    borderRadius: BorderRadius.circular(
                                        defaultPadding / 2),
                                    borderSide: const BorderSide(
                                        color: Colors.black54, width: 1),
                                  ),
                                  isCollapsed: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 14, 12, 12),
                                ),
                                value: controller.selectedBudgetType.value,
                                onChanged: (newValue) {
                                  controller.selectedBudgetType.value =
                                      newValue!;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาเลือก ประเภทงบประมาณ';
                                  }
                                  return null;
                                },
                                items: controller.budgetTypeList.obs.value
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
                            //   controller: controller.budgetType,
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
                                  text: "วันที่รับงบประมาณ",
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
                              controller: controller.budgetDate,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              onTap: () async {
                                DateTime? newDateTime = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));
                                if (newDateTime != null) {
                                  controller.budgetDate.text =
                                      DateFormat('dd/MM/yyyy')
                                          .format(newDateTime);
                                }
                              },
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
                                  return 'กรุณากรอก วันที่รับงบประมาณ';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding),
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                CustomText(
                                  text: "งบต้น",
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
                              controller: controller.budgetBegin,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
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
                                  return 'กรุณากรอก งบต้น';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding),
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                CustomText(
                                  text: "งบที่ใช้ไป",
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
                              controller: controller.budgetUsed,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
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
                                  return 'กรุณากรอก งบต้น';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding),
                            Wrap(
                              direction: Axis.horizontal,
                              children: [
                                CustomText(
                                  text: "งบคงเหลือ",
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
                              controller: controller.budgetRemain,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
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
                                  return 'กรุณากรอก งบคงเหลือ';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding),
                            AddressView(
                                showAmphure: false,
                                showTambol: false,
                                showPostCode: false),
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
                    // color: Colors.blueAccent,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.offAllNamed(Routes.BUDGET);
                          },
                          // onPressed: () async {
                          //   Get.dialog(
                          //     const Center(
                          //       child: CircularProgressIndicator(),
                          //     ),
                          //     barrierDismissible: false,
                          //   );
                          //   final result = await controller.saveBudget();
                          //   Get.back();
                          //   result
                          //       ? Get.offAllNamed(Routes.BUDGET)
                          //       : Get.snackbar(
                          //           'Error',
                          //           controller.budgetError.value,
                          //           backgroundColor: accentColor,
                          //           snackPosition: SnackPosition.BOTTOM,
                          //           colorText: Colors.white,
                          //           icon: const Icon(
                          //             Icons.lock_person_outlined,
                          //             color: Colors.white,
                          //           ),
                          //           isDismissible: true,
                          //           margin: const EdgeInsets.all(
                          //             defaultPadding,
                          //           ),
                          //         );
                          // },
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
                            Get.toNamed(Routes.BUDGET);
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
  const DataColumn2(
    label: CustomText(text: "ประเภทงบประมาณ", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "วันที่รับงบประมาณ", scale: 0.9),
    size: ColumnSize.M,
  ),
  const DataColumn2(
    label: CustomText(text: "งบต้น", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "งบที่ใช้ไป", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "งบคงเหลือ", scale: 0.9),
    size: ColumnSize.S,
  ),
  const DataColumn2(
    label: CustomText(text: "จังหวัด", scale: 0.9),
    size: ColumnSize.S,
  ),
];

DataRow budgetDataRow(
  int index,
  BudgetData budgetData,
  ManageBudgetController controller,
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
              budgetData.budgetType!,
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
              budgetData.budgetDate!,
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
              formatterItem.format(budgetData.budgetBegin),
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
              formatterItem.format(budgetData.budgetUsed),
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
              formatterItem.format(budgetData.budgetRemain),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          budgetData.province!.split('|').last,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

DataRow budgetDataRowLayoutSmall(
  int index,
  BudgetData budgetData,
  ManageBudgetController controller,
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
              budgetData.budgetDate!,
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
              budgetData.budgetType!,
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
              budgetData.province!,
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
              formatterItem.format(budgetData.budgetBegin),
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
              formatterItem.format(budgetData.budgetUsed),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          formatterItem.format(budgetData.budgetRemain),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}
