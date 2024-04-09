import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/buktipeminjaman_controller.dart';

class BuktipeminjamanView extends GetView<BuktipeminjamanController> {
  const BuktipeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // const Color textColor = Color(0xFF7174BD);
    const Color buttonColor = Color(0xFF5000CA);

    // Font Size

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

                Obx((){
                  var dataPeminjaman = controller.detailPeminjaman.value;

                  if(controller.detailPeminjaman.value == null){
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5000CA)),
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Bukti Peminjaman Buku',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: Colors.black,
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.020,
                        ),

                        Text(
                          dataPeminjaman!.kodePeminjaman.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF5000CA),
                            fontWeight: FontWeight.w900,
                            fontSize: 32,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.030,
                        ),

                        kontenBuktiPeminjaman(
                            'Tanggal Peminjaman', dataPeminjaman.tanggalPinjam.toString()
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        kontenBuktiPeminjaman(
                            'Deadline Peminjaman', dataPeminjaman.deadline.toString()
                        ),

                        SizedBox(
                          height: height * 0.040,
                        ),

                        Divider(
                          color: Colors.black.withOpacity(0.10),
                          thickness: 1,
                        ),

                        SizedBox(
                          height: height * 0.030,
                        ),

                        kontenBuktiPeminjaman(
                            'Nama Peminjam', dataPeminjaman.username.toString()
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        kontenBuktiPeminjaman(
                            'Nama Buku', dataPeminjaman.judulBuku.toString()
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        kontenBuktiPeminjaman(
                            'Penulis Buku', dataPeminjaman.penulisBuku.toString()
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        kontenBuktiPeminjaman(
                            'Tahun Terbit', dataPeminjaman.tahunBuku.toString()
                        ),

                        SizedBox(
                          height: height * 0.045,
                        ),

                        SizedBox(
                            width: double.infinity,
                            height: 45.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              onPressed: (){
                                Get.back();
                              },
                              child: Text(
                                'Kembali',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            )
                        )
                      ],
                    ),
                  );
                }),

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

  Widget kontenBuktiPeminjaman(String judul, String isi){
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          ),

          Flexible(
            flex: 3,
            child: Text(
              isi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }
}
