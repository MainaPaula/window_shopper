import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../models/search.dart';

class SearchNotifier with ChangeNotifier {
  List<SearchModel> _searchList = [];
  late SearchModel _currentSearch;


  UnmodifiableListView<SearchModel> get searchList => UnmodifiableListView(_searchList);

  SearchModel get currentSearch => _currentSearch;

  set searchList(List<SearchModel> searchList){
    _searchList = searchList;
    notifyListeners();
  }

  set currentSearch(SearchModel search){
    _currentSearch = search;
    notifyListeners();
  }
}