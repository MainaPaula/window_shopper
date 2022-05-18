class Businesses {
  String? bizId;
  String? fullName;
  String? kraPin;
  String? bizName;
  String? regNo;
  String? bizCategory;
  String? bizType;
  String? email;
  String? phoneNumber;
  String? openingHrs;
  String? firstBizDay;
  String? lastBizDay;
  String? closingHrs;
  String? website;
  String? physicalAddress;
  String? county;
  String? constituency;
  String? town;
  String? facebook;
  String? twitter;
  String? insta;
  String? pinterest;
  String? bizDescription;
  int? facebookClick;
  int? twitterClick;
  int? instaClick;
  int? pinterestClick;

  //receive data from server
  Businesses.fromMap(Map<String, dynamic> data){
        bizId = data['bizId'];
        fullName = data['fullName'];
        kraPin = data['kraPin'];
        bizName = data['bizName'];
        regNo = data['regNo'];
        bizCategory = data['bizCategory'];
        bizType = data['bizType'];
        email = data['email'];
        phoneNumber = data['phoneNumber'];
        firstBizDay = data['firstBizDay'];
        openingHrs = data['openingHrs'];
        lastBizDay = data['lastBizDay'];
        closingHrs = data['closingHrs'];
        website = data['website'];
        physicalAddress = data['physicalAddress'];
        county = data['county'];
        constituency = data['constituency'];
        town = data['town'];
        facebook = data['facebook'];
        twitter = data['twitter'];
        insta = data['insta'];
        pinterest = data['pinterest'];
        bizDescription = data['bizDescription'];
        twitterClick = data['twitterClick'];
        facebookClick = data['facebookClick'];
        instaClick = data['instaClick'];
        pinterestClick = data['pinterestClick'];
  }

}