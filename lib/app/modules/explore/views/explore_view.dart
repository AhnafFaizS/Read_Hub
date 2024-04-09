import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        titleSpacing: 15,
        title: sectionTextBookmark(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5000CA),
              ),
              onPressed: () async{
                await controller.getData();
              },
              icon: const Icon(Icons.refresh_rounded, color: Colors.white,),
              label: const Text(
                "Refresh",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                const SizedBox(
                  height: 10,
                ),

                Obx(() => controller.koleksiBook.isEmpty ?
                    sectionDataKosong('Koleksi Buku') : sectionKoleksiBook(),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  
  Widget sectionTextBookmark(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Koleksi Buku',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700
          ),
        ),

        Text(
          'Kumpulan buku yang tersimpan',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }

  Widget sectionKoleksiBook() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 5.5,
      ),
      itemCount: controller.koleksiBook.length,
      itemBuilder: (context, index) {
        var buku = controller.koleksiBook[index];
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: 3 / 4 ,
                      child: Image.network(
                        buku.coverBuku.toString(),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.asset(
                              "assets/images/fitur/logo2.png",
                              fit: BoxFit.fill,
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Expanded(
                            child: Text(
                              buku.judul!,
                              maxLines: 2,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF5000CA),
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget sectionDataKosong(String text){
    const Color background = Color(0xFF5000CA);
    const Color borderColor = Colors.white;
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 1.3,
          )
      ),
      child: Center(
        child: Center(
          child: Text(
            'Maaf Data $text Kosong!',
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
