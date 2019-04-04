import 'package:google_maps_webservice/places.dart';
import 'package:places_finder/config/config.dart';
import 'package:places_finder/models/place_prediction.dart';

class PlacesPredictionApi{
  static PlacesPredictionApi _instance;
  static PlacesPredictionApi getInstance() => _instance ??= PlacesPredictionApi();

  Future<PlacesPrediction> getPredictedPlaces(String location) async {
    final googlePlaces = GoogleMapsPlaces(apiKey: apiKey);
//    final response1 = await googlePlaces.searchNearbyWithRadius(location, radius);


    final response = await googlePlaces.autocomplete(location);

    return PlacesPrediction.convertToPredictedPlace(response);
  }

}