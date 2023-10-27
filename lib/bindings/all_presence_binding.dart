import 'package:absensi/Controller/presence_controller.dart';
import 'package:get/get.dart';


class AllPresenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllPresenceController>(
      () => AllPresenceController(),
    );
  }
}
