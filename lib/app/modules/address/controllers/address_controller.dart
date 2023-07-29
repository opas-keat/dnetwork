import 'dart:convert';

import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../api/services/address_service.dart';
import '../../../data/models/provinces.dart';
import '../../../data/responses/province_service_response.dart';

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

  Rx<ProvinceData> selectedProvince = ProvinceData().obs;

  final provinceList = <ProvinceData>[
    ProvinceData(
      id: "1",
      pName: "กรุงเทพมหานคร",
      pCode: "10",
    ),
  ].obs;

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
  final amphureList = [].obs;
  final tambolList = [].obs;

  @override
  void onInit() {
    super.onInit();
    talker.info('$logTitle onInit');
    // provinceList.value = listProvince;
    selectedProvince.value = provinceList[0];
    amphureList.value = listAmphure;
    tambolList.value = listTambol;
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
      provinceList.addAll(result!.data!);
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

  updateSelectedProvince(ProvinceData provice) {
    talker.info('$logTitle updateSelectedProvince:${provice.pName}');
    selectedProvince.value = provice;
    // selectedProvince.value = provice;
    update();
  }
}
