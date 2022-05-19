class Reviews {
  String? reviewId;
  String? userName;
  int? rating;
  String? review;
  String? listing;

  Reviews.fromMap(Map<String, dynamic> data) {
    userName = data['userName'];
    rating = data['rating'];
    review = data['review'];
    listing = data['listing'];
  }
}