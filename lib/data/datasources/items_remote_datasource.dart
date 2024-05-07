import 'dart:convert';

import 'package:blocapp/data/models/items_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ItemsRemoteDataSource {
  Future<List<ItemsModal>> getItemsFromApi();
}

class ItemsRemoteDataSourceImp implements ItemsRemoteDataSource {
  final client = http.Client();
  @override
  Future<List<ItemsModal>> getItemsFromApi() async {
    try {
      final response = await client.get(
          Uri.parse('https://fakestoreapi.com/products'),
          headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        final List<ItemsModal> items =
            responseBody.map((json) => ItemsModal.fromJson(json)).toList();
        return items;
      } else {
        throw Exception("Failed to load");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  Future<dynamic> checklogin(String? user, String? password) async {
    Response res = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "username": user.toString(),
          "password": password.toString(),
          "id": "3"
        }));
    return res;
  }
}
