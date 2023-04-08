import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../controllers/lectuter_controller.dart';

class LectuterView extends StatelessWidget {
  LectuterView({Key? key}) : super(key: key);
  LectuterController controller = Get.find<LectuterController>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GetBuilder<LectuterController>(
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
                      if (!Responsive.isSmallScreen(context))
                        const DataColumn2(
                          label: Text("คำนำหน้า"),
                          size: ColumnSize.S,
                        ),
                      const DataColumn2(
                        label: Text("ชื่อ"),
                        size: ColumnSize.S,
                      ),
                      const DataColumn2(
                        label: Text("นามสกุล"),
                        size: ColumnSize.S,
                      ),
                      if (!Responsive.isSmallScreen(context))
                        const DataColumn2(
                          label: Text("หน่วยงาน"),
                          size: ColumnSize.S,
                        ),
                      if (!Responsive.isSmallScreen(context))
                        const DataColumn2(
                          label: Text("สังกัด"),
                          size: ColumnSize.S,
                        ),
                      const DataColumn2(
                        label: Text("เบอร์โทรศัพท์"),
                        size: ColumnSize.S,
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
            );
          }),
    );
  }
}
