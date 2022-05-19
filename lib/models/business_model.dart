class BusinessModel {
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
  Uri? bizLogo;
  Map? gallery;

  BusinessModel({this.bizId, this.fullName, this.kraPin, this.bizName, this.regNo, this.bizCategory, this.bizType, this.firstBizDay, this.lastBizDay, this.email,
   this.phoneNumber, this.openingHrs, this.closingHrs, this.website, this.physicalAddress, this.county, this.constituency, this.town, this.facebook, this.twitter,
    this.insta, this.pinterest, this.bizDescription,this.bizLogo, this.gallery});

  //receive data from server
  factory BusinessModel.fromMap(map){
    return BusinessModel(
      bizId: map['bizID'],
      fullName: map['fullName'],
      kraPin: map['kraPin'],
      bizName: map['bizName'],
      regNo: map['regNo'],
      bizCategory: map['bizCategory'],
      bizType: map['bizType'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      firstBizDay: map['firstBizDay'],
      openingHrs: map['openingHrs'],
      lastBizDay: map['lastBizDay'],
      closingHrs: map['closingHrs'],
      website: map['website'],
      physicalAddress: map['physicalAddress'],
      county: map['county'],
      constituency: map['constituency'],
      town: map['town'],
      facebook: map['facebook'],
      twitter: map['twitter'],
      insta: map['insta'],
      pinterest: map['pinterest'],
      bizDescription: map['bizDescription'],
      bizLogo: map['bizLogo'],
      gallery: map['gallery']
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'bizId' : bizId,
      'fullName' : fullName,
      'kraPin' : kraPin,
      'bizName' : bizName,
      'regNo' : regNo,
      'bizCategory' : bizCategory,
      'bizType' : bizType,
      'email' : email,
      'phoneNumber' : phoneNumber,
      'firstBizDay': firstBizDay,
      'openingHrs' : openingHrs,
      'lastBizDay' : lastBizDay,
      'closingHrs' : closingHrs,
      'website' : website,
      'physicalAddress' : physicalAddress,
      'county' : county,
      'constituency' : constituency,
      'town' : town,
      'facebook' : facebook,
      'twitter' : twitter,
      'instagram' : insta,
      'pinterest' : pinterest,
      'bizDescription' : bizDescription,
      "bizLogo":bizLogo,
      'gallery' : gallery
    };
  }

}