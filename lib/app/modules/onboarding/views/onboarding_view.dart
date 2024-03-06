import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color textColor = Color(0xFF7174BD);
    const Color buttonColor = Color(0xFF5000CA);

    return Scaffold(

      body: Container(
        child: Center(
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

              SizedBox(
                child: Column(
                  children: [
                    Image.asset(
                        'assets/images/splash/logo_readhub.png'
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: AutoSizeText(
                        'Welcome to',
                        style: GoogleFonts.holtwoodOneSc(
                          color: textColor,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w800,
                        ),
                        minFontSize: 25.0,
                        maxFontSize: 35.0,
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                        child: Center(
                          child: AutoSizeText(
                            '"READ HUB" bisa diartikan sebagai "pusat membaca" '
                                'dalam bahasa Inggris. "READ" mencerminkan aksi membaca, '
                                'sedangkan "HUB" menunjukkan pusat atau tempat kumpulan.',
                            style: GoogleFonts.holtwoodOneSc(
                              color: textColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 12.0,
                            maxFontSize: 16.0,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),

                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                        child: Column(
                          children: [
                            SizedBox(
                                width: double.infinity,
                                height: 45.0,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.5))),
                                    onPressed: () => Get.toNamed(Routes.LOGIN),
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.inriaSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ))),

                            const SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                                width: double.infinity,
                                height: 45.0,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor.withOpacity(0.50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.5))),
                                    onPressed: () => Get.toNamed(Routes.REGISTER),
                                    child: Text(
                                      "Register",
                                      style: GoogleFonts.inriaSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white),
                                    ))),
                          ],
                        )
                    ),
                  ],
                ),
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
