import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:window_shopper/business/rating.dart';
import 'package:window_shopper/models/reviews.dart';
import 'package:window_shopper/notifier/biz_notifier.dart';
import '../models/media_clicks.dart';
import '../notifier/review_notifier.dart';
import 'storage_service.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BizDetail extends StatefulWidget {
  const BizDetail({Key? key}) : super(key: key);

  @override
  State<BizDetail> createState() => _BizDetailState();
}



class _BizDetailState extends State<BizDetail> {
  final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
      .instance.collection('businesses');
  var reviewDocId;
  final currentUser = FirebaseAuth.instance.currentUser?.uid;
  var createdOn = DateTime.now();


  @override
  Widget build(BuildContext context) {
    final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
        .instance.collection('businesses');
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(
        context, listen: false);
    ReviewNotifier reviewNotifier = Provider.of<ReviewNotifier>(context);
    String listingName = businessNotifier.currentBusiness.bizName.toString();
    var listingId;
    final _auth = FirebaseAuth.instance;
    var reviewDocId;
    var mediaDocID;
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    User? user = _auth.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final Storage storage = Storage();

    var ratings;

    final TextEditingController review = TextEditingController();

    void initState() {
      setState(() {
      super.initState();
      businesses.where('users', isEqualTo: {currentUser})
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          reviewDocId = querySnapshot.docs.single.id;
          mediaDocID = querySnapshot.docs.single.id;
        } else {
          businesses.add({'business owner': {listingId}
          }).then((value) =>
          {
            mediaDocID = value,
            reviewDocId = value,
          });
        }
      }).catchError((e) {});
    });
  }

    submitFacebookClicks() async {
      FacebookModel facebook = FacebookModel(createdOn: DateTime.now());

      facebook.createdOn = createdOn;
      facebook.clickID = user!.uid;
      listingId = businessNotifier.currentBusiness.bizId.toString();

      await firebaseFirestore
      .collection("businesses")
      .doc(listingId)
      .collection("facebook_clicks")
      .doc(mediaDocID)
      .set(facebook.toMap());

    }

    submitTwitterClicks() async {
      TwitterModel twitter = TwitterModel(createdOn: DateTime.now());

      twitter.createdOn = createdOn;
      twitter.clickID = user!.uid;
      listingId = businessNotifier.currentBusiness.bizId.toString();

      await firebaseFirestore
          .collection("businesses")
          .doc(listingId)
          .collection("twitter_clicks")
          .doc(mediaDocID)
          .set(twitter.toMap());
    }

    submitInstagramClicks() async {
      InstagramModel instagram = InstagramModel(createdOn: DateTime.now());

      instagram.createdOn = createdOn;
      instagram.clickID = user!.uid;
      listingId = businessNotifier.currentBusiness.bizId.toString();

      await firebaseFirestore
          .collection("businesses")
          .doc(listingId)
          .collection("instagram_clicks")
          .doc(mediaDocID)
          .set(instagram.toMap());

    }

    submitPinterestClicks() async {
      PinterestModel pinterest = PinterestModel(createdOn: DateTime.now());

      pinterest.createdOn = createdOn;
      pinterest.clickID = user!.uid;
      listingId = businessNotifier.currentBusiness.bizId.toString();

      await firebaseFirestore
          .collection("businesses")
          .doc(listingId)
          .collection("pinterest_clicks")
          .doc(mediaDocID)
          .set(pinterest.toMap());

    }

    Future openBrowser(String url) async {
      if(await canLaunchUrlString(url)) {
        await launchUrlString(
        url,
        );
    }
    }

    final Stream<QuerySnapshot> reviewStream = FirebaseFirestore.instance
        .collection("businesses").doc(businessNotifier.currentBusiness.bizId.toString()).collection('reviewDetails')
        //.where("listing", isEqualTo: listingName.toString())
        .snapshots();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Listing details",style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.redAccent),
            onPressed: () {
            Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: storage.downloadURL('${businessNotifier.currentBusiness.bizId}.jpg'),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: Image.network(snapshot.data!, fit: BoxFit.contain,)
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return Container();
                      },
                    ),
                    /*Image(image: AssetImage('assets/store.jpg'),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                    ),*/
                    SizedBox(height: 10),

                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final urlFacebook = businessNotifier.currentBusiness.facebook.toString();
                              openBrowser(urlFacebook);
                              submitFacebookClicks();
                            },
                            child: const CircleAvatar(
                              backgroundImage: AssetImage("assets/facebook.jpg"),
                            ),
                          ),
                          SizedBox(width: 20),

                          GestureDetector(
                            onTap: () {
                              final urlInsta = businessNotifier.currentBusiness.insta.toString();
                              openBrowser(urlInsta);
                              submitInstagramClicks();
                            },
                            child: const CircleAvatar(
                              backgroundImage: AssetImage("assets/instagram.jpg"),
                            ),
                          ),
                          SizedBox(width: 20),

                          GestureDetector(
                            onTap: () {
                              final urlTwitter = businessNotifier.currentBusiness.twitter.toString();
                              openBrowser(urlTwitter);
                              submitTwitterClicks();
                            },
                            child: const CircleAvatar(
                              backgroundImage: AssetImage("assets/twitter.png"),
                            ),
                          ),
                          SizedBox(width: 20),

                          GestureDetector(
                            onTap: () {
                              final urlPinterest = businessNotifier.currentBusiness.pinterest.toString();
                              openBrowser(urlPinterest);
                              submitPinterestClicks();
                            },
                            child: const CircleAvatar(
                              backgroundImage: AssetImage("assets/pinterest.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("${businessNotifier.currentBusiness.bizName}",
                            style: TextStyle(fontSize: 20,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Phone: ",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("${businessNotifier.currentBusiness.phoneNumber
                              .toString()}", style: TextStyle(fontSize: 14))
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Opening Hours: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("${businessNotifier.currentBusiness.firstBizDay
                              .toString()} - ${businessNotifier.currentBusiness.lastBizDay
                              .toString()} ${businessNotifier.currentBusiness.openingHrs
                              .toString()}", style: TextStyle(fontSize: 14),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Closing Hours: ",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("${businessNotifier.currentBusiness.firstBizDay
                              .toString()} - ${businessNotifier.currentBusiness.lastBizDay
                              .toString()} ${businessNotifier.currentBusiness.closingHrs
                              .toString()}",style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Location Information",
                            style: TextStyle(fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Physical location: ",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("${businessNotifier.currentBusiness.physicalAddress
                              .toString()}",style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("County: ",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("${businessNotifier.currentBusiness.county
                              .toString()}",style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Town: ",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          Text("${businessNotifier.currentBusiness.town
                              .toString()}",style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                        Text("Business Description",
                              style: TextStyle(fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child:
                          Text(businessNotifier.currentBusiness.bizDescription.toString(),
                              textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Reviews",
                          style: TextStyle(fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: reviewStream,
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.hasError) {
                              //Snackbar for the error
                            }
                            if(!snapshot.hasData){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("No reviews yet")
                                  ],
                                ),
                              );
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

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                              List.generate(
                                  viewDocs.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                          children:[
                                            Text(viewDocs[index]["userName"].toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                            SizedBox(height: 5,),
                                            SmoothStarRating(
                                              starCount: 5,
                                              rating: viewDocs[index]["rating"].toDouble(),
                                              size: 28.0,
                                              color: Colors.redAccent,
                                              borderColor: Colors.redAccent,
                                            ),
                                            SizedBox(height: 5,),
                                            Text(viewDocs[index]["review"].toString(), textAlign: TextAlign.justify, style: Theme.of(context).textTheme.bodyText2),
                                            SizedBox(height: 18,),
                                          ]
                              ),
                               )
                              ),
                          );
                        }
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Submit a review",
                          style: TextStyle(fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Rate the listing: ", style: const TextStyle(fontSize: 14, color: Colors.black)),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Rating((rating) {
                          ratings = rating;
                      }),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        autofocus: false,
                        controller: review,
                        onSaved: (value) {
                          review.text = value!;
                        },
                        maxLines: 5,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: 'Enter your review',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.redAccent,
                          child: MaterialButton(
                            padding: const EdgeInsets.all(8.0),
                            minWidth: 200,
                            onPressed: () async {
                              DocumentSnapshot name = await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(currentUser)
                                  .get();
                              final username = name['userName'];


                              ReviewModel reviewModel = ReviewModel();

                              reviewModel.reviewId = user!.uid;
                              reviewModel.rating = ratings;
                              reviewModel.userName = username;
                              reviewModel.review = review.text;
                              reviewModel.listing = businessNotifier.currentBusiness.bizName.toString();

                              await firebaseFirestore
                                  .collection('businesses')
                                  .doc(businessNotifier.currentBusiness.bizId)
                                  .collection("reviewDetails")
                                  .doc(reviewDocId)
                                  .set(reviewModel.toMap());
                            },
                            child: const Text(
                                'Submit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
          ),
        ),
    );
  }
}
class BorderIcon extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const BorderIcon(
      {required this.child,
        required this.padding,
        required this.width,
        required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(color: Colors.grey.withAlpha(40), width: 2)),
        padding: EdgeInsets.all(8.0),
        child: Center(child: child));
  }
}

