import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_shopper/models/chart_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:window_shopper/notifier/search_notifier.dart';
import '../models/search.dart';
import '../models/views.dart';
import '../notifier/profile_views_model.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}
void getSearches(SearchNotifier searchNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collectionGroup('searchDetails').get();
  List<SearchModel> _searchList = [];

  snapshot.docs.forEach((element) {
    SearchModel searchModel = SearchModel.fromMap(element.data());
    _searchList.add(searchModel);
  });

  searchNotifier.searchList = _searchList;
}

void getProfileViews(ProfileViewsNotifier profileViewsNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collectionGroup('profileViews').get();
  List<ProfileViews> _viewsList = [];

  snapshot.docs.forEach((element) {
    ProfileViews profileViews = ProfileViews.fromMap(element.data());
    _viewsList.add(profileViews);
  });

  profileViewsNotifier.viewsList = _viewsList;
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  var dailyListingViews, weeklyListingViews, monthlyListingViews;
  @override
  void initState() {
    SearchNotifier searchNotifier = Provider.of<SearchNotifier>(context, listen: false);
    ProfileViewsNotifier profileViewsNotifier = Provider.of<ProfileViewsNotifier>(context, listen: false);

    getSearches(searchNotifier);
    getProfileViews(profileViewsNotifier);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SearchNotifier searchNotifier = Provider.of<SearchNotifier>(context);
    ProfileViewsNotifier profileViewsNotifier = Provider.of<ProfileViewsNotifier>(context);
    var i;
    var currentDay = DateTime.now();
    var dailyViews = currentDay.subtract(Duration(days: 1));
    var weeklyViews = currentDay.subtract(Duration(days: 7));
    var monthlyViews = currentDay.subtract(Duration(days: 30));

    final List<ChartModel> data = [
      ChartModel(
          media: 'Twitter',
          clicks: 10,
          color: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
      ChartModel(
          media: 'Instagram',
          clicks: 12,
          color: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
      ChartModel(
          media: 'Facebook',
          clicks: 16,
          color: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
      ChartModel(
          media: 'Pinterest',
          clicks: 5,
          color: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
    ];

    List<charts.Series<ChartModel, String>> series = [
      charts.Series(
        id: "media",
        data: data,
        domainFn: (ChartModel series, _) => series.media,
        measureFn: (ChartModel series, _) => series.clicks,
        colorFn: (ChartModel series, _) => series.color,
      )
    ];

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: const Text('Analytics',style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
            elevation: 0,
          ),
          body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          TextButton(onPressed: () {},
                              child: Text('Daily', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.redAccent)),
                          ),
                          SizedBox(width: 40,),

                          TextButton(onPressed: () {},
                            child: Text('Weekly', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black)),
                          ),
                          SizedBox(width: 40,),

                          TextButton(onPressed: () {},
                            child: Text('Monthly', style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black)),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        height: 15,
                        color: Colors.redAccent.shade400,
                        thickness: 3,
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Card(
                              color: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(dailyListingViews.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent,)),
                                    SizedBox(height: 5,),
                                    Text('Listing Vistings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black,), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            width: 100,
                            height: 100,
                            child: Card(
                              color: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent,)),
                                    SizedBox(height: 5,),
                                    Text('Ratings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black,), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Container(
                            width: 100,
                            height: 100,
                            child: Card(
                              color: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent,)),
                                    SizedBox(height: 5,),
                                    Text('Reviews', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black,), textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text('Social Media Interaction', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        height: 15,
                        color: Colors.redAccent.shade400,
                        thickness: 3,
                      ),
                    ),
                    SizedBox(height: 10),

                    Container(
                      height: 500,
                      padding: EdgeInsets.all(10),
                      child: charts.BarChart(
                        series,
                        animate: true,
                      ),
                    ),
                    SizedBox(height: 20,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text('Search Insights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        height: 15,
                        color: Colors.redAccent.shade400,
                        thickness: 3,
                      ),
                    ),
                    SizedBox(height: 10),
                    
                  ],
                ),
              ),
          )
      ),
    );
  }
}
