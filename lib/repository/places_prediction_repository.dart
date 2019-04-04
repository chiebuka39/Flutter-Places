import 'package:places_finder/api/places_prediction_api.dart';
import 'package:places_finder/models/place_prediction.dart';

class PlacesPredictionRepository{
  final PlacesPredictionApi client;

  PlacesPredictionRepository(this.client);


  Future<PlacesPrediction> getPredictions(String term) async{
    final result = await client.getPredictedPlaces(term);
    return result;
  }
}