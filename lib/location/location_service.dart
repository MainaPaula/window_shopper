import 'dart:convert';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getLocationInfo(String text) async {
  http.Response res;

  res = await http.get(Uri.parse("http://mvs.bslmeiyu.com/api/v1/config/place-api-autocomplete?search_text=$text"), headers: {"Content-Type": "application/json"},);

  print(jsonDecode(res.body));
  return res;
}

