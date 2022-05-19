import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_shopper/business/filter_results.dart';
import 'package:window_shopper/business/listing_details.dart';
import 'package:window_shopper/models/media_clicks.dart';
import '../../business/search.dart';
import '../../models/listing.dart';
import '../../notifier/biz_notifier.dart';
import '../chatbot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _auth = FirebaseAuth.instance;
User? user = _auth.currentUser;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
var listingId;
var createdOn = DateTime.now();
final currentUser = FirebaseAuth.instance.currentUser?.uid;
final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
    .instance.collection('businesses');
var mediaDocID;

void getBusinesses(BusinessNotifier businessNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collectionGroup('listings').get();
  List<Businesses> _businessList = [];

  snapshot.docs.forEach((element) {
    Businesses business = Businesses.fromMap(element.data());
    _businessList.add(business);
  });

  businessNotifier.businessList = _businessList;
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(context, listen: false);
    getBusinesses(businessNotifier);
    super.initState();
    businesses.where('users', isEqualTo: {currentUser})
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        mediaDocID = querySnapshot.docs.single.id;
      } else {
        businesses.add({'business owner': {listingId}
        }).then((value) =>
        {
          mediaDocID = value,
        });
      }
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(context);

    submitProfileViews() async {
      ProfileViewsModel profileViews = ProfileViewsModel(createdOn: DateTime.now());

      profileViews.createdOn = createdOn;
      profileViews.clickID = user!.uid;
      listingId = businessNotifier.currentBusiness.bizId.toString();

      await firebaseFirestore
          .collection("businesses")
          .doc(listingId)
          .collection("profile_views")
          .doc(mediaDocID)
          .set(profileViews.toMap());
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Home',style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: (){
                showSearch(context: context, delegate: InfoSearch());
              },
              icon: Icon(Icons.search),
              color: Colors.redAccent,
            ),
          ],
          ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                "Listings",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
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

              /*GestureDetector(
                onTap: () {
                  var category;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilterResults(category)));
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      'Automotive',
                      'Business Support',
                      'Business Supplies',
                      'Computers',
                      'Construction',
                      'Contractors',
                      'Education',
                      'Entertainment',
                      'Food/Dining',
                      'Health/Medicine',
                      'Home/Garden',
                      'Legal/Financial',
                      'Manufacturing',
                      'Wholesale',
                      'Distribution',
                      'Merchant(Retail)',
                      'Miscellaneous',
                      'Personal Care',
                      'Real Estate',
                      'Travel',
                      'Transportation'
                    ].map((filter) => FilterOption(categories: filter)).toList(),
                  ),
                ),
              ),
              SizedBox(height: 10),*/

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListView.builder(
                    physics:BouncingScrollPhysics() ,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:() {
                                  submitProfileViews();
                                  businessNotifier.currentBusiness = businessNotifier.businessList[index];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BizDetail()));
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image(image: const AssetImage('assets/store.jpg'),
                                        width: MediaQuery.of(context).size.width,
                                        height: 150,
                                      ),
                                    ),
                                    /*Positioned(
                                        top: 15,
                                        right: 15,
                                          child: BorderBox(
                                              padding: EdgeInsets.symmetric(horizontal: 20),
                                              height: 50,
                                              width: 50,
                                              child: Icon(Icons.favorite_border, color: Colors.redAccent)
                                          ),
                                        )*/
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text (businessNotifier.businessList[index].bizName.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        );
                      },
                      itemCount: businessNotifier.businessList.length,
                    /*onTap: (){
                            businessNotifier.currentBusiness = businessNotifier.businessList[index];
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListingDetail()));
                          },*/
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Chatbot()));
                      },
                      child: Icon(Icons.chat_bubble, color: Colors.white,),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
/*class BorderBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const BorderBox({Key? key, required this.padding, required this.width, required this.height, required this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white70,
          width: 2,
        )
      ),
      padding: EdgeInsets.all(8.0),
      child: Center(child: child),
    );
  }
}*/

class FilterOption extends StatelessWidget {
  final String categories;

  const FilterOption({Key? key, required this.categories}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.redAccent.shade200,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      margin: EdgeInsets.only(left: 25),
      child: Text(categories, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),),
    );
  }
}

class Listing extends StatelessWidget {
  final dynamic listing;
  final title;
  final subtitle;

  const Listing({Key? key, this.listing, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                  child: Image.asset("assets/images.png")
              ),
              Positioned(
                top: 15,
                right: 15,
                child: BorderBox(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  width: 50,
                  child: Icon(Icons.favorite_border, color: Colors.black,)
                )
              )
            ],
          ),*/
          SizedBox(height: 15),
          Row(
            children: [
              Text (title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text (subtitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

            ],
          )
        ],
      ),
    );
  }
}

