
import 'package:dwarikesh/controller/activity_list_cfa_controller.dart';
import 'package:get/get.dart';

class ActivityListCfaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActivityListCfaController());
  }
}