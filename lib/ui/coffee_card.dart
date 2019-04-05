import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_finder/bloc/autocomplete_bloc.dart';
import 'package:places_finder/bloc/place_details_bloc.dart';
import 'package:places_finder/config/config.dart';
import 'package:places_finder/events/autocomplete_event.dart';
import 'package:places_finder/events/place_details_event.dart';
import 'package:places_finder/repository/places_prediction_repository.dart';
import 'package:places_finder/repository/place_details_repository.dart';
import 'package:places_finder/states/auto_complete_states.dart';
import 'package:places_finder/states/place_details_states.dart';
import 'package:places_finder/ui/directions.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places_finder/ui/search_results.dart';

class CoffeeCard extends StatefulWidget {
  CoffeeCard(
      {this.shopName, this.shopImage, @required this.repository, @required this.detailsRepository});

  final String shopImage;
  final String shopName;
  final PlacesPredictionRepository repository;
  final PlaceDetailsRepository detailsRepository;
  static const _endpoint = 'https://maps.googleapis.com/maps/api/place/photo';

  @override
  _CoffeeCardState createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  AutoCompleteBloc _autoCompleteBloc;

  @override
  void initState() {
    _autoCompleteBloc = AutoCompleteBloc(repository: widget.repository);

    super.initState();
  }

  @override
  void dispose() {
    _autoCompleteBloc.dispose();
    super.dispose();
  }

  String _placesPhotoApi() {
    return CoffeeCard._endpoint +
        '?maxheight=' +
        '150' +
        '&photoreference=' +
        widget.shopImage +
        '&key=' +
        apiKey;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.0,
      width: 300.0,
      child: Card(
        elevation: 16.0,
        child: Column(
          children: <Widget>[
            Image.network(
              _placesPhotoApi(),
              height: 150.0,
              width: 300.0,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.shopName,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("harry");
                      showSearch(
                          context: context,
                          delegate: LocationDelegate(
                              autoCompleteBloc: _autoCompleteBloc, repository: widget.detailsRepository));
                    },
                    child: Material(
                      elevation: 12.0,
                      child: Directions(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationDelegate extends SearchDelegate {
  AutoCompleteBloc autoCompleteBloc;
  PlaceDetailsRepository repository;
  GoogleMapController googleMapController;

  LocationDelegate(
      {@required this.autoCompleteBloc, @required this.repository});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {



    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    autoCompleteBloc.dispatch(TextChanged(text: query));
    return Column(
      children: <Widget>[
        BlocBuilder<AutoCompleteEvent, AutoCompleteState>(
          bloc: autoCompleteBloc,
          builder: (BuildContext context, AutoCompleteState state) {
            if (state is AutoCompleteStateEmpty) {
              return Container(
                  height: 500.0,
                  alignment: Alignment.center,
                  child: Text('Please enter a term to begin'));
            }
            if (state is AutoCompleteLoading) {
              return Container(
                  height: 500.0,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }

            if (state is AutoCompleteError) {
              return Text(state.error);
            }

            if (state is AutoCompleteSuccess) {

              return state.prediction.placesList.isEmpty
                  ? Text('No Results')
                  : Expanded(
                      child: SearchResults(items: state.prediction.placesList, repository: repository,));
            }
          },
        )
      ],
    );
  }
}
