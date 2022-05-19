import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_shopper/models/chart_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:window_shopper/models/media.dart';
import 'package:window_shopper/notifier/media_notifier.dart';
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

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final currentUser = FirebaseAuth.instance.currentUser?.uid;

  void getProfileViews(ProfileViewsNotifier profileViewsNotifier) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("businesses").doc(currentUser).collection('profileViews').get();
    List<ProfileViews> _viewsList = [];

    snapshot.docs.forEach((element) {
      ProfileViews profileViews = ProfileViews.fromMap(element.data());
      _viewsList.add(profileViews);
    });

    profileViewsNotifier.viewsList = _viewsList;
  }
  void getFacebookViews(FacebookNotifier facebookNotifier) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("businesses").doc(currentUser).collection('facebook_clicks').get();
    List<Facebook> _facebookViewsList = [];

    snapshot.docs.forEach((element) {
      Facebook facebookViews = Facebook.fromMap(element.data());
      _facebookViewsList.add(facebookViews);
    });

    facebookNotifier.facebookList = _facebookViewsList;
  }
  void getInstagramViews(InstagramNotifier instagramNotifier) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("businesses").doc(currentUser).collection('instagram_clicks').get();
    List<Instagram> _instagramViewsList = [];

    snapshot.docs.forEach((element) {
      Instagram instagramViews = Instagram.fromMap(element.data());
      _instagramViewsList.add(instagramViews);
    });

    instagramNotifier.instagramList = _instagramViewsList;
  }
  void getTwitterViews(TwitterNotifier twitterNotifier) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("businesses").doc(currentUser).collection('twitter_clicks').get();
    List<Twitter> _twitterViewsList = [];

    snapshot.docs.forEach((element) {
      Twitter twitterViews = Twitter.fromMap(element.data());
      _twitterViewsList.add(twitterViews);
    });

    twitterNotifier.twitterList = _twitterViewsList;
  }

  void getPinterestViews(PinterestNotifier pinterestNotifier) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("businesses").doc(currentUser).collection('pinterest_clicks').get();
    List<Pinterest> _pinterestViewsList = [];

    snapshot.docs.forEach((element) {
      Pinterest pinterestViews = Pinterest.fromMap(element.data());
      _pinterestViewsList.add(pinterestViews);
    });

    pinterestNotifier.pinterestList = _pinterestViewsList;
  }

  @override
  void initState() {
    SearchNotifier searchNotifier = Provider.of<SearchNotifier>(context, listen: false);
    ProfileViewsNotifier profileViewsNotifier = Provider.of<ProfileViewsNotifier>(context, listen: false);
    FacebookNotifier facebookNotifier = Provider.of<FacebookNotifier>(context, listen: false);
    InstagramNotifier instagramNotifier = Provider.of<InstagramNotifier>(context, listen: false);
    TwitterNotifier twitterNotifier = Provider.of<TwitterNotifier>(context, listen: false);
    PinterestNotifier pinterestNotifier = Provider.of<PinterestNotifier>(context, listen: false);

    getSearches(searchNotifier);
    getProfileViews(profileViewsNotifier);
    getFacebookViews(facebookNotifier);
    getPinterestViews(pinterestNotifier);
    getInstagramViews(instagramNotifier);
    getTwitterViews(twitterNotifier);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> profileViewsStream = FirebaseFirestore.instance
        .collection("businesses")
        .doc(currentUser)
        .collection('profile_views')
        .snapshots();

    final Stream<QuerySnapshot> ratingsStream = FirebaseFirestore.instance
        .collection("businesses")
        .doc(currentUser)
        .collection('reviewDetails')
        .snapshots();

    FacebookNotifier facebookNotifier = Provider.of<FacebookNotifier>(context);
    InstagramNotifier instagramNotifier = Provider.of<InstagramNotifier>(context);
    TwitterNotifier twitterNotifier = Provider.of<TwitterNotifier>(context);
    PinterestNotifier pinterestNotifier = Provider.of<PinterestNotifier>(context);

    int instaClicks = instagramNotifier.instagramList.length;
    final List<ChartModel> data = [
      ChartModel(
          media: 'Twitter',
          clicks: twitterNotifier.twitterList.length.toInt(),
          color: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
      ChartModel(
          media: 'Instagram',
          clicks: instaClicks,
          color: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
      ChartModel(
          media: 'Facebook',
          clicks: facebookNotifier.facebookList.length.toInt(),
          color: charts.ColorUtil.fromDartColor(Colors.redAccent)
      ),
      ChartModel(
          media: 'Pinterest',
          clicks: pinterestNotifier.pinterestList.length.toInt(),
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
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text('Listing Interaction', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: profileViewsStream,
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasError) {
                                //Snackbar for the error
                              }
                              if(snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final List viewDocs = [];
                              snapshot.data!.docs.map((DocumentSnapshot document)  {
                                Map view = document.data() as Map<String, dynamic>;
                                viewDocs.add(view);
                              }).toList();

                              return Container(
                                width: 100,
                                height: 100,
                                child: Card(
                                  color: Colors.grey.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('${snapshot.data!.docs.length}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent,)),
                                        SizedBox(height: 5,),
                                        Text('Listing Vistings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black,), textAlign: TextAlign.center,),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                          SizedBox(width: 15,),

                          StreamBuilder<QuerySnapshot>(
                            stream: ratingsStream,
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.hasError) {
                                //Snackbar for the error
                              }
                              if(snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final List ratingsDocs = [];
                              snapshot.data!.docs.map((DocumentSnapshot document)  {
                                Map ratReview = document.data() as Map<String, dynamic>;
                                ratingsDocs.add(ratReview);
                              }).toList();

                              return Container(
                                width: 100,
                                height: 100,
                                child: Card(
                                  color: Colors.grey.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('${ratingsDocs.length}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent,)),
                                        SizedBox(height: 5,),
                                        Text('Ratings & Reviews', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black,), textAlign: TextAlign.center,),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                          SizedBox(width: 15,),
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
                      height: 400,
                      padding: EdgeInsets.all(10),
                      child: charts.BarChart(
                        series,
                        animate: true,
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
          )
      ),
    );
  }
}
