import 'package:ahnaf_readhub/app/components/customFitur.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/app_pages.dart';
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
        title: SizedBox(
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

      body: RefreshIndicator(
        onRefresh: () async{
          await controller.getData();
        },
        child: SizedBox(
          width: width,
          height : height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
        ),
      )
    );
  }

  Widget kontenBuku(){
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Buku Terbaru',
                      maxFontSize: 25,
                      minFontSize: 20,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700
                      ),
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
              ),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5000CA),
                ),
                onPressed: () {
                  // Tambahkan logika untuk tombol di sini
                },
                icon: const Icon(Icons.next_plan, color: Colors.white,),
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
            child: Obx(() => controller.newBooks.isEmpty ?
                shimmerkontenBukuTerbaru() : kontenBukuTerbaru(),
            ),
          ),
        ],
      ),
    );
  }

  Widget kontenBukuTerbaru() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 6.7,
      ),
      itemCount: controller.newBooks.length,
      itemBuilder: (context, index) {
        var buku = controller.newBooks[index];
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
              Get.toNamed(Routes.DETAILBOOK,
                parameters: {
                  'id': (buku.bukuID ?? 0).toString(),
                  'judul': (buku.judulBuku!).toString()
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
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          buku.judulBuku!,
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
                            "Penulis: ${buku.penulisBuku!}",
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
                            "${ buku.jumlahHalaman!} Halaman",
                            maxLines : 1,
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

  Widget shimmerkontenBukuTerbaru(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 6,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  height: 230,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: double.infinity,
                          height: 18,
                          color: Colors.white,
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Container(
                          width: double.infinity,
                          height: 12,
                          color: Colors.white,
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Container(
                          width: double.infinity,
                          height: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
