import 'package:intl/intl.dart';
import 'package:location/location.dart';

class LocationTrack{

  Future<Map<String,List<String>>> getLocation() async{
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

    Map<String,List<String>> locationData = {
      'timeStamp':[date,time],
      'location':[_locationData.latitude.toString(),_locationData.longitude.toString()],
    };
    print(locationData);
    return locationData;
  }
}