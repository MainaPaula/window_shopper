import 'dart:collection';
import 'package:flutter/cupertino.dart';

import '../models/views.dart';

class ProfileViewsNotifier with ChangeNotifier {
  List<ProfileViews> _viewsList = [];
  late ProfileViews _currentView;


  UnmodifiableListView<ProfileViews> get viewsList => UnmodifiableListView(_viewsList);

  ProfileViews get currentView => _currentView;

  set viewsList(List<ProfileViews> viewsList){
    _viewsList = viewsList;
    notifyListeners();
  }

  set currentView(ProfileViews search){
    _currentView = search;
    notifyListeners();
  }
}