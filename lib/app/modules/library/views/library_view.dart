import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color backgroundInput = Color(0xFFF5F5F5);

    double textField = 14.0;

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          controller.RefreshData();
        },
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(
                height: height * 0.050,
              ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.010,
                    ),
                    TextFormField(
                      controller: controller.searchController,
                      style: GoogleFonts.inter(
                          fontSize: textField,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      onChanged: (value){
                        controller.getDataAllBuku();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: backgroundInput,
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: 'Enter book title or author',
                        hintStyle: GoogleFonts.inter(
                            fontSize: textField,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email tidak boleh kosong!';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.020,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori Buku',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    sectionKategoriBuku(),
                  ],),

                  Obx(() =>
                      kontenSemuaBuku(),
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),
              ]
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget sectionKategoriBuku() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return SizedBox(
              height: MediaQuery.of(Get.context!).size.height * 0.060,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.dataKategori.length,
                  itemBuilder: (context, index) {
                    var bukuList = controller.dataKategori[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: SizedBox(
                        child: TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.BOOKBYKATEGORI,
                                parameters: {
                                  'idKategori': (bukuList.kategoriID ?? 0).toString(),
                                  'namaKategori': (bukuList.namaKategori!).toString()
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: Colors.grey.withOpacity(0.25),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                bukuList.namaKategori!,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
  
  Widget kontenSemuaBuku() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 6.7,
      ),
      itemCount: controller.dataSemuaBook.length,
      itemBuilder: (context, index) {
        var buku = controller.dataSemuaBook[index];
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
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
}
