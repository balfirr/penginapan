import 'dart:convert';
import 'package:toko_kita/ui/pariwisata_page.dart';

import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '../model/pariwisata.dart';

class ProdukBloc {
  static Future<List<Pariwisata>> getProduks() async {
    String apiUrl = ApiUrl.listPariwisata;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listPariwisata = (jsonObj as Map<String, dynamic>)['data'];
    List<Pariwisata> pariwisatas = [];
    for (int i = 0; i < listPariwisata.length; i++) {
      pariwisatas.add(Pariwisata.fromJson(listPariwisata[i]));
    }
    return pariwisatas;
  }

  static Future addPariwisata({Pariwisata? pariwisata}) async {
    String apiUrl = ApiUrl.createPariwisata;

    var body = {
      "accomodation": pariwisata!.accomodation,
      "room": pariwisata.room,
      "rate": pariwisata.rate.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updatePariwisata({required Pariwisata pariwisata}) async {
    String apiUrl = ApiUrl.updatePariwisata(pariwisata.id!);
    print(apiUrl);

    var body = {
      "accomodation": pariwisata.accomodation,
      "room": pariwisata.room,
      "rate": pariwisata.rate
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deletePariwisata({int? id}) async {
    String apiUrl = ApiUrl.deletePariwisata(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
