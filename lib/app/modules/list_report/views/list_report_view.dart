import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/list_report.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/utils.dart';
import '../controllers/list_report_controller.dart';

class ListReportView extends GetView<ListReportController> {
  ListReportView({Key? key}) : super(key: key);
  ListReportController controller = Get.find<ListReportController>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GetBuilder<ListReportController>(
          init: controller,
          builder: (controller) {
            // loading
            if (controller.isLoading.value) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 2),
                child: Center(
                  child: const CircularProgressIndicator().reactive(),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: defaultPadding),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          cursorColor: primaryColor,
                          // controller: _textEmail,
                          decoration: const InputDecoration(
                            hintText: 'ค้นหา',
                            prefixIcon: Icon(Icons.search_sharp),
                          ),
                          // validator: (value) => validateNotEmpty(value!, 'Your Email'),
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      CustomFlatButton(
                        color: primaryColor,
                        overlayColor: primaryLightColor,
                        padding: const EdgeInsets.all(defaultPadding),
                        isWrapped: true,
                        label: 'ค้นหา',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      CustomFlatButton(
                        color: Colors.green.shade700,
                        overlayColor: Colors.greenAccent,
                        padding: const EdgeInsets.all(defaultPadding),
                        isWrapped: true,
                        label: 'ปรับปรุงสถานะ',
                        onPressed: () {},
                      ),
                      const SizedBox(width: defaultPadding),
                    ],
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Container(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height -
                      (Responsive.isSmallScreen(context) ? 220 : 180),
                  child: DataTable2(
                    scrollController: _scrollController,
                    columnSpacing: defaultPadding,
                    // minWidth: 200,
                    columns: [
                      if (!Responsive.isSmallScreen(context))
                        const DataColumn2(
                          label: Text("ลำดับที่"),
                          size: ColumnSize.S,
                        ),
                      const DataColumn2(
                        label: Text("การทำงาน"),
                        size: ColumnSize.S,
                      ),
                      const DataColumn2(
                        label: Text("รายละเอียด"),
                        size: ColumnSize.L,
                      ),
                      if (!Responsive.isSmallScreen(context))
                        const DataColumn2(
                          label: Text("ผู้แจ้ง"),
                          size: ColumnSize.M,
                        ),
                      const DataColumn2(
                        label: Text("สถานะ"),
                        size: ColumnSize.M,
                      ),
                    ],
                    // rows: [],
                    rows: List.generate(
                      controller.bugReportList.length,
                      (index) => BugReportDataRow(
                        context,
                        controller.bugReportList[index],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

DataRow BugReportDataRow(
  BuildContext context,
  BugReport bugReport,
) {
  return DataRow(
    cells: [
      if (!Responsive.isSmallScreen(context))
        DataCell(Text(
          formatterItem.format(bugReport.id),
        )),
      DataCell(
        Text(bugReport.module!),
      ),
      DataCell(
        Text(bugReport.detail!),
      ),
      if (!Responsive.isSmallScreen(context))
        DataCell(
          Text(bugReport.userName!),
        ),
      DataCell(
        Text(bugReport.status!),
      ),
    ],
  );
}
