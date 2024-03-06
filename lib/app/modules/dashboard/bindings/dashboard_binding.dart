import 'package:ahnaf_readhub/app/modules/explore/controllers/explore_controller.dart';
import 'package:ahnaf_readhub/app/modules/home/controllers/home_controller.dart';
import 'package:ahnaf_readhub/app/modules/library/controllers/library_controller.dart';
import 'package:ahnaf_readhub/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<LibraryController>(
          () => LibraryController(),
    );
    Get.lazyPut<ExploreController>(
          () => ExploreController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );

  }
}
