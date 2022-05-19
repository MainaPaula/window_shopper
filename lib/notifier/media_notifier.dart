import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../models/media.dart';

class InstagramNotifier with ChangeNotifier {
  List<Instagram> _instagramList = [];


  UnmodifiableListView<Instagram> get instagramList => UnmodifiableListView(_instagramList);
  

  set instagramList(List<Instagram> instagramList){
    _instagramList = instagramList;
    notifyListeners();
  }
}

class FacebookNotifier with ChangeNotifier {
  List<Facebook> _facebookList = [];


  UnmodifiableListView<Facebook> get facebookList => UnmodifiableListView(_facebookList);


  set facebookList(List<Facebook> facebookList){
    _facebookList = facebookList;
    notifyListeners();
  }
}

class TwitterNotifier with ChangeNotifier {
  List<Twitter> _twitterList = [];


  UnmodifiableListView<Twitter> get twitterList => UnmodifiableListView(_twitterList);


  set twitterList(List<Twitter> twitterList){
    _twitterList = twitterList;
    notifyListeners();
  }
}
class PinterestNotifier with ChangeNotifier {
  List<Pinterest> _pinterestList = [];


  UnmodifiableListView<Pinterest> get pinterestList => UnmodifiableListView(_pinterestList);


  set pinterestList(List<Pinterest> pinterestList){
    _pinterestList = pinterestList;
    notifyListeners();
  }
}
