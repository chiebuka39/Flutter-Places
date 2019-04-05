import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_finder/bloc/place_details_bloc.dart';
import 'package:places_finder/events/place_details_event.dart';
import 'package:places_finder/models/place_details.dart';
import 'package:places_finder/repository/place_details_repository.dart';
import 'package:places_finder/states/place_details_states.dart';

class PlacesDetailsMap extends StatefulWidget {

  final String placeId;
  final PlaceDetailsRepository detailsRepository;

  PlacesDetailsMap({this.placeId,this.detailsRepository});

  @override
  _PlacesDetailsMapState createState() => _PlacesDetailsMapState();
}

class _PlacesDetailsMapState extends State<PlacesDetailsMap> {

  PlaceDetailsBloc _placeDetailsBloc;


  @override
  void initState() {
    super.initState();
    _placeDetailsBloc = PlaceDetailsBloc(repository: widget.detailsRepository);
    _placeDetailsBloc.dispatch(PlaceIdSent(
      text: widget.placeId
    ));

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Map screen'),
      ),
      body: BlocBuilder<PlaceDetailsEvent, PlaceDetailsState>(
        bloc: _placeDetailsBloc,
        builder: (BuildContext context, PlaceDetailsState state) {
          if (state is PlaceDetailsStateEmpty) {
            return Container(
                height: 500.0,
                alignment: Alignment.center,
                child: Text('Please enter a term to begin'));
          }

          if (state is PlaceDetailsLoading) {
            return Container(
                height: 500.0,
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }

          if (state is PlaceDetailsError) {
            return Text(state.error);
          }

          if (state is PlaceDetailsSuccess) {
            return state.details.formatted_address == null
                ? Text('No results')
                : Stack(
              children: <Widget>[
                GoogleMap(
                  options: GoogleMapOptions(
                      cameraPosition: CameraPosition(
                          target:
                          LatLng(state.details.lat, state.details.lon),
                          zoom: 15.0)),
                  onMapCreated: (GoogleMapController controller) {
                    controller.addMarker(MarkerOptions(
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                        position:
                        LatLng(state.details.lat, state.details.lon),
                        infoWindowText: InfoWindowText(
                            state.details.formatted_address, '')));
                  },
                )
              ],
            );
          }
        },
      ),
    );

  }
}
