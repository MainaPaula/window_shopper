import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:window_shopper/models/business_model.dart';
import 'main_business.dart';
import 'storage_service.dart';

class BizRegistration extends StatefulWidget {
  const BizRegistration({Key? key}) : super(key: key);

  @override
  State<BizRegistration> createState() => _BizRegistrationState();
}

class _BizRegistrationState extends State<BizRegistration> {
  final CollectionReference<Map<String, dynamic>> businesses = FirebaseFirestore
      .instance.collection('businesses');
  final geolocator = Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late Position _currentLocation;
  String currentAddress = "";
  var businessDocumentId;
  final _auth = FirebaseAuth.instance;
  //form key for validation
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();


  double val = 0;

  late File _file;
  ImagePicker image = ImagePicker();
  String url = "";
  var bizLogo;
  Map<String, dynamic> gallery = {};

  final currentUser = FirebaseAuth.instance.currentUser?.uid;
  final Storage storage = Storage();

  void initState() {
    setState(() {
      super.initState();
      businesses.where('users', isEqualTo: {currentUser})
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          businessDocumentId = querySnapshot.docs.single.id;
        } else {
          businesses.add({'business owner': {currentUser: ''}
          }).then((value) =>
          {
            businessDocumentId = value,
          });
        }
      }).catchError((e) {});
    });
  }

  int currentStep = 0;
  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final List<String> hours = ['12:00 AM', '1:00 AM', '2:00 AM', '3:00 AM', '4:00 AM', '5:00 AM', '6:00 AM', '7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '1:00 PM', '2:00 PM',
    '3:00 PM', '4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM', '10:00 PM', '11:00 PM'];

  final List<String> categories = [
    'Automotive',
    'Business Support',
    'Business Supplies',
    'Computers',
    'Construction',
    'Contractors',
    'Education',
    'Entertainment',
    'Food/Dining',
    'Health/Medicine',
    'Home/Garden',
    'Legal/Financial',
    'Manufacturing',
    'Wholesale',
    'Distribution',
    'Merchant(Retail)',
    'Miscellaneous',
    'Personal Care',
    'Real Estate',
    'Travel',
    'Transportation'
  ];

  final List<String> counties = [
    'Momabasa',
    'Kwale',
    'Kilifi',
    'Tana River',
    'Lamu',
    'Taita Taveta',
    'Garissa',
    'Wajir',
    'Mandera',
    'Marsabit',
    'Isiolo',
    'Meru',
    'Tharaka Nithi',
    'Embu',
    'Kitui',
    'Machakos',
    'Makueni',
    'Nyandarua',
    'Nyeri',
    'Kirinyaga',
    'Murang\'a',
    'Kiambu',
    'Turkana',
    'West Pokot',
    'Samburu',
    'Trans Nzoia',
    'Uasin Gishu',
    'Elgeyo Marakwet',
    'Nandi',
    'Baringo',
    'Laikipia',
    'Nakuru',
    'Narok',
    'Kajiado',
    'Kericho',
    'Bomet',
    'Kakamega',
    'Vihiga',
    'Bungoma',
    'Busia',
    'Siaya',
    'Kisumu',
    'Homa Bay',
    'Migori',
    'Kisii',
    'Nyamira',
    'Nairobi City'
  ];

  //Editing controller
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController bizNameController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();
  final TextEditingController bizCategoryController = TextEditingController();
  final TextEditingController bizTypeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController firstBizDay = TextEditingController();
  final TextEditingController lastBizDay = TextEditingController();
  final TextEditingController openingHoursController = TextEditingController();
  final TextEditingController closingHoursController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController physicalAddressController = TextEditingController();
  final TextEditingController countyController = TextEditingController();
  final TextEditingController constituencyController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instaController = TextEditingController();
  final TextEditingController pinterestController = TextEditingController();
  final TextEditingController bizDescription = TextEditingController();
  late GoogleMapController _mapController;
  var physicalAddress;



  List<Step> getSteps() =>
      [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: true,
          title: const Text('Background Information'),
          content: Column(
            children: <Widget>[
              TextFormField(
                autofocus: false,
                controller: fullNameController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.]$');

                  if (value!.isEmpty) {
                    return ('Please enter your full name');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid name');
                  }
                },
                onSaved: (value) {
                  fullNameController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),

              TextFormField(
                autofocus: false,
                controller: pinController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z0-9]$');

                  if (value!.isEmpty) {
                    return ('Please enter your KRA pin');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid pin');
                  }
                },
                onSaved: (value) {
                  pinController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'KRA Pin Number',
                ),
              ),

              //business name field
              TextFormField(
                autofocus: false,
                controller: bizNameController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return ('Please enter your business name');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid name');
                  }
                },
                onSaved: (value) {
                  bizNameController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Business Name'
                ),
              ),

              //registration number
              TextFormField(
                autofocus: false,
                controller: regNoController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z0-9]$');

                  if (value!.isEmpty) {
                    return ('Please enter your business registration number');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid number');
                  }
                },
                onSaved: (value) {
                  regNoController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Business Registration Number',
                ),
              ),

              DropdownButtonFormField<String>(
                autofocus: false,
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => bizCategoryController.text = value!),

                //textInputAction: InputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Business Category',
                ),
              ),

              //business type field
              TextFormField(
                autofocus: false,
                controller: bizTypeController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return ('Please enter your business type');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid type');
                  }
                },
                onSaved: (value) {
                  bizTypeController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Business Type',
                ),
              ),
            ],
          ),
        ),

        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: true,
          title: const Text('Contact Information'),
          content: Column(
            children: <Widget>[
              TextFormField(
                autofocus: false,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return (value = null);
                  }
                  //regex expression for email validation
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ('Please enter a valid email');
                  }
                },
                onSaved: (value) {
                  emailController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                autofocus: false,
                controller: _phoneNoController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter your business phone number');
                  }
                  //regex expression for phone number validation
                  if (!RegExp('^([0|+[0-9]{1,5})?([0-9]{10})').hasMatch(
                      value)) {
                    return ('Please enter a valid phone number');
                  }
                },
                onSaved: (value) {
                  _phoneNoController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),

              //first business day of the week
              DropdownButtonFormField<String>(
                autofocus: false,
                items: days.map((day) {
                  return DropdownMenuItem(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                onChanged: (value) => setState(() => firstBizDay.text = value!),

                //textInputAction: InputAction.next,
                decoration: const InputDecoration(
                  labelText: 'First Business Day of the Week',
                ),
              ),

              //opening hours field
              DropdownButtonFormField<String>(
                autofocus: false,
                items: hours.map((hour) {
                  return DropdownMenuItem(
                    value: hour,
                    child: Text(hour),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => openingHoursController.text = value!),

                //textInputAction: InputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Opening Hours',
                ),
              ),

              DropdownButtonFormField<String>(
                autofocus: false,
                items: days.map((day) {
                  return DropdownMenuItem(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                onChanged: (value) => setState(() => lastBizDay.text = value!),

                //textInputAction: InputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Last Business Day of the Week',
                ),
              ),

              //closing hours field
              DropdownButtonFormField<String>(
                autofocus: false,
                items: hours.map((hour) {
                  return DropdownMenuItem(
                    value: hour,
                    child: Text(hour),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => closingHoursController.text = value!),

                //textInputAction: InputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Closing Hours',
                ),
              ),

              //website link field
              TextFormField(
                autofocus: false,
                controller: websiteController,
                obscureText: true,
                validator: (value) {
                  RegExp regex = RegExp(r'^.{8,}$');

                  if (value!.isEmpty) {
                    return (value = null);
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid link');
                  }
                },
                onSaved: (value) {
                  websiteController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Website Link',
                ),
              ),
            ],
          ),
        ),

        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: true,
          title: const Text('Location Information'),
          content: Column(
            children: <Widget>[
              //physical address field
              TextFormField(
                autofocus: false,
                //controller: physicalAddressController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z0-9]$');

                  if (value!.isEmpty) {
                    return ('Please enter your physical address');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid address');
                  }
                },
                //onTap: () {
                 // getCurLocation();
                //},
                onSaved: (value) {
                  currentAddress = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Physical Address'
                ),
              ),

              /*SearchLocation(
                apiKey: "AIzaSyCRPRmTUZozzjtRuAdHchm8V_bozzDyGsc",
                country: 'KE',
                placeholder: "Physical address",
                strictBounds: false,
                placeType: PlaceType.region,
                //placeType: PlaceType.address,
                onSelected: (Place place) async {
                  physicalAddress = place.description;
                  print(place.description);
                  final geolocation = await place.geolocation;
                  final latlng = LatLng(geolocation?.coordinates.latitude, geolocation?.coordinates.longitude);
                },
              ),*/

            /*TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller:physicalAddressController,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                    fontSize: 16, color: Theme.of(context).disabledColor,
                  ),
                  filled: true, fillColor: Theme.of(context).cardColor,
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await Get.find<LocationController>().searchMapLocation(context, pattern);
              },
              itemBuilder: (context, Prediction suggestion) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                      children: [
                        Icon(Icons.location_on),
                        Expanded(
                            child: Text(suggestion.description!,
                              maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20),
                            )
                        )
                      ]
                  ),
                );
              },
              onSuggestionSelected: (Prediction suggestion) {
                physicalAddressController.text = suggestion.toString();
              },
            ),*/

              //county field
              DropdownButtonFormField<String>(
                autofocus: false,
                items: counties.map((county) {
                  return DropdownMenuItem(
                    value: county,
                    child: Text(county),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => countyController.text = value!),

                //textInputAction: InputAction.next,
                decoration: const InputDecoration(
                  labelText: 'County',
                ),
              ),

              //constituency field
              TextFormField(
                autofocus: false,
                controller: constituencyController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return ('Please enter your constituency');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid constituency');
                  }
                },
                onSaved: (value) {
                  constituencyController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Constituency',
                ),
              ),

              // town field
              TextFormField(
                autofocus: false,
                controller: townController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return ('Please enter your town');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid town');
                  }
                },
                onSaved: (value) {
                  townController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Town',
                ),
              ),
            ],
          ),
        ),

        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: true,
          title: const Text('Social Media Information'),
          content: Column(
            children: <Widget>[
              //facebook link field
              TextFormField(
                autofocus: false,
                controller: facebookController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return (value = null);
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid link');
                  }
                  return null;
                },
                onSaved: (value) {
                  facebookController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Facebook Link',
                ),
              ),

              //twitter field
              TextFormField(
                autofocus: false,
                controller: twitterController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return (value = null);
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid link');
                  }
                  return null;
                },
                onSaved: (value) {
                  twitterController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Twitter Link',
                ),
              ),

              //instagram field
              TextFormField(
                autofocus: false,
                controller: instaController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return (value = null);
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid link');
                  }
                  return null;
                },
                onSaved: (value) {
                  instaController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Instagram link',
                ),

              ),

              //pinterest field
              TextFormField(
                autofocus: false,
                controller: pinterestController,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z.@_-]$');

                  if (value!.isEmpty) {
                    return (value = null);
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid link');
                  }
                  return null;
                },
                onSaved: (value) {
                  pinterestController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Pinterest link',
                ),
              ),
            ],
          ),
        ),

        Step(
          state: currentStep > 4 ? StepState.complete : StepState.indexed,
          isActive: true,
          title: const Text('Business overview'),
          content: Column(
            children: <Widget>[
              TextFormField(
                autofocus: false,
                minLines: 2,
                maxLines: 50,
                keyboardType: TextInputType.multiline,
                controller: bizDescription,
                validator: (value) {
                  RegExp regex = RegExp(r'^[a-zA-Z0-9.@_-]$');

                  if (value!.isEmpty) {
                    return ('Please give a description of your business');
                  }
                  if (!regex.hasMatch(value)) {
                    return ('Enter a valid description');
                  }
                },
                onSaved: (value) {
                  bizDescription.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Give a description of your business',
                ),
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Business Logo/Headline", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                ],
              ),
              const SizedBox(height: 10),

              const Text(
                  "Click the button bellow to upload your business logo or headline photo"),
              const SizedBox(height: 10),

              ElevatedButton(
                child: const Text("Select image"),
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'jpeg'],
                  );
                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No file selected.")));
                  }
                  final path = results?.files.single.path;
                  final fileName = currentUser.toString();

                  storage.uploadFile(path!, fileName).
                  then((value) => print('Image Uploaded'));
                  //pickLogo();
                },
              )

            ],
          ),
        ),

        Step(
          isActive: true,
          title: const Text('Complete'),
          content: Column(
            children: const <Widget>[
              Text(
                  'Please ensure that the details provided are complete and valid. Click the submit below to register your listing.')
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Business Registration', style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),

        body: Stepper(
            type: StepperType.vertical,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                //send data to firebase
                postDetailsToFirestore();
              }
              setState(() => currentStep += 1);
            },
            onStepTapped: (step) => setState(() => currentStep = step),
            onStepCancel:
            currentStep == 0 ? null : () =>
            {
              setState(() => currentStep -= 1),
            },
            controlsBuilder: (context, controls) {
              final isLastStep = currentStep == getSteps().length - 1;
              return Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: (isLastStep) ? const Text('SUBMIT') : const Text(
                            'NEXT'),
                        onPressed: controls.onStepContinue,

                      ),
                    ),
                    const SizedBox(width: 12),

                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          child: const Text('BACK'),
                          onPressed: controls.onStepCancel,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
    );
  }

  //posting data to firebase function
  postDetailsToFirestore() async {
    //calling Firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //calling BusinessModel
    User? business = _auth.currentUser;
    BusinessModel businessModel = BusinessModel(town: '',
      physicalAddress: '',
      constituency: '',
      phoneNumber: '',
      openingHrs: '',
      bizCategory: '',
      lastBizDay: '',
      county: '',
      regNo: '',
      fullName: '',
      email: '',
      bizName: '',
      bizId: '',
      bizType: '',
      kraPin: '',
      bizDescription: '',
      firstBizDay: '',
      closingHrs: '',);

    //writing the values
    businessModel.bizId = business!.uid;
    businessModel.fullName = fullNameController.text;
    businessModel.kraPin = pinController.text;
    businessModel.bizName = bizNameController.text;
    businessModel.regNo = regNoController.text;
    businessModel.bizCategory = bizCategoryController.text;
    businessModel.bizType = bizTypeController.text;
    businessModel.email = emailController.text;
    businessModel.phoneNumber = _phoneNoController.text;
    businessModel.openingHrs = openingHoursController.text;
    businessModel.closingHrs = closingHoursController.text;
    businessModel.website = websiteController.text;
    businessModel.physicalAddress = currentAddress;
    businessModel.county = countyController.text;
    businessModel.constituency = constituencyController.text;
    businessModel.town = townController.text;
    businessModel.facebook = facebookController.text;
    businessModel.twitter = twitterController.text;
    businessModel.insta = instaController.text;
    businessModel.pinterest = pinterestController.text;
    businessModel.firstBizDay = firstBizDay.text;
    businessModel.lastBizDay = lastBizDay.text;
    businessModel.bizDescription = bizDescription.text;
    businessModel.gallery = gallery;


    //sending the values
    await firebaseFirestore
        .collection("businesses")
        .doc(business.uid)
        .collection("listings")
        .doc(businessDocumentId)
        .set(businessModel.toMap());
    Fluttertoast.showToast(msg: 'Listing created successfully');

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BusinessMainScreen()));
  }

  uploadFile() async {
    try {
      var imagefile =
      FirebaseStorage.instance.ref().child("Businesses/${Path.basename(_file.path)}'");
      UploadTask task = imagefile.putFile(_file);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      print(url);
      if (url != null && _file != null) {
        Fluttertoast.showToast(
          msg: "Uploaded",
          textColor: Colors.red,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          textColor: Colors.red,
        );
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        textColor: Colors.red,
      );
    }
  }

}

