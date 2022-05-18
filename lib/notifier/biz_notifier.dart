import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../models/listing.dart';

class BusinessNotifier with ChangeNotifier {
  List<Businesses> _businessList = [];
  late Businesses _currentBusiness;


  UnmodifiableListView<Businesses> get businessList => UnmodifiableListView(_businessList);

  Businesses get currentBusiness => _currentBusiness;

  set businessList(List<Businesses> businessList){
    _businessList = businessList;
    notifyListeners();
  }

  set currentBusiness(Businesses business){
    _currentBusiness = business;
    notifyListeners();
  }
}

