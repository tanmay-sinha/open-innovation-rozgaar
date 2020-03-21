import 'package:location/location.dart';

class FetchLocation{
  LocationData _currentLocation;
  Location _locationService = Location();
  Future<Map<String, double>> returnLocation() async {
    Map<String, double> location = {
      'latitude': 0.0,
      'longitude': 0.0,
    };
    _currentLocation = await getLocation();
    location['latitude'] = _currentLocation.latitude;
    location['longitude'] = _currentLocation.longitude;
    return location;
  }

  Future<LocationData> getLocation() async {
      LocationData currentLocation;
      try {
        currentLocation = await _locationService.getLocation();
      } catch (e) {
        currentLocation = null;
      }
      return currentLocation;
  }

}