import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../models/review_model.dart';

class ReviewNotifier with ChangeNotifier {
  List<Reviews> _reviewList = [];
  late Reviews _currentReview;

  UnmodifiableListView<Reviews> get reviewList => UnmodifiableListView(_reviewList);

  Reviews get currentReview => _currentReview;

  set reviewList(List<Reviews> reviewList){
    _reviewList = reviewList;
    notifyListeners();
  }

  set currentReview(Reviews review){
    _currentReview = review;
    notifyListeners();
  }
}