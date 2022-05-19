import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_shopper/business/search.dart';

import '../../business/listing_details.dart';
import '../../models/listing.dart';
import '../../models/media_clicks.dart';
import '../../notifier/biz_notifier.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

void getBusinesses(BusinessNotifier businessNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collectionGroup('listings').get();
  List<Businesses> _businessList = [];

  snapshot.docs.forEach((element) {
    Businesses business = Businesses.fromMap(element.data());
    _businessList.add(business);
  });

  businessNotifier.businessList = _businessList;
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController search = TextEditingController();
  List searchResults = [];
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var listingId;
  var createdOn = DateTime.now();
  final currentUser = FirebaseAuth.instance.currentUser?.uid;
  var mediaDocID;
  final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
      .instance.collection('businesses');


  @override
  void initState() {
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(context, listen: false);
    getBusinesses(businessNotifier);
    super.initState();
    //search.addListener(onSearchChanged);
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
  void dispose() {
    //search.removeListener(onSearchChanged);
    search.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(context);

    onSearchChanged(){
      var showResults= [];

      if(search.text != "") {
        for(var business in businessNotifier.businessList) {

        }
      }else {
        List.from(searchResults);
      }
      setState(() {
        searchResults = businessNotifier.businessList;
      });
    }

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
        title: const Text('Search',style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  controller: search,
                  onChanged: (value) {
                    showSearch(context: context, delegate: InfoSearch());
                  },
                  borderRadius: BorderRadius.circular(20),
                ),
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
                                    Positioned(
                                      top: 15,
                                      right: 15,
                                      child: BorderBox(
                                          padding: EdgeInsets.symmetric(horizontal: 20),
                                          height: 50,
                                          width: 50,
                                          child: Icon(Icons.favorite_border, color: Colors.redAccent)
                                      ),
                                    )
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
              ],
            ),
          )
          /*TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                icon: const Icon(Icons.search_outlined),
                hintText: 'Search'
            ),
          ),*/
        ),
      ),
    );
  }
}

class BorderBox extends StatelessWidget {
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
}
