import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../responsive.dart';
import '../../../data/models/module.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/custom_text.dart';
import '../controllers/reportproblem_controller.dart';

class ReportproblemView extends StatelessWidget {
  ReportproblemView({Key? key}) : super(key: key);
  ReportproblemController controller = Get.find<ReportproblemController>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GetBuilder<ReportproblemController>(
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
            return Row(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: defaultPadding * 2),
                      CustomText(
                        text: "การทำงาน",
                        size: 20,
                        color: Colors.black87.withOpacity(.9),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultPadding / 2),
                            borderSide: const BorderSide(
                                color: Colors.black87, width: 2),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            elevation: 0,
                            value: controller.currentModuleSelected.value,
                            isDense: true,
                            items: optionModuleSelected.entries.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.key,
                                child: Text(
                                  item.value,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              controller.updateModuleSelected(newValue!);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      CustomText(
                        text: "รายละเอียด",
                        size: 20,
                        color: Colors.black87.withOpacity(.9),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(.2),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultPadding / 2),
                            borderSide: const BorderSide(
                                color: Colors.black87, width: 2),
                          ),
                          // hintText: 'Enter a search term',
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      Center(
                        child: CustomFlatButton(
                          color: primaryColor,
                          overlayColor: primaryLightColor,
                          padding: const EdgeInsets.all(defaultPadding),
                          isWrapped: true,
                          label: 'บันทึก',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            );
          }),
    );
  }
}
