import 'package:google_maps_webservice/places.dart';

class PlacesPrediction{
  List<PredictedPlace> placesList;

  PlacesPrediction(this.placesList);

  static convertToPredictedPlace(PlacesAutocompleteResponse response){
    List<PredictedPlace> places = [];

    response.predictions.forEach((prediction){
      places.add(PredictedPlace(
        id: prediction.id,
        placeId: prediction.placeId,
        description: prediction.description
      ));
    });

    return PlacesPrediction(places);
  }


}

class PredictedPlace{
  final String id;
  final String description;
  final String placeId;

  PredictedPlace({this.id, this.description, this.placeId});


}