import 'dart:convert';
import 'package:supermarketkita/helpers/api.dart';
import 'package:supermarketkita/helpers/api_url.dart';
import 'package:supermarketkita/model/produk.dart';

class ProdukBloc {
  /// GET LIST PRODUK
  static Future<List<Produk>> getProduks() async {
    try {
      String apiUrl = ApiUrl.listproduk;
      var response = await Api().get(apiUrl);
      var jsonObj = json.decode(response.body);

      List<dynamic> listproduk = jsonObj['data'];
      List<Produk> produks =
          listproduk.map((item) => Produk.fromJson(item)).toList();

      return produks;
    } catch (e) {
      print('Error getProduks: $e');
      rethrow;
    }
  }

  /// ADD PRODUK
  static Future addProduk({required Produk produk}) async {
    try {
      String apiUrl = ApiUrl.createproduk;
      var body = {
        "judul": produk.judul,
        "harga": produk.harga.toString(),
        "jumlah": produk.jumlah.toString(),
        "tanggal_masuk": produk.tanggalMasuk,
        "volume": produk.volume.toString(),
        "penulis": produk.penulis,
        "penerbit": produk.penerbit,
      };

      print('addProduk URL: $apiUrl');
      print('addProduk Body: $body');

      var response = await Api().post(apiUrl, body);
      var jsonObj = json.decode(response.body);

      print('addProduk Response: $jsonObj');

      return jsonObj['status'];
    } catch (e) {
      print('Error addProduk: $e');
      rethrow;
    }
  }

  /// UPDATE PRODUK
  static Future updateProduk({required Produk produk}) async {
    try {
      String apiUrl = ApiUrl.updateproduk(int.parse(produk.id!));
      var body = {
        "judul": produk.judul,
        "harga": produk.harga.toString(),
        "jumlah": produk.jumlah.toString(),
        "tanggal_masuk": produk.tanggalMasuk,
        "volume": produk.volume.toString(),
        "penulis": produk.penulis,
        "penerbit": produk.penerbit,
      };

      print('updateProduk URL: $apiUrl');
      print('updateProduk Body: $body');

      var response = await Api().put(apiUrl, body);
      var jsonObj = json.decode(response.body);

      print('updateProduk Response: $jsonObj');

      return jsonObj['status'];
    } catch (e) {
      print('Error updateProduk: $e');
      rethrow;
    }
  }

  /// DELETE PRODUK
  static Future deleteProduk({required int id}) async {
    try {
      String apiUrl = ApiUrl.deleteproduk(id);

      print('deleteProduk URL: $apiUrl');

      var response = await Api().delete(apiUrl);
      var jsonObj = json.decode(response.body);

      print('deleteProduk Response: $jsonObj');

      return jsonObj['status'];
    } catch (e) {
      print('Error deleteProduk: $e');
      rethrow;
    }
  }
}
