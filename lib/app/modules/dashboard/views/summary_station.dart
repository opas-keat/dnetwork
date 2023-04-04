import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../responsive.dart';
import '../../../data/models/province_summary.dart';
import '../../../shared/constant.dart';
import '../../../shared/convert.dart';
import 'dashboard_header.dart';

class SummaryStation extends StatelessWidget {
  SummaryStation({
    Key? key,
  }) : super(key: key);

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      height: 300,
      color: Colors.white70,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DashboardHeader(header: "ศส.ปชต."),
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
                  (index) => StationDataRow(
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
                child: Text("ดูรายละเอียด"),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

DataRow StationDataRow(
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
        formatterItem.format(provinceSummary.totalStation!),
      )),
      // DataCell(Text(fileInfo.size!)),
    ],
  );
}
