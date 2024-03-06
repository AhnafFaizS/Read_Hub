import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPopulerBuku extends StatelessWidget {
  final context;
  CustomPopulerBuku({
    super.key,
    required this.context
  });

  List<CardItem> items = [
    const CardItem(
      imageURl: "assets/images/buku/buku1.png",
      judulBuku: "Black Holes and Baby Universes",
    ),
    const CardItem(
      imageURl: "assets/images/buku/buku2.png",
      judulBuku: "Laut Bercerita",
    ),
    const CardItem(
      imageURl: "assets/images/buku/buku3.png",
      judulBuku: "I Am My Own Home",
    ),
    const CardItem(
      imageURl: "assets/images/buku/buku4.png",
      judulBuku: "Mobil",
    ),
    const CardItem(
      imageURl: "assets/images/buku/buku5.png",
      judulBuku: "The Art of Investhink",
    ),
    const CardItem(
      imageURl: "assets/images/buku/buku1.png",
      judulBuku: "Black Holes and Baby Universes",
    )
  ];

  @override
  Widget build(BuildContext context) {
    int kartuPerBaris = 3; // Jumlah kartu per baris
    double tinggiKartu = 210.0; // Tinggi kartu
    double spacingVertikal = 15.0; // Spasi vertikal antara kartu

    double totalHeight = ((items.length / kartuPerBaris) * (tinggiKartu + spacingVertikal)) + spacingVertikal;
     return Container(
       height: totalHeight,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 6,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
  })=> Container(
    height: 170,
    width: 100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(
                items.imageURl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        AutoSizeText(
          items.judulBuku,
          maxLines: 2,
          maxFontSize: 16,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}

class CardItem {
  final String imageURl;
  final String judulBuku;

  const CardItem({
    required this.imageURl,
    required this.judulBuku,
  });
}
