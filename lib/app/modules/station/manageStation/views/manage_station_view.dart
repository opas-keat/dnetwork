import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/modules/address/views/address_view.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../responsive.dart';
import '../../../../data/models/station_model.dart';
import '../../../../shared/constant.dart';
import '../../../../shared/custom_text.dart';
import '../../../../shared/main_drawer.dart';
import '../../../../shared/utils.dart';
import '../controllers/manage_station_controller.dart';

class ManageStationView extends StatelessWidget {
  ManageStationView({Key? key}) : super(key: key);
  ManageStationController controller = Get.put(ManageStationController());
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
      drawer: !Responsive.isLargeScreen(context) ? const MainDrawer() : null,
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
                  child: Obx(() => DataTable2(
                        columnSpacing: defaultPadding,
                        dividerThickness: 2,
                        showBottomBorder: true,
                        headingRowColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.grey.shade200),
                        columns: listColumn,
                        // rows: [],
                        rows: List.generate(
                          controller.stationList.value.length,
                          (index) => StationDataRow(
                              index, controller.stationList.value[index]),
                        ),
                      )),
                ),
              ),
            Expanded(
              child: Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Spacer(flex: 1),
                                  IconButton(
                                    icon: const Icon(Icons.refresh_sharp),
                                    onPressed: () {},
                                  ),
                                  // const SizedBox(height: defaultPadding),
                                  const Spacer(flex: 1),
                                  IconButton(
                                    icon: const Icon(Icons.add_sharp),
                                    onPressed: () {
                                      controller.addStationToDataTable();
                                    },
                                  ),
                                  // const SizedBox(height: defaultPadding),
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
                      ),
                      // const Spacer(flex: 1),
                      Expanded(
                        // flex: 1,
                        child: Container(
                          // color: Colors.white,
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
                            text: "ชื่อ ศส.ปชต.",
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
                            text: "ที่ตั้ง ศส.ปชต.",
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
                          AddressView(showPostCode: false),
                          CustomText(
                            text: "Facebook/Location",
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
                            text: "ผลการดำเนินการ ศส.ปชต.",
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
                            Get.toNamed(Routes.STATION);
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

DataRow StationDataRow(int index, StationModel stationModel) {
  return DataRow(
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
              stationModel.name!,
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
              stationModel.locaion!,
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
              stationModel.province!,
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
              stationModel.amphure!,
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
              stationModel.tambol!,
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
              stationModel.facebook!,
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
              stationModel.process!,
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
              stationModel.process!,
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
