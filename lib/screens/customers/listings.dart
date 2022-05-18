import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:window_shopper/business/rating.dart';
import 'package:window_shopper/models/reviews.dart';
import 'package:window_shopper/notifier/biz_notifier.dart';
import 'package:window_shopper/flutter-icons-749bd7bf/custom_icon_icons.dart';
import 'package:window_shopper/business/storage_service.dart';
import '../../models/review_model.dart';
import '../../notifier/review_notifier.dart';


class BizDetail extends StatefulWidget {
  const BizDetail({Key? key}) : super(key: key);

  @override
  State<BizDetail> createState() => _BizDetailState();
}

void getReviews(ReviewNotifier reviewNotifier) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collectionGroup('reviews').get();
  List<Reviews> _reviewList = [];

  snapshot.docs.forEach((element) {
    Reviews reviews = Reviews.fromMap(element.data());
    _reviewList.add(reviews);
  });

  reviewNotifier.reviewList = _reviewList;
}

class _BizDetailState extends State<BizDetail> {
  final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
      .instance.collection('businesses');
  var reviewDocId;
  final currentUser = FirebaseAuth.instance.currentUser?.uid;


  @override
  Widget build(BuildContext context) {
    final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
        .instance.collection('businesses');
    BusinessNotifier businessNotifier = Provider.of<BusinessNotifier>(
        context, listen: false);
    ReviewNotifier reviewNotifier = Provider.of<ReviewNotifier>(context);
    var listingId = businessNotifier.currentBusiness.bizId.toString();
    var businessName = businessNotifier.currentBusiness.bizName.toString();
    final _auth = FirebaseAuth.instance;
    var reviewDocId;
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    final Storage storage = Storage();

    //form key for validation
    final _formKey = GlobalKey<FormState>();
    var ratings;
    var name;

    final TextEditingController review = TextEditingController();

    void initState() {
      setState(() {
        super.initState();
        getReviews(reviewNotifier);
        businesses.where('users', isEqualTo: {currentUser})
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            reviewDocId = querySnapshot.docs.single.id;
          } else {
            businesses.add({'business owner': {listingId}
            }).then((value) =>
            {
              reviewDocId = value,
            });
          }
        }).catchError((e) {});
      });
    }



    /*Future<Widget> _getImage(BuildContext context, String imageName) async {
      late Image image;
      await FirebaseStorageService.loadImage(context, imageName).then((value) {
        image = Image.network(value.toString(), fit: BoxFit.scaleDown);
      });
      return image;
    }*/

    submitReview () async {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      User? user = _auth.currentUser;
      name = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .get()
          .then((value) {
        name = value.data()!['userName'];
      }).toString();

      ReviewModel reviewModel = ReviewModel();

      reviewModel.reviewId = user!.uid;
      reviewModel.rating = ratings;
      reviewModel.username = name;
      reviewModel.review = review.text;
      reviewModel.listing = businessNotifier.currentBusiness.bizName.toString();

      await firebaseFirestore
          .collection('reviews')
          .doc(user.uid)
          .collection("reviewDetails")
          .doc(reviewDocId)
          .set(reviewModel.toMap());

    }

    Future openBrowser(String url) async {
      if(await canLaunchUrlString(url)) {
        await launchUrlString(
          url,
        );
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                    /*FutureBuilder(
                      future: storage.downloadURL('image.jpg'),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                            height: 250,
                            child: Image.network(snapshot.data!, fit: BoxFit.contain,)
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return Container();
                      },
                    ),*/
                    Stack(
                      children: [
                        Image(image: AssetImage('assets/holder.png'),
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                        ),
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          top: 25,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: BorderIcon(
                                    height: 50,
                                    width: 50,
                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                    child: Icon(Icons.keyboard_backspace,color: Colors.black),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: BorderIcon(
                                    height: 50,
                                    width: 50,
                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                    child: Icon(Icons.favorite_border, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          IconButton(onPressed: () async {
                            FirebaseFirestore.instance
                                .collection("businesses")
                                .doc(businessName)
                                .collection("listings")
                                .where("email", isEqualTo: "${businessNotifier.currentBusiness.email}").limit(1)
                                .get()
                                .then((res) {
                              res.docs.forEach((result) {
                                FirebaseFirestore.instance
                                    .collection("businesses")
                                    .doc("businessName")
                                    .collection("listings")
                                    .doc(result.id)
                                    .update({"facebook": '${businessNotifier.currentBusiness.twitter}'});
                              });
                            });
                            final urlFacebook = businessNotifier.currentBusiness.facebook.toString();
                            openBrowser(urlFacebook);
                          }, icon: Icon(Icons.facebook, color: Theme.of(context).primaryColor, size: 25,)),
                          IconButton(onPressed: () {
                            FirebaseFirestore.instance
                                .collection("businesses")
                                .doc(businessName)
                                .collection("listings")
                                .where("email", isEqualTo: "${businessNotifier.currentBusiness.email}").limit(1)
                                .get()
                                .then((res) {
                              res.docs.forEach((result) {
                                FirebaseFirestore.instance
                                    .collection("businesses")
                                    .doc("businessName")
                                    .collection("listings")
                                    .doc(result.id)
                                    .update({"facebook": '${businessNotifier.currentBusiness.twitter}'});
                              });
                            });

                            final urlInsta = businessNotifier.currentBusiness.insta.toString();
                            openBrowser(urlInsta);
                          }, icon: Icon(CustomIcon.instagram, color: Theme.of(context).primaryColor, size: 25,)),
                          IconButton(onPressed: () {
                            FirebaseFirestore.instance
                                .collection("businesses")
                                .doc(businessName)
                                .collection("listings")
                                .where("email", isEqualTo: "${businessNotifier.currentBusiness.email}").limit(1)
                                .get()
                                .then((res) {
                              res.docs.forEach((result) {
                                FirebaseFirestore.instance
                                    .collection("businesses")
                                    .doc("businessName")
                                    .collection("listings")
                                    .doc(result.id)
                                    .update({"twitterClick": (businessNotifier.currentBusiness.twitterClick! + 1)});
                              });
                            });
                            final urlTwitter = businessNotifier.currentBusiness.twitter.toString();
                            openBrowser(urlTwitter);
                          }, icon: Icon(CustomIcon.twitter, color: Theme.of(context).primaryColor,size: 25)),
                          IconButton(onPressed: () {
                            FirebaseFirestore.instance
                                .collection("businesses")
                                .doc(businessName)
                                .collection("listings")
                                .where("email", isEqualTo: "${businessNotifier.currentBusiness.email}").limit(1)
                                .get()
                                .then((res) {
                              res.docs.forEach((result) {
                                FirebaseFirestore.instance
                                    .collection("businesses")
                                    .doc("businessName")
                                    .collection("listings")
                                    .doc(result.id)
                                    .update({"pinterestClick": (businessNotifier.currentBusiness.pinterestClick! + 1)});
                              });
                            });
                            final urlPinterest = businessNotifier.currentBusiness.pinterest.toString();
                            openBrowser(urlPinterest);
                          }, icon: Icon(CustomIcon.pinterest_circled, color: Theme.of(context).primaryColor, size: 25)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Phone: ",
                              style: Theme.of(context).textTheme.headline6),
                          Text("${businessNotifier.currentBusiness.phoneNumber
                              .toString()}", style: TextStyle(fontSize: 16))
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Opening Hours: ",
                              style: Theme.of(context).textTheme.headline6),
                          Text("${businessNotifier.currentBusiness.firstBizDay
                              .toString()} - ${businessNotifier.currentBusiness.lastBizDay
                              .toString()} ${businessNotifier.currentBusiness.openingHrs
                              .toString()}", style: TextStyle(fontSize: 16),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Closing Hours: ",
                              style: Theme.of(context).textTheme.headline6),
                          Text("${businessNotifier.currentBusiness.firstBizDay
                              .toString()} - ${businessNotifier.currentBusiness.lastBizDay
                              .toString()} ${businessNotifier.currentBusiness.closingHrs
                              .toString()}",style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: [
                          Text("Business Overview",
                            style: TextStyle(fontSize: 25,
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
                      child: const Text("Gallery",
                          style: TextStyle(fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Reviews",
                          style: TextStyle(fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),

                    /*ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Text(reviewNotifier.reviewList[index].username.toString()),
                              Text(reviewNotifier.reviewList[index].rating.toString()),
                              Text(reviewNotifier.reviewList[index].review.toString()),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.black,
                          );
                        },
                        itemCount: 2),*/
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Submit a review",
                          style: TextStyle(fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 5),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Text("Rate the listing: ", style: const TextStyle(fontSize: 18, color: Colors.black)),
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
                        textInputAction: TextInputAction.next,
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
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.redAccent,
                        child: MaterialButton(
                          padding: const EdgeInsets.all(8.0),
                          minWidth: 200,
                          onPressed: () {
                            submitReview();
                          },
                          child: const Text(
                              'Submit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                          ),
                        ),
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
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(color: Colors.grey.withAlpha(40), width: 2)),
        padding: EdgeInsets.all(8.0),
        child: Center(child: child));
  }
}


/*class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }


}*/
