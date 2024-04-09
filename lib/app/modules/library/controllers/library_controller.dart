import 'package:ahnaf_readhub/app/data/model/buku/response_all_book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_kategori.dart';
import '../../../data/provider/api_provider.dart';

class LibraryController extends GetxController with StateMixin{
  var dataSemuaBook = RxList<DataBook>();
  var dataKategori = RxList<DataKategori>();

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataKategori();
    getDataAllBuku();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void RefreshData(){
    getDataAllBuku();
    getDataKategori();
  }

  // Get Data Buku
  Future<void> getDataAllBuku() async {
    dataSemuaBook.clear();
    change(null, status: RxStatus.loading());

    try {
      final keyword = searchController.text.toString();
      final responseSemuaBook;

      if(keyword == ''){
        responseSemuaBook = await ApiProvider.instance().get('${Endpoint.buku}all/buku/null');
      }else{
        responseSemuaBook = await ApiProvider.instance().get('${Endpoint.buku}all/buku/$keyword');
      }

      if (responseSemuaBook.statusCode == 200) {
        final ResponseAllBook responseBook = ResponseAllBook.fromJson(responseSemuaBook.data!);

        if (responseBook.data!.isEmpty) {
          dataSemuaBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataSemuaBook(responseBook.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getDataKategori() async {
    dataKategori.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseKategori = await ApiProvider.instance().get(Endpoint.kategoriBuku);

      if (responseKategori.statusCode == 200) {
        final ResponseKategori responseKategoriBuku = ResponseKategori.fromJson(responseKategori.data);

        if (responseKategoriBuku.data!.isEmpty) {
          dataKategori.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataKategori(responseKategoriBuku.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
