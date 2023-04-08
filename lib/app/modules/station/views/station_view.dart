import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/province_summary.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/utils.dart';
import '../controllers/station_controller.dart';

class StationView extends GetView<StationController> {
  StationView({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
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
                  label: 'เพิ่ม',
                  onPressed: () {},
                ),
                const SizedBox(width: defaultPadding),
                CustomFlatButton(
                  color: Colors.redAccent.shade700,
                  overlayColor: Colors.redAccent,
                  padding: const EdgeInsets.all(defaultPadding),
                  isWrapped: true,
                  label: 'ลบ',
                  onPressed: () {},
                ),
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
                  label: Text("ชื่อ"),
                  size: ColumnSize.L,
                ),
                const DataColumn2(
                  label: Text("ที่ตั้ง"),
                  size: ColumnSize.L,
                ),
                if (!Responsive.isSmallScreen(context))
                  const DataColumn2(
                    label: Text("จังหวัด"),
                    size: ColumnSize.M,
                  ),
                if (!Responsive.isSmallScreen(context))
                  const DataColumn2(
                    label: Text("อำเภอ"),
                    size: ColumnSize.M,
                  ),
                if (!Responsive.isSmallScreen(context))
                  const DataColumn2(
                    label: Text("ตำบล"),
                    size: ColumnSize.M,
                  ),
                const DataColumn2(
                  label: Text("จำนวนกรรมการ"),
                  size: ColumnSize.M,
                  numeric: true,
                ),
              ],
              rows: [],
              // rows: List.generate(
              //   listProvinceSummary.length,
              //   (index) =>
              //       StationDataRow(context, index, listProvinceSummary[index]),
              // ),
            ),
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
