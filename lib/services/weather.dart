import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'package:clima/screens/location_screen.dart';


const apikey = '44bc73595e7e10718e7c68ee4ac82015';

class WeatherModel {

   Future<dynamic> getCityWeather(String cityName) async{

    var url = 'https://api.openweathermap.org/data/2.5/weather?q =$cityName&&appid=$apikey&units=metric';
    Networking networking = new Networking(url);

    var weatherdata = await networking.getData();
    return weatherdata;
  }


  Future<dynamic> getLocationWeather() async{
  location loc = new location();
  await loc.getCurrentLocation();

  Networking networking = new Networking(
      'https://api.openweathermap.org/data/2.5/weather?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apikey&units=metric');
  var data = await networking.getData();
}
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
