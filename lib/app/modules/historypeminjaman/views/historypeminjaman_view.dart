import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          titleSpacing: -10,
          title: sectionTextBookmark(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5000CA),
                ),
                onPressed: () async{
                  await controller.getDataPeminjaman();
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

                  Obx(() => controller.historyPeminjaman.isEmpty ?
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
          'History Peminjaman',
          maxLines: 1,
          style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700
          ),
        ),

        Text(
          'Kumpulan dataHistory yang dipinjam',
          maxLines: 1,
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
      itemCount: controller.historyPeminjaman.length,
      itemBuilder: (context, index) {
        var dataHistory = controller.historyPeminjaman[index];
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
              dataHistory.status == 'Selesai' ? controller.kontenBeriUlasan(dataHistory.bukuId.toString(), dataHistory.judulBuku.toString()) :
              Get.toNamed(Routes.BUKTIPEMINJAMAN, parameters: {
                'idPeminjaman': dataHistory.peminjamanID.toString(),
                'asalHalaman' : 'historyPeminjaman',
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: 3 / 4 ,
                          child: Image.network(
                            dataHistory.coverBuku.toString(),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),

                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: dataHistory.status == 'Ditolak'
                                    ? const Color(0xFFEA1818)
                                    : dataHistory.status == 'Dipinjam'
                                    ? const Color(0xFF56526F)
                                    : dataHistory.status ==
                                    'Selesai'
                                    ? const Color(0xFF5000CA)
                                    : const Color(0xFF1B1B1D),),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    dataHistory.status == 'Selesai' ? const SizedBox() : const FaIcon(
                                      FontAwesomeIcons.circleInfo,
                                      color: Colors.white,
                                      size: 20,
                                    ),


                                    dataHistory.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                      width: 10,
                                    ),

                                    Text(
                                      dataHistory.status == 'Selesai' ? 'Beri Ulasan' : dataHistory.status.toString(),
                                      style: GoogleFonts.averiaGruesaLibre(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
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
                              dataHistory.judulBuku!,
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
