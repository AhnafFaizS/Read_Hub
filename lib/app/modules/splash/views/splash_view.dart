import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // untuk berpindah halaman otomatis setelah 4 detik
    Future.delayed(const Duration(milliseconds: 4000), (() {
      String? status = StorageProvider.read(StorageKey.status);
      if (status == "logged") {
        Get.offAllNamed(Routes.DASHBOARD);
      }else{
        Get.offAllNamed(Routes.ONBOARDING);
      }
    }));

    return Scaffold(
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // memberikan latar belakang
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/splash/gambar_atas.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Image.asset(
                          'assets/images/splash/logo_readhub.png'
                      ),
                    ),
                    const CircularProgressIndicator(
                      color: Colors.black,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5000CA)),
                    ),
                  ],
                ),

                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/splash/gambar_bawah.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
