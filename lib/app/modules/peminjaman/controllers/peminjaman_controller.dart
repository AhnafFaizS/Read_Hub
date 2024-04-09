import 'package:ahnaf_readhub/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class PeminjamanController extends GetxController with StateMixin{

  final id = Get.parameters['idBukuPeminjaman'];

  var loading = false.obs;

  late String formattedToday;
  late String formattedTwoWeeksLater;

  // CheckBox
  var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }

  // Data Peminjaman
  late String statusDataPeminjaman;

  @override
  void onInit() {
    super.onInit();

    // Get Tanggal hari ini
    DateTime todayDay = DateTime.now();

    // Menambahkan 14 hari ke tanggal hari ini
    DateTime twoWeeksLater = todayDay.add(const Duration(days: 14));

    // Format tanggal menjadi string menggunakan intl package
    formattedToday = DateFormat('yyyy-MM-dd').format(todayDay);
    formattedTwoWeeksLater = DateFormat('yyyy-MM-dd').format(twoWeeksLater);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addPeminjamanBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var bukuID = id.toString();

      var responsePostPeminjaman = await ApiProvider.instance().post(Endpoint.pinjamBuku,
        data: {
          "BukuID": bukuID,
        },
      );

      if (responsePostPeminjaman.statusCode == 201) {
        String judulBuku = Get.parameters['judulBuku'].toString();

        _showMyDialog(
              () {
            Get.offAllNamed(Routes.DASHBOARD);
          },
          Icons.alarm_rounded,
          "Peminjaman Berhasil",
          "Buku $judulBuku berhasil dipinjam",
          "Oke",
        );
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          Icons.alarm_rounded,
          "Pemberitahuan",
          "Buku gagal disimpan, silakan coba kembali",
          "Ok",
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                () {
              Navigator.pop(Get.context!, 'OK');
            },
            Icons.alarm_rounded,
            "Pemberitahuan",
            "${e.response?.data?['message']}",
            "Ok",
          );
        }
      } else {
        _showMyDialog(
              () {
            Navigator.pop(Get.context!, 'OK');
          },
          Icons.alarm_rounded,
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loading(false);
      _showMyDialog(
            () {
          Navigator.pop(Get.context!, 'OK');
        },
        Icons.alarm_rounded,
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> _showMyDialog(final onPressed, final IconData icons, String judul, String deskripsi, String nameButton) async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            icons,
            color: Colors.white,
            size: 50,
          ),
          backgroundColor: const Color(0xFF5000CA),
          title: Text(
            'ReadHub App',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
              color: const Color(0xFFFFFFFF),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  judul,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18.0
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  deskripsi,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 14.0
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: TextButton(
                autofocus: true,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F5F5),
                  animationDuration: const Duration(milliseconds: 300),
                ),
                onPressed: onPressed,
                child: Text(
                  nameButton,
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF5000CA),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
