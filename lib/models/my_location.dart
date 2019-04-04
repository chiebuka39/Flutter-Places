class MyLocationData{
  final lat, lon;

  MyLocationData(this.lat, this.lon);

  static MyLocationData locationItems(Map<String, double> location){
    double lat = location['latitude'];
    double lon = location['longitude'];

    print("$lat  --  $lon");

    return MyLocationData(lat, lon);
  }
}