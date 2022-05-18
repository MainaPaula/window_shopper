import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:window_shopper/business/filter_results.dart';
import 'package:window_shopper/models/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  var searchDocID;

  void initState() {
    setState(() {
      super.initState();
      businesses.where('users', isEqualTo: {currentUser})
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          searchDocID = querySnapshot.docs.single.id;
        } else {
          businesses.add({'business owner': {listingId}
          }).then((value) =>
          {
            searchDocID = value,
          });
        }
      }).catchError((e) {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InfoSearch extends SearchDelegate<String> {
  final listings = ['Automotive', 'Business Support', 'Business Supplies', 'Computers', 'Construction', 'Contractors', 'Education', 'Entertainment', 'Food/Dining',
    'Health/Medicine', 'Home/Garden', 'Legal/Financial', 'Manufacturing', 'Wholesale', 'Distribution', 'Merchant(Retail)', 'Miscellaneous', 'Personal Care', 'Real Estate',
    'Travel', 'Transportation'];
  final recentListings = ['Automotive', 'Business Support', 'Business Supplies', 'Computers', 'Construction'];
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get searchDocID => null;

  submitSearch(query) async {
    Searches searchModel = Searches(createdOn: DateTime.now());
    User? user = _auth.currentUser;

    searchModel.createdOn = DateTime.now();
    searchModel.searchID = user!.uid;
    searchModel.searchText = query;

    await firebaseFirestore
        .collection("searches")
        .doc(user.uid)
        .collection("searchDetails")
        .doc(searchDocID)
        .set(searchModel.toMap());
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Actions for the search
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear,color: Colors.redAccent,))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Leading search icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        color: Colors.redAccent,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null.toString());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results of search
    if(listings.contains(query)) {
      submitSearch(query);
      return FilterResults(query);
    }else {
      Fluttertoast.showToast(msg: "No listings found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          fontSize: 16.0);
    }
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when search is invoked
    final suggestList = query.isEmpty ? recentListings : listings.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: RichText(
            text: TextSpan(
              text: suggestList[index].substring(0,query.length),
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ],
          ),
          ),
        ),
        itemCount: suggestList.length
    );
  }

}
