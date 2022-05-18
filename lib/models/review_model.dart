class Reviews {
  String? reviewId;
  String? username;
  int? rating;
  String? review;
  String? listing;

  Reviews.fromMap(Map<String, dynamic> data) {
    username = data['username'];
    rating = data['rating'];
    review = data['review'];
    listing = data['listing'];
  }
}