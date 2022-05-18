import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/listing.dart';
import '../models/media_clicks.dart';
import '../notifier/biz_notifier.dart';
import 'biz_registration.dart';
import 'listing_details.dart';

class FilterResults extends StatefulWidget {
  final String query;

  const FilterResults(this.query, {Key? key}) : super(key: key);

  @override
  _FilterResultsState createState() => _FilterResultsState();
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


class _FilterResultsState extends State<FilterResults> {
  void getBusinesses(BusinessNotifier businessNotifier) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collectionGroup('listings').where("bizCategory", isEqualTo: '${widget.query}').get();
    List<Businesses> _businessList = [];

    snapshot.docs.forEach((element) {
      Businesses business = Businesses.fromMap(element.data());
      _businessList.add(business);
    });

    businessNotifier.businessList = _businessList;
  }

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
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                    child: Image(image: AssetImage('assets/store.jpg'),
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
                                          child: Icon(Icons.favorite_border, color: Colors.redAccent,)
                                      )
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
