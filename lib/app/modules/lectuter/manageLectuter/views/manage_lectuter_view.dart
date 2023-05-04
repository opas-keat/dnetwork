import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../routes/app_pages.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../controllers/manage_lectuter_controller.dart';

class ManageLectuterView extends StatelessWidget {
  ManageLectuterView({Key? key}) : super(key: key);
  ManageLectuterController controller = Get.put(ManageLectuterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                // color: Colors.amber,
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
                  child: DataTable2(
                    columnSpacing: defaultPadding,
                    dividerThickness: 2,
                    showBottomBorder: true,
                    headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey.shade200),
                    columns: listColumn,
                    rows: [],
                    // rows: List.generate(
                    //   controller.stationList.value.length,
                    //   (index) => StationDataRow(
                    //       index, controller.stationList.value[index]),
                    // ),
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
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                        child: Container(
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
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "จังหวัด",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                          // AddressView(showPostCode: false),
                          CustomText(
                            text: "คำนำหน้า",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "ชื่อ",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "นามสกุล",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "เบอร์โทร",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "LINE ID",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "Facebook",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "หน่วยงาน",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "สังกัดวิทยากร",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          TextFormField(
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
                            text: "ประสบการณ์การเป็นวิทยากร",
                            color: Colors.black87.withOpacity(.9),
                          ),
                          const SizedBox(height: defaultPadding / 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextFormField(
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
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: defaultPadding),
                        ],
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
                          onPressed: () {},
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
                            Get.toNamed(Routes.LECTUTER);
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
