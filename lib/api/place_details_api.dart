import 'package:google_maps_webservice/places.dart';
import 'package:places_finder/config/config.dart';
import 'package:places_finder/models/place_details.dart';

class PlaceDetailsApi{
  static PlaceDetailsApi _instance ;
  static PlaceDetailsApi getInstance() => _instance ??= PlaceDetailsApi();

  Future<PlaceDetailsData> getPlaceDetails(String placeId) async{
    final googlePlaces = GoogleMapsPlaces(apiKey: apiKey);

    final response = await googlePlaces.getDetailsByPlaceId(placeId);
    return PlaceDetailsData.convertToPlaceDetails(response);
  }
}