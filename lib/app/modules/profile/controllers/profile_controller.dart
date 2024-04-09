import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController with StateMixin{

  final loadingLogout = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  logout() async {
    loadingLogout(true);
    try {
      FocusScope.of(Get.context!).unfocus();

      var response = await ApiProvider.instance().post(
          Endpoint.logout
      );

      if (response.statusCode == 200) {

        StorageProvider.clearAll();
        _showMyDialog(
                (){
              Get.offAllNamed(Routes.LOGIN);
            },
            Icons.info,
            "Pemberitahuan",
            "Logout Berhasil, silakan login kembali",
            "Ok"
        );
      } else {
        _showMyDialog(
                (){
              Navigator.pop(Get.context!, 'OK');
            },
            Icons.info,
            "Pemberitahuan",
            "Logout gagal, silakan coba lagi",
            "Ok"
        );
      }
      loadingLogout(false);
    } on DioException catch (e) {
      loadingLogout(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              Icons.info,
              "Pemberitahuan",
              "${e.response?.data['message']}",
              "Ok"
          );
        }
      } else {
        _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          Icons.info,
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loadingLogout(false);
      _showMyDialog(
            (){
          Navigator.pop(Get.context!, 'OK');
        },
        Icons.info,
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
