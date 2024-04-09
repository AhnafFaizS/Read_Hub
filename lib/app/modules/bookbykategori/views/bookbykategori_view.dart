import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookbykategori_controller.dart';

class BookbykategoriView extends GetView<BookbykategoriController> {
  const BookbykategoriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: -10,
          title: Text(
            'Kategori Buku ${Get.parameters['namaKategori']}',
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          centerTitle: false,
        ),
        body: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(() => kontenSemuaBuku()),
          )),
        ));
  }

  Widget kontenSemuaBuku() {
    if (controller.dataBookByKategori.isEmpty) {
      return kontenDataKosong(Get.parameters['namaKategori'].toString());
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 6.7,
        ),
        itemCount: controller.dataBookByKategori.length,
        itemBuilder: (context, index) {
          var buku = controller.dataBookByKategori[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF000000).withOpacity(0.10),
                width: 1,
              ),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      buku.coverBuku.toString(),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            buku.judul!,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF5000CA),
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          FittedBox(
                            child: Text(
                              "Penulis: ${buku.penulis!}",
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 10.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          FittedBox(
                            child: Text(
                              "${buku.jumlahHalaman!} Halaman",
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          // Menampilkan rating di bawah teks penulis
                          buku.rating != null && buku.rating! > 0
                              ? RatingBarIndicator(
                                  direction: Axis.horizontal,
                                  rating: buku.rating!,
                                  itemCount: 5,
                                  itemSize: 15,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color(0xFF5000CA),
                                  ),
                                )
                              : RatingBarIndicator(
                                  direction: Axis.horizontal,
                                  rating: buku.rating!,
                                  itemCount: 5,
                                  itemSize: 15,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget kontenDataKosong(String text) {
    const Color background = Color(0xFF5000CA);
    return Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Sorry Data $text Empty!',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
