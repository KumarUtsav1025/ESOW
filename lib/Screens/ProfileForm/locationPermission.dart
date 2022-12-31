import 'package:intl/intl.dart';
import 'package:location/location.dart';

class LocationTrack{

  Future<String> getLocation() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    _locationData = await location.getLocation();


    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String time = DateFormat("HH:mm:ss").format(DateTime.now());

    String locationString = "Dt:${date}; Tm: ${time}; \n lat: ${_locationData.latitude}; long:${_locationData.longitude}";
    print(locationString);
    return locationString;
  }
}