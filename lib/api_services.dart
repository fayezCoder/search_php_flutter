import 'dart:convert';

import 'package:search_php_flutter/data_model.dart';
import 'package:http/http.dart' as http;

class FetchData {
  var data = [];
  List<DataModel> result = [];
  String fetchurl = "https://jsonplaceholder.typicode.com/users";
  Future<List<DataModel>> getDataList({String? query}) async {
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        result = data.map((e) => DataModel.fromJson(e)).toList();
        if (query != null) {
          result = result
              .where((element) =>
                  element.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print("api error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return result;
  }
}
