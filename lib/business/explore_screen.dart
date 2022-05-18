/*import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:window_shopper/business/biz_registration.dart';
import 'package:window_shopper/main.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    setState(() {
      getCurLocation();
      super.initState();
    });
  }

  final geolocator = Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late Position _currentLocation;
  String currentAddress = "";
  var bizLatitude;
  var bizLongitude;

  Future getCurLocation() async {
    /*
    Location _location = Location();
    bool _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    //Capturing the current user location
    LocationData _locData = await _location.getLocation();
    LatLng currentLocation = LatLng(_locData.latitude!, _locData.longitude!);

    //Keep the user location in sharedPreferences
    sharedPreferences.setDouble('Latitude', _locData.latitude!);
    sharedPreferences.setDouble('Longitude', _locData.longitude!);

  }*/

   LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position){
      setState((){
        _currentLocation = position;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void getAddressFromCoordinates() async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(_currentLocation.latitude, _currentLocation.longitude);
      Placemark p = placemark[0];
      setState(() {
        currentAddress = "${p.thoroughfare}, ${p.subThoroughfare}, ${p.name}, ${p.subLocality}";
      });
    }catch(error) {
      print(error);
    }
  }

  void _listPosMap(dynamic position, latLng.LatLng direct) {
    print(direct.longitude);
    setState(() {
      bizLatitude = direct.latitude;
      bizLongitude = direct.longitude;
      addMarker();
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  BizRegistration()));
  }

  void addMarker() {
    Marker(
      width: 30.0,
      height: 30.0,
      point: latLng.LatLng(bizLatitude, bizLongitude),
      builder: (ctx) =>
          Container(
            child: IconButton(
              icon: Icon(Icons.location_on),
              color: Colors.redAccent,
              iconSize: 45.0,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: Text("Bottom Sheet"),
                        ),
                      );
                    }
                );
                //getCurLocation();
              },
            ),
          ),
      //const FlutterLogo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(-1.27372863, 36.81625396),
          minZoom : 13.0,
          onTap: _listPosMap,
        ),

        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/paula-m/cl1m1whgg003115p2s3n4l0ea/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGF1bGEtbSIsImEiOiJjbDFtMWJyemgwZzY5M2R0OWpnZW00NDVkIn0.hkPuXewaE68rQjEIfOXgrA",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoicGF1bGEtbSIsImEiOiJjbDFtMWJyemgwZzY5M2R0OWpnZW00NDVkIn0.hkPuXewaE68rQjEIfOXgrA',
              'id': 'mapbox.mapbox-streets-v8',
            },
            attributionBuilder: (_) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: latLng.LatLng(-1.27372863, 36.81625396),
                builder: (ctx) =>
                Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.redAccent,
                    iconSize: 45.0,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Container(
                              color: Colors.white,
                              child: Center(
                                child: Text("Bottom Sheet"),
                              ),
                            );
                          }
                        );
                      //getCurLocation();
                    },
                  ),
                ),
                //const FlutterLogo(),
              ),
            ],
          ),
        ],
      ),

    );
  }
}*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:window_shopper/location/location_controller.dart';
import 'package:window_shopper/location/search_dialogue.dart';

import '';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    _cameraPosition = const CameraPosition(target: LatLng(-1.27372863, 36.81625396),
        zoom: 17.0);
  }
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Explore',style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.redAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition: _cameraPosition,
                onMapCreated: (GoogleMapController mapController) {
                  _mapController = mapController;
                },
              ),
              Positioned(
                  top: 100,
                  left: 10,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Get.dialog(LocationSearchDialogue(mapController: _mapController)),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, size: 25, color: Theme.of(context).primaryColor),
                          SizedBox(width: 5),

                          Expanded(
                              child: Text(
                                '${locationController.selectPlacemark.name ?? ''} '
                                    '${locationController.selectPlacemark.locality ?? ''}'
                                    '${locationController.selectPlacemark.postalCode ?? ''}'
                                    '${locationController.selectPlacemark.country ?? ''}',
                                style: TextStyle(fontSize: 20),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.search, size: 25, color: Colors.redAccent)
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        );
      }
    );
  }
}










