import 'package:get/get.dart';

import '../../../api/services/address_service.dart';
import '../../../data/responses/address_service_response.dart';
import '../../../shared/utils.dart';

class AddressController extends GetxController {
  final logTitle = "AddressController";
  RxBool isLoading = true.obs;

  // Client _client = Client();
  // var addressApi;

  // Rx<Province> selectedProvince = Province(
  //   name: "กรุงเทพมหานคร",
  //   pCode: "10",
  // ).obs;
  // Rx<Province> selectedProvince = Province(
  //   pName: "กรุงเทพมหานคร",
  //   pCode: "10",
  // ).obs;

  Rx<ProvinceData> selectedProvince = ProvinceData(
    pName: "",
    pCode: "",
  ).obs;
  Rx<AmphureData> selectedAmphure = AmphureData().obs;
  Rx<TambolData> selectedTambol = TambolData().obs;
  // Rx<Province> selectedProvince = Province().obs;
  // final List<Province> provinceList = <Province>[
  //   Province(
  //     pName: "กรุงเทพมหานคร",
  //     pCode: "10",
  //   ),
  //   Province(
  //     pName: "กรุงเทพมหานคร2",
  //     pCode: "102",
  //   ),
  // ].obs;
  // final provinceList = <ProvinceData>[
  //   ProvinceData(
  //     id: "1",
  //     pName: "กรุงเทพมหานคร",
  //     pCode: "10",
  //   ),
  // ].obs;
  // final selectedProvince = ProvinceData(
  //   pName: "กรุงเทพมหานคร",
  //   pCode: "10",
  // ).obs;
  final provinceList = <ProvinceData>[].obs;
  final amphureList = <AmphureData>[].obs;
  final tambolList = <TambolData>[].obs;

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

  // Future<ProvinceServiceResponse> listProvince(
  Future<bool> listProvince() async {
    talker.info('$logTitle listProvince');
    try {
      // final response = await addressApi.listProvince();
      final result = await AddressService().listProvince();
      provinceList.clear();
      provinceList.addAll(result!.data!);
      selectedProvince.value = provinceList[0];
      update();
      return false;
    } catch (e) {
      talker.error('$e');
      return false;
    }
    // return Future.delayed(const Duration(seconds: 3), () {
    //   return true;
    // });
  }

  updateSelectedProvince(ProvinceData province) {
    talker.info('$logTitle updateSelectedProvince:${province.pName}');
    selectedProvince.value = province;
    talker.info('$logTitle updateSelectedProvince::pCode:${province.pCode}');
    // selectedProvince.value = provice;
    amphureList.clear();
    listAmphure(province.pCode!);
    // update();
  }

  Future<bool> listAmphure(String pCode) async {
    talker.info('$logTitle listAmphure');
    try {
      final result = await AddressService().listAmphureByPCode(pCode);
      amphureList.addAll(result!.data!);
      selectedAmphure.value = amphureList[0];
      update();
      return false;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  updateSelectedAmphure(AmphureData amphure) {
    talker.info('$logTitle updateSelectedAmphure:${amphure.aName}');
    selectedAmphure.value = amphure;
    // update();
    // talker.info('$logTitle updateSelectedAmphure::pCode:${amphure.aCode}');
    tambolList.clear();
    listTambol(amphure.aCode!);
  }

  Future<bool> listTambol(String aCode) async {
    talker.info('$logTitle listTambol');
    try {
      final result = await AddressService().listTambolByACode(aCode);
      tambolList.addAll(result!.data!);
      selectedTambol.value = tambolList[0];
      update();
      return false;
    } catch (e) {
      talker.error('$e');
      return false;
    }
  }

  updateSelectedTambol(TambolData tambol) {
    talker.info('$logTitle updateSelectedAmphure:${tambol.tName}');
    selectedTambol.value = tambol;
    update();
  }
}
