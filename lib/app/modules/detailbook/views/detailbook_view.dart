import 'package:ahnaf_readhub/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 50;

    const Color background = Color(0xFFF6F6F6);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          toolbarHeight: 50,
          title: Text(
            'Detail Buku ${Get.parameters['judul'].toString()}',
            style: GoogleFonts.inter(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            Obx(() {
              var dataBuku = controller.dataDetailBook.value?.buku;
              return SizedBox(
                width: 50,
                height: 50,
                child: IconButton(
                  icon: Icon(
                    dataBuku?.status == 'Tersimpan'
                        ? FontAwesomeIcons.bookBookmark
                        : FontAwesomeIcons.bookmark,
                    color: dataBuku?.status == 'Tersimpan'
                        ? const Color(0xFF5000CA)
                        : Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                    if (dataBuku?.status == 'Tersimpan') {
                      controller.deleteKoleksiBook(dataBuku!.bukuID.toString(),context);
                    } else {
                      controller.addKoleksiBuku(Get.context!);
                    }
                  },
                ),
              );
            })
          ],
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: RefreshIndicator(
          onRefresh: () async{
            await controller.getDataDetailBuku(Get.parameters['id']);
          },
          child: Container(
            width: width,
            height: bodyHeight,
            color: background,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 95), // Sesuaikan dengan tinggi tombol
                    child: kontenDataDetailBuku(),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: width,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        border: Border(
                          top: BorderSide(
                            color: const Color(0xFF424242).withOpacity(0.20),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: buttonDetailBuku(),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget kontenDataDetailBuku() {
    final height = MediaQuery.of(Get.context!).size.height;

    return Obx(
          () {
        if (controller.dataDetailBook.value == null) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5000CA)),
              ),
            ),
          );
        } else if (controller.dataDetailBook.value == null) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5000CA)),
              ),
            ),
          );
        } else {
          var dataBuku = controller.dataDetailBook.value?.buku;
          var dataKategori = controller.dataDetailBook.value?.kategori;
          var dataUlasan = controller.dataDetailBook.value?.ulasan;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.050,
                ),

                Center(
                  child: SizedBox(
                    width: 120,
                    height: 180,
                    child: Image.network(
                      dataBuku!.coverBuku.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.030,
                ),

                FittedBox(
                  child: Text(
                    dataBuku.judul!,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      color: const Color((0xFF5000CA)),
                      fontSize: 26.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                FittedBox(
                  child: Text(
                    "Penulis: ${dataBuku.penulis!}",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(
                  height: height * 0.010,
                ),

                // Menampilkan rating di bawah teks penulis
                RatingBarIndicator(
                  rating: dataBuku.rating!,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),

                SizedBox(
                  height: height * 0.020,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Deskripsi Buku:",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Text(
                      dataBuku.deskripsi!,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.80),
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    SizedBox(
                      height: height * 0.025,
                    ),
                    Wrap(
                      children: dataKategori!.map((kategori) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            onPressed: () {
                              // Tambahkan fungsi yang ingin dijalankan saat tombol ditekan
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey.withOpacity(0.25),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              kategori,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    FittedBox(
                      child: Text(
                        "Penerbit: ${dataBuku.penerbit!}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),
                    FittedBox(
                      child: Text(
                        "Jumlah Halaman: ${dataBuku.jumlahHalaman!}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),
                    FittedBox(
                      child: Text(
                        "Tahun: ${dataBuku.tahunTerbit!}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),
                    FittedBox(
                      child: Text(
                        "Jumlah Peminjam: ${dataBuku.jumlahPeminjam!}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.025,
                    ),
                    Text(
                      "Ulasan Buku",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.010,
                    ),
                    buildUlasanList(dataUlasan),

                    SizedBox(
                      height: height * 0.010,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF424242).withOpacity(0.05),
                  width: 0.1,
                )),
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/icon_aplikasi.png',
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            Text(
                              ulasan.users?.username ?? '',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      // Menampilkan rating di bawah teks penulis
                      RatingBarIndicator(
                        direction: Axis.horizontal,
                        rating: ulasan.rating!.toDouble(),
                        itemCount: 5,
                        itemSize: 10,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    ulasan.ulasan ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.30),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget buttonDetailBuku() {
    const Color buttonColor = Color(0xFF5000CA);
    const Color borderColor = Color(0xFF424242);

    return Obx((){
      var dataBuku = controller.dataDetailBook.value?.buku;
      return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: borderColor.withOpacity(0.30),
              width: 1.3,
            ),
          ),
          onPressed: () {
            if (dataBuku?.statusPeminjaman == 'Belum dipinjam') {
              Get.toNamed(
                  Routes.PEMINJAMAN,
                parameters: {
                    'idBukuPeminjaman' : dataBuku!.bukuID.toString(),
                    'judulBuku' : dataBuku!.judul.toString(),
                }
              );
            }else if(dataBuku?.statusPeminjaman == 'Dipinjam'){
              return;
            }
          },
          child: Text(
            dataBuku?.statusPeminjaman == 'Belum dipinjam'
                ? 'Pinjam Buku' : 'Dipinjam',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
