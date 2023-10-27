import 'package:absensi/Controller/absensi_controller.dart';
import 'package:get/get.dart';
import 'package:absensi/routes/app_pages.dart';

class PageIndexController extends GetxController {
  // final presenceController = Get.find<PresenceController>();
  final presenceController = Get.put<PresenceController>(PresenceController());
  RxInt pageIndex = 0.obs;

  void changePage(int index) async {
    Get.put(PresenceController());
    pageIndex.value = index;
    switch (index) {
      case 1:
        presenceController.presence();
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      case 3:
        Get.offAllNamed(Routes.ADMIN);
        break;
      default:
        Get.offAllNamed(Routes.MAIN);
        break;
    }
  }
}
