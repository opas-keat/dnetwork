import 'package:get/get.dart';

import '../../../api/services/address_service.dart';
import '../../../shared/utils.dart';

class AddressController extends GetxController {
  final logTitle = "AddressController";
  RxBool isLoading = true.obs;
  // final selectedProvince = '0|'.obs;
  // final selectedAmphure = '0|'.obs;
  // final selectedTambol = '0|'.obs;
  final selectedProvince = ''.obs;
  final selectedAmphure = ''.obs;
  final selectedTambol = ''.obs;
  // final selectedProvince = ''.obs;
  // Rx<AmphureData> selectedAmphure = AmphureData().obs;
  // Rx<TambolData> selectedTambol = TambolData().obs;
  // Rx<Province> selectedProvince = Province().obs;
  // final provinceList = <String>["0|"].obs;
  // final amphureList = <String>["0|"].obs;
  // final tambolList = <String>["0|"].obs;
  final provinceList = <String>[""].obs;
  final amphureList = <String>[""].obs;
  final tambolList = <String>[""].obs;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    // provinceList.value = listProvince;
    // selectedProvince.value = provinceList[0];
    // amphureList.value = listAmphure;
    // tambolList.value = listTambol;
    // addressApi = AddressService(_client.init());
    listProvince();
  }

  @override
  void onReady() {
    super.onReady();
    talker.info('$logTitle onReady');
  }

  @override
  void onClose() {
    talker.info('$logTitle:onClose:');
    super.onReady();
  }

  Future listProvince() async {
    talker.info('$logTitle listProvince');
    try {
      final result = await AddressService().listProvince();
      provinceList.clear();
      provinceList.add("");
      for (var item in result!.data!) {
        provinceList.add(item.pName!);
      }
      provinceList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  updateSelectedProvince(String province, bool showAmphure) {
    talker.info('$logTitle updateSelectedProvince:$province');
    selectedProvince.value = province;
    talker.info('$logTitle updateSelectedProvince::pName:$province');
    if (showAmphure) {
      listAmphure();
    }
  }

  Future listAmphure() async {
    talker.info('$logTitle::listAmphure:${selectedProvince.value}');
    try {
      amphureList.clear();
      amphureList.add("");
      selectedAmphure.value = "";
      final result =
          await AddressService().listAmphureByPName(selectedProvince.value);
      for (var item in result!.data!) {
        amphureList.add(item.aName!);
      }
      // talker.debug(amphureList.toString());
      // talker.debug(amphureList.toString());
      // for (var item in result!.data!) {
      //   // talker.info('$logTitle::listAmphure:${item.aCode!}|${item.aName!}');
      //   amphureList.add(item.aName!);
      // }
      amphureList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  updateSelectedAmphure(String amphure) {
    talker.info('$logTitle updateSelectedAmphure:$amphure');
    selectedAmphure.value = amphure;
    listTambol();
  }

  Future listTambol() async {
    talker.info('$logTitle::listTambol:${selectedAmphure.value}');
    try {
      final result = await AddressService().listTambolByPNameAName(
        selectedProvince.value,
        selectedAmphure.value,
      );
      // tambolList.addAll(result!.data!);
      // selectedTambol.value = tambolList[0];
      tambolList.clear();
      tambolList.add("");
      selectedTambol.value = "";
      for (var item in result!.data!) {
        // talker.info('$logTitle::listTambol:${item.tCode!}|${item.tName!}');
        tambolList.add(item.tName!);
      }
      tambolList.refresh();
    } catch (e) {
      talker.error('$e');
    }
  }

  updateSelectedTambol(String tName) {
    talker.info('$logTitle updateSelectedTambol:$tName');
    selectedTambol.value = tName;
    update();
  }
}
