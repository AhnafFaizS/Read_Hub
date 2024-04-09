import 'package:ahnaf_readhub/app/modules/explore/views/explore_view.dart';
import 'package:ahnaf_readhub/app/modules/home/views/home_view.dart';
import 'package:ahnaf_readhub/app/modules/library/views/library_view.dart';
import 'package:ahnaf_readhub/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const Color colorSelect= Color(0xFF5000CA);
    const Color colorBackground= Color(0xFFF5F5F5);

    return GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
            body: Center(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: const [
                    HomeView(),
                    LibraryView(),
                    ExploreView(),
                    ProfileView(),
                  ],
                )
            ),

            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: colorSelect,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              showSelectedLabels: true,
              unselectedItemColor: const Color(0xFF000000).withOpacity(0.50),
              type: BottomNavigationBarType.fixed,
              backgroundColor: colorBackground,
              showUnselectedLabels: true,
              unselectedFontSize: 16,
              selectedFontSize: 14,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
              ),

              items: [
                _bottomNavigationBarItem(
                  imagePath: 'assets/images/dashboard/fitur1.png',
                  label: 'Home',
                ),
                _bottomNavigationBarItem(
                  imagePath: 'assets/images/dashboard/fitur2.png',
                  label: 'Library',
                ),
                _bottomNavigationBarItem(
                  imagePath: 'assets/images/dashboard/fitur3.png',
                  label: 'Search',
                ),
                _bottomNavigationBarItem(
                  imagePath: 'assets/images/dashboard/fitur4.png',
                  label: 'Profile',
                ),

              ],
            ),
          );
        }
    );
  }
  BottomNavigationBarItem _bottomNavigationBarItem({
    required String imagePath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(imagePath, width: 32, height: 32),
      label: label,
    );
  }
}
