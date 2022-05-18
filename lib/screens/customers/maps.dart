/*import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/flutter_map.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
        zoom: 13.0,
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
                const FlutterLogo(),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:window_shopper/location/location_controller.dart';
import 'package:window_shopper/location/search_dialogue.dart';

import '';
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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


