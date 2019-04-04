import 'package:google_maps_webservice/places.dart';
import 'package:places_finder/config/config.dart';
import 'package:places_finder/models/coffe_shops_data.dart';
import 'package:places_finder/models/my_location.dart';

class CoffeeShopsApi {
  static CoffeeShopsApi _instance;
  static CoffeeShopsApi getInstance() => _instance ??= CoffeeShopsApi();

  Future<CoffeeShopsData> getCoffeeShops(MyLocationData location) async {

    final googlePlaces = GoogleMapsPlaces(apiKey: apiKey);
    final response = await googlePlaces.searchNearbyWithRadius(
        Location(location.lat, location.lon),
        2000, type: 'Cafe', keyword: 'coffee');
    return CoffeeShopsData.convertToShops(response.results);
  }
}