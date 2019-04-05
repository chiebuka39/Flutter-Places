import 'package:google_maps_webservice/places.dart';

class PlaceDetailsData{
  final String formatted_address;
  final double lat;
  final double lon;
  final String icon;
  final String url;
  final String id;
  final String placeId;

  PlaceDetailsData({this.formatted_address, this.lat, this.lon, this.icon, this.url, this.id, this.placeId});

  static convertToPlaceDetails(PlacesDetailsResponse response){
    return PlaceDetailsData(
      formatted_address: response.result.adrAddress,
      lat: response.result.geometry.location.lat,
      lon: response.result.geometry.location.lng,
      icon: response.result.icon,
      url: response.result.url,
      id: response.result.id,
      placeId: response.result.placeId
    );
  }

}