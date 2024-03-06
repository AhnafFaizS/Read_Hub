import 'package:ahnaf_readhub/app/components/customFitur.dart';
import 'package:ahnaf_readhub/app/components/customPopulerBuku.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        automaticallyImplyLeading: false,
        title: Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/images/logo_small.png',
                ),
              ),
              SizedBox(
                child: Image.asset(
                  'assets/images/dashboard/fitur2.png',
                  height: 30.0,
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        width: width,
        height : height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomFitur(
                    context: Get.context!
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: kontenBuku(),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget kontenBuku(){
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Buku Populer',
                    maxFontSize: 25,
                    minFontSize: 20,
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  AutoSizeText(
                    'Check out our top picks',
                    maxFontSize: 17,
                    minFontSize: 12,
                    maxLines: 1,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5000CA),
                ),
                onPressed: () {
                  // Tambahkan logika untuk tombol di sini
                },
                icon: Icon(Icons.next_plan, color: Colors.white,),
                label: const Text(
                  "View All",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: CustomPopulerBuku(context: Get.context!),
          ),
        ],
      ),
    );
  }
}
