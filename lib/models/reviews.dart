class ReviewModel {
  String? reviewId;
  String? username;
  int? rating;
  String? review;
  String? listing;

  ReviewModel({this.reviewId, this.listing, this.rating, this.review, this.username});

  //receive data from server
  factory ReviewModel.fromMap(map){
    return ReviewModel(
      reviewId: map['uid'],
      username: map['username'],
      rating: map['rating'],
      review: map['review'],
      listing: map['listing'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': reviewId,
      'userName': username,
      'rating': rating,
      'review': review,
      'listing': listing,
    };
  }

}