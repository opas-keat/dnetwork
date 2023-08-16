import 'package:get/get.dart';

import '../../../api/services/address_service.dart';
import '../../../shared/utils.dart';

class AddressController extends GetxController {
  final logTitle = "AddressController";
  RxBool isLoading = true.obs;
  final selectedProvince = '0|'.obs;
  final selectedAmphure = '0|'.obs;
  final selectedTambol = '0|'.obs;
  // final selectedProvince = ''.obs;
  // Rx<AmphureData> selectedAmphure = AmphureData().obs;
  // Rx<TambolData> selectedTambol = TambolData().obs;
  // Rx<Province> selectedProvince = Province().obs;
  final provinceList = <String>["0|"].obs;
  final amphureList = <String>["0|"].obs;
  final tambolList = <String>["0|"].obs;

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

  Future<bool> listProvince() async {
    talker.info('$logTitle listProvince');
    try {
      final result = await AddressService().listProvince();
      provinceList.clear();
      provinceList.add("0|");
      for (var item in result!.data!) {
        provinceList.add("${item.pCode!}|${item.pName!}");
      }
      update();
      return false;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  updateSelectedProvince(String province, bool showAmphure) {
    talker.info('$logTitle updateSelectedProvince:${province}');
    selectedProvince.value = province;
    talker.info('$logTitle updateSelectedProvince::pCode:${province}');
    if (showAmphure) {
      listAmphure(
        province.split('|').first,
      );
    }
  }

  Future<bool> listAmphure(String pCode) async {
    talker.info('$logTitle::listAmphure:$pCode');
    try {
      final result = await AddressService().listAmphureByPCode(pCode);
      amphureList.clear();
      amphureList.add("0|");
      for (var item in result!.data!) {
        // talker.info('$logTitle::listAmphure:${item.aCode!}|${item.aName!}');
        amphureList.add("${item.aCode!}|${item.aName!}");
      }
      update();
      return false;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  updateSelectedAmphure(String amphure) {
    talker.info('$logTitle updateSelectedAmphure:${amphure}');
    selectedAmphure.value = amphure;
    listTambol(
      amphure.split('|').first,
    );
  }

  Future<bool> listTambol(String aCode) async {
    talker.info('$logTitle::listTambol:$aCode');
    try {
      final result = await AddressService().listTambolByACode(aCode);
      // tambolList.addAll(result!.data!);
      // selectedTambol.value = tambolList[0];
      tambolList.clear();
      tambolList.add("0|");
      for (var item in result!.data!) {
        // talker.info('$logTitle::listTambol:${item.tCode!}|${item.tName!}');
        tambolList.add("${item.tCode!}|${item.tName!}");
      }
      update();
      return false;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  updateSelectedTambol(String tName) {
    talker.info('$logTitle updateSelectedTambol:${tName}');
    selectedTambol.value = tName;
    update();
  }
}
