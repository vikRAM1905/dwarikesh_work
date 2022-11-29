import 'package:dwarikesh/utils/common_method.dart';
import 'package:dwarikesh/utils/constant.dart';
import 'package:dwarikesh/utils/pref_manager.dart';
import 'package:get/get.dart';
import 'package:dwarikesh/model/gower_list_model.dart';
import 'package:dwarikesh/widgets/Prograssbar.dart';
import 'dart:convert';
import 'package:dwarikesh/api/request.dart';
import 'package:dwarikesh/api/url.dart';

class GrowerListController extends GetxController {
  var resListData = List<Data>.empty(growable: true).obs;
  final responseCode = ''.obs;

  @override
  void onInit() {
    apiGetList();
    super.onInit();
  }

  void apiGetList() async {
    String village = await Prefs.getString(VILLAGE_ID);
    Future.delayed(Duration.zero, () => Get.dialog(Progressbar()));
    Request request = Request(
        url: urlGowerwiseList, body: {'id': village, "lang": getLanguage()});
    request.post().then((response) {
      responseCode.value = response.statusCode.toString();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          GowerListModel listModel =
              GowerListModel.fromJson(json.decode(response.body));
          if (listModel.status == true) {
            resListData.value = listModel.data!;
          } else
            responseCode.value = '403';
        }
      }

      Get.back();
      update();
    }).catchError((onError) {
      print(onError);
    });
  }
}
