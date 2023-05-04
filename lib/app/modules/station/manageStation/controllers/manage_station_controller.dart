import 'package:frontend/app/data/models/station_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../main.dart';
import '../../../../shared/utils.dart';

class ManageStationController extends GetxController {
  final logTitle = "ManageStationController";
  RxBool isLoading = true.obs;

  Rx<String> filePath = ''.obs;
  Rx<XFile> fileUpload = XFile('').obs;

  final stationList = [].obs;

  @override
  void onInit() {
    super.onInit();
    // isLoading.value = true;
    // update();
    // getAddCommiss();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addStationToDataTable() {
    talker.info('$logTitle:addStationToDataTable:');
    stationList.add(
      StationModel(
        name: "ทดสอบ",
        locaion: "-",
        province: "กรุงเทพมหานคร",
        amphure: "บางขุนเทียน",
        tambol: "แสมดำ",
        facebook: "-",
        process: "-",
      ),
    );
    update();
  }

  // getAddCommiss() async {
  //   talker.info('$logTitle:getAddStation:');
  //   isLoading.value =
  //       await Future.delayed(Duration(seconds: randomValue()), () {
  //     return false;
  //   });
  //   update();
  // }
}
