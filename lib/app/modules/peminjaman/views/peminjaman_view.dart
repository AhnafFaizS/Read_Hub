import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/peminjaman_controller.dart';

class PeminjamanView extends GetView<PeminjamanController> {
  const PeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // const Color textColor = Color(0xFF7174BD);
    const Color buttonColor = Color(0xFF5000CA);
    const Color backgroundInput = Color(0xFFF5F5F5);

    // Font Size
    double heading = 30.0;
    double textField = 18.0;
    double textButton = 20.0;

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,// Change this color as needed
    ));

    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'Peminjaman Buku!',
                          style: GoogleFonts.holtwoodOneSc(
                            color: buttonColor,
                            fontSize: heading,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Judul Buku',
                                style: GoogleFonts.inter(
                                  color: buttonColor,
                                  fontSize: textField,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.010),
                                child: TextFormField(
                                  initialValue: Get.parameters['judulBuku'].toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: textField,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                  ),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: backgroundInput,
                                    prefixIcon: const Icon(Icons.book),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20.0),
                                  ),
                                ),
                              ),

                              Text(
                                'Tanggal Pinjam',
                                style: GoogleFonts.inter(
                                  color: buttonColor,
                                  fontSize: textField,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.010),
                                child: TextFormField(
                                  initialValue: controller.formattedToday.toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: textField,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                  ),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: backgroundInput,
                                    prefixIcon: const Icon(Icons.date_range_rounded),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20.0),
                                  ),
                                ),
                              ),

                              Text(
                                'Deadline Pengembalian',
                                style: GoogleFonts.inter(
                                  color: buttonColor,
                                  fontSize: textField,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(vertical: height * 0.010),
                                child: TextFormField(
                                  initialValue: controller.formattedTwoWeeksLater.toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: textField,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                  ),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: backgroundInput,
                                    prefixIcon: const Icon(Icons.date_range_rounded),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 50.0,
                                  child: Obx(() => controller.loading.value?
                                  const CircularProgressIndicator(
                                    color: buttonColor,
                                  ): ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: buttonColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5.5))),
                                      onPressed: () => controller.addPeminjamanBuku(),
                                      child: Text(
                                        "Pinjam Sekarang",
                                        style: GoogleFonts.inter(
                                            fontSize: textButton,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                  )
                                  )
                              ),
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
