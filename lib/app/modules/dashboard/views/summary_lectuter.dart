import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/province_summary.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils.dart';
import '../controllers/dashboard_controller.dart';
import 'dashboard_header.dart';

class SummaryLectuter extends StatelessWidget {
  SummaryLectuter({
    Key? key,
  }) : super(key: key);
  DashboardController controller = Get.find<DashboardController>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 300,
      color: Colors.white70,
      child: GetBuilder<DashboardController>(
          init: controller,
          builder: (controller) {
            // loading
            if (controller.isLoadingSummaryLectuter.value) {
              return Center(
                child: const CircularProgressIndicator().reactive(),
              );
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    DashboardHeader(header: "วิทยากรประชาธิปไตย"),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                accentDivider,
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
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
                          label: Text("จังหวัด"),
                          size: ColumnSize.L,
                        ),
                        const DataColumn2(
                          label: Text("จำนวน"),
                          size: ColumnSize.S,
                          numeric: true,
                        ),
                      ],
                      rows: List.generate(
                        listProvinceSummary.length,
                        (index) => LectuterDataRow(
                            context, index, listProvinceSummary[index]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                accentDivider,
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    TextButton(
                      child: const Text("ดูรายละเอียด"),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

DataRow LectuterDataRow(
    BuildContext context, int index, ProvinceSummary provinceSummary) {
  return DataRow(
    cells: [
      if (!Responsive.isSmallScreen(context))
        DataCell(Text(
          formatterItem.format(index + 1),
        )),
      DataCell(
        Row(
          children: [
            // SvgPicture.asset(
            //   fileInfo.icon!,
            //   height: 30,
            //   width: 30,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            //   child: Text(provinceSummary.name!),
            // ),
            Text(provinceSummary.name!),
          ],
        ),
      ),
      DataCell(Text(
        formatterItem.format(provinceSummary.totalLectuter!),
      )),
    ],
  );
}
