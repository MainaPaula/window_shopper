import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:window_shopper/location/location_controller.dart';

class LocationSearchDialogue extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialogue({required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: 150),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: SizedBox(width: 450, child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _controller,
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
            Get.back();
          },
        )),
      ),
    );
  }
}
