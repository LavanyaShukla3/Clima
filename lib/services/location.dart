import 'package:geolocator/geolocator.dart';
class location{

  //{(this.latitude,this.longitude)};
double? latitude;
double? longitude;

Future <void> getCurrentLocation() async{
  LocationPermission permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.denied) {
    // Handle case where user denies the permission
    print('User denied location permission.');
    return;
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle case where user denies the permission permanently
    print('User denied location permission permanently.');
    return;
  }

  if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
    // Permission granted, proceed to get the location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position);
    }
    catch(e){
      print(e) ;
    }
  }
}

}
