import 'package:ahnaf_readhub/app/routes/app_pages.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFitur extends StatelessWidget {
  final context;
  CustomFitur({
    super.key,
    required this.context,
  });

  List<CardItem> items = [
    CardItem(
      imageURl: "assets/images/fitur/logo1.png",
      judulBuku: "Book",
      onTap: (){

      },
    ),
    CardItem(
      imageURl: "assets/images/fitur/logo2.png",
      judulBuku: "Kategori",
      onTap: () {
      },
    ),
    CardItem(
      imageURl: "assets/images/fitur/logo3.png",
      judulBuku: "Favorite",
      onTap: ()=> Get.toNamed(Routes.SEARCH),
    ),
    CardItem(
      imageURl: "assets/images/fitur/logo4.png",
      judulBuku: "History",
      onTap: ()=> Get.toNamed(Routes.HISTORYPEMINJAMAN),
    )
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 95,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 1,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
  })=> InkWell(
    onTap: items.onTap,
    child: Container(
      height: 190,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Warna latar belakang kolom
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black.withOpacity(0.20), // Warna garis tepi (stroke)
          width: 1.0, // Lebar garis tepi
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: 3 / 3,
                  child: Image.asset(
                    items.imageURl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: AutoSizeText(
                items.judulBuku,
                maxLines: 1,
                maxFontSize: 16,
                minFontSize: 12,
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class CardItem {
  final String imageURl;
  final String judulBuku;
  final VoidCallback onTap;

  const CardItem({
    required this.imageURl,
    required this.judulBuku,
    required this.onTap,
  });
}
