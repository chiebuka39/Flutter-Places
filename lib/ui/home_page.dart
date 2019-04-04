import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_finder/api/coffee_shops_api.dart';
import 'package:places_finder/api/my_location_api.dart';
import 'package:places_finder/api/places_prediction_api.dart';
import 'package:places_finder/models/coffe_shops_data.dart';
import 'package:places_finder/models/my_location.dart';
import 'package:places_finder/models/place_prediction.dart';
import 'package:places_finder/repository/places_prediction_repository.dart';
import 'package:places_finder/ui/coffee_card.dart';

class MyMapPage extends StatefulWidget {
  MyMapPage({Key key, this.title}) : super(key: key);

 
  final String title;


  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {

  PlacesPredictionRepository repository;
  GoogleMapController googleMapController;
  MyLocationData _myLocationData;
  CoffeeShopsData _shops;
  Marker _selectedMarker;
  String _shopName;
  String _shopImage;

  void _updateSelectedMarker(MarkerOptions changes){
    googleMapController.updateMarker(_selectedMarker, changes);
  }

  void _onMarkerTapped(Marker marker){

    print('Clicked ${_shops.shopList.last.toString()} happened ${marker.options.infoWindowText.title}');

    if(_selectedMarker != null) {
      _updateSelectedMarker(MarkerOptions(
          icon: BitmapDescriptor.defaultMarker
      ));
    }

      setState(() {

        _selectedMarker = marker;

      });

      var selectedShop = _shops.shopList.singleWhere(
          (shop) {
            return shop.name == marker.options.infoWindowText.title;
          },
        orElse: () => null
      );

      _shopName = selectedShop.name;
      _shopImage = selectedShop.photoRef;
      print(_shopName);

      _updateSelectedMarker(
        MarkerOptions(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindowText: InfoWindowText(_shopName, '')
        )
      );

  }

  _addMarkers(CoffeeShopsData places) {
    places.shopList.forEach((shop) {
      googleMapController.addMarker(
        MarkerOptions(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: LatLng(shop.lat, shop.lon),
          infoWindowText: InfoWindowText(shop.name, '')
        )
      );
    });
  }


  Future<CoffeeShopsData> _getCoffeeShops() async {
    final shopsApi = CoffeeShopsApi.getInstance();
    return await shopsApi.getCoffeeShops(this._myLocationData);
  }

  Future<PlacesPrediction> _getPlacesPrediction() async {
    final placesApi = PlacesPredictionApi.getInstance();
    return await placesApi.getPredictedPlaces("25 Ajayi");
  }

  Future<MyLocationData> _getLocation() async {
    final locationApi = MyLocationApi.getInstance();
    return await locationApi.getLocation();
  }

  @override
  void initState() {
    super.initState();

    _getLocation().then((location){
      setState(() {
        _myLocationData = location;
      });


    });

    repository =
        PlacesPredictionRepository(PlacesPredictionApi.getInstance());
  }

  void _onMapCreated(GoogleMapController controller) async{
    _shops = await _getCoffeeShops();
    setState(() {
      googleMapController = controller;
      _addMarkers(_shops);
      googleMapController.onMarkerTapped.add(_onMarkerTapped);

    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: _myLocationData != null ? SizedBox(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                options: GoogleMapOptions(
                  cameraPosition: CameraPosition(
                      target: LatLng(_myLocationData.lat, _myLocationData.lon),
                    zoom: 15.0
                  )
                ),
              ),
            ) : CircularProgressIndicator(
              strokeWidth: 4.0,
              valueColor: AlwaysStoppedAnimation(Colors.amberAccent),
            )
          ),
          Align(
             child: _selectedMarker != null ? CoffeeCard(
               shopImage: _shopImage,
               shopName: _shopName,
               repository: repository,
             ) : Container(),
            alignment: Alignment.bottomCenter,
          )
        ],
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
