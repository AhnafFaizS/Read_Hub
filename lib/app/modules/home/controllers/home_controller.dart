import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_new_book.dart';
import '../../../data/provider/api_provider.dart';

class HomeController extends GetxController with StateMixin {
  var newBooks = RxList<DataBukuBaru>();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    newBooks.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseNew = await ApiProvider.instance().get(Endpoint.bukuNew);

      if (responseNew.statusCode == 200) {
        final ResponseNewBook responseBukuNew = ResponseNewBook.fromJson(responseNew.data);

        if (responseBukuNew.data!.isEmpty) {
          newBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          newBooks.assignAll(responseBukuNew.data!);
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
