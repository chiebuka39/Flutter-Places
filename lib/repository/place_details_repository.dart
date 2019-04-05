import 'package:places_finder/api/place_details_api.dart';
import 'package:places_finder/models/place_details.dart';

class PlaceDetailsRepository{
  final PlaceDetailsApi client;

  PlaceDetailsRepository(this.client);


  Future<PlaceDetailsData> getDetails(String placeId) async{
    final result = await client.getPlaceDetails(placeId);
    print(result.formatted_address);
    print(result.url);
    return result;
  }
}