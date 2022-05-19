class ReviewModel {
  String? reviewId;
  String? userName;
  int? rating;
  String? review;
  String? listing;

  ReviewModel({this.reviewId, this.listing, this.rating, this.review, this.userName});

  //receive data from server
  factory ReviewModel.fromMap(map){
    return ReviewModel(
      reviewId: map['uid'],
      userName: map['userName'],
      rating: map['rating'],
      review: map['review'],
      listing: map['listing'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': reviewId,
      'userName': userName,
      'rating': rating,
      'review': review,
      'listing': listing,
    };
  }

}