import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../data/models/provinces.dart';

class AddressController extends GetxController {
  final logTitle = "AddressController";
  RxBool isLoading = true.obs;

  // Rx<Province> selectedProvince = Province(
  //   name: "กรุงเทพมหานคร",
  //   pCode: "10",
  // ).obs;
  Rx<Province> selectedProvince = Rx<Province>(
    Province(
      pName: "กรุงเทพมหานคร",
      pCode: "10",
    ),
  );

  final provinceList = [].obs;
  final amphureList = [].obs;
  final tambolList = [].obs;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    provinceList.value = listProvince;
    amphureList.value = listAmphure;
    tambolList.value = listTambol;
  }

  @override
  void onReady() {
    super.onReady();
    talker.info('$logTitle onReady');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
