import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/station/controllers/station_controller.dart';
import 'constant.dart';
import 'custom_text.dart';

class SearchStation extends StatelessWidget {
  SearchStation({super.key});
  final StationController controller = Get.put(StationController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: "ค้นหาศส.ปชต.",
        color: Colors.black87.withOpacity(.9),
      ),
      content: SizedBox(
        // color: Colors.amber,
        // padding: const EdgeInsets.symmetric(vertical: defaultPadding * 4),
        width: 480,
        height: 640,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomText(
              text: "ชื่อ",
              color: Colors.black87.withOpacity(.9),
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Colors.white.withOpacity(.8),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultPadding / 2),
                        borderSide:
                            const BorderSide(color: Colors.black54, width: 1),
                      ),
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                    ),
                  ),
                ),
                const SizedBox(width: defaultPadding / 2),
                IconButton(
                  icon: const Icon(Icons.search_sharp),
                  onPressed: () async {
                    controller.listStationStatistics.clear();
                    await controller.listStation();
                  },
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: defaultPadding),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            controller.listStationStatistics.obs.value.length,
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.grey.shade200,
                            child: ListTile(
                              onTap: () {
                                Get.back(
                                    result: controller.listStationStatistics.obs
                                        .value[index]);
                              },
                              selectedColor: primaryColor,
                              selectedTileColor: primaryColor,
                              title: CustomText(
                                maxLine: 2,
                                text:
                                    '${controller.listStationStatistics.obs.value[index].name}',
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    maxLine: 4,
                                    scale: 0.9,
                                    text:
                                        '${controller.listStationStatistics.obs.value[index].province}/${controller.listStationStatistics.obs.value[index].amphure}/${controller.listStationStatistics.obs.value[index].district}',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // TextButton(
        //   child: const Text("ค้นหา"),
        //   onPressed: () {
        //     controller.listStation();
        //     // Get.back();
        //   },
        // ),
        TextButton(
          child: const Text("ปิด"),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
