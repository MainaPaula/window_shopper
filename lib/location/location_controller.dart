import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'location_service.dart';


class LocationController extends GetxController {
  Placemark _selectPlacemark = Placemark();
  Placemark get selectPlacemark => _selectPlacemark;

  List<Prediction> predList = [];

  Future<List<Prediction>> searchMapLocation(BuildContext context, String text) async {
    if(text !=  null && text.isNotEmpty) {
      http.Response response = await getLocationInfo(text);
      var data = jsonDecode(response.body.toString());
      print('My status is '+data['status']);
      if(data['status'] == 'OK') {
        predList = [];
        data['predictions'].forEach((prediction) => predList.add(Prediction.fromJson(prediction)));
      } else {
        //ApiChecker.checkApi(response);
      }
    }
    return predList;
  }
}