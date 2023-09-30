import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationweather});
  final dynamic locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String message='';
  String weatherIcon='';
  int temperature= 0;

  WeatherModel weathermodel = new WeatherModel();

  @override
  void initState(){
    super.initState();
    print(widget.locationweather);
  }
  void updateUI(dynamic data){
    setState(() {
      if(data == null){
        temperature=0;
        weatherIcon= 'Error';
        message='unable to get data';
        return ;
      }
     double temp = data['main']['temp'];
      temperature= temp.toInt();
  int condition = data['weather']['0']['id'];
     message = weathermodel.getMessage(temperature);
     weatherIcon = weathermodel.getWeatherIcon(condition);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async{
                      var weather= await weathermodel.getLocationWeather();
                      updateUI(weather);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      var typedNamed= await Navigator.push(context,MaterialPageRoute(builder: (context)=> CityScreen()),
                      );
                      if(typedNamed != null){
                          var weatherdata = weathermodel.getCityWeather(typedNamed);
                          updateUI(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  message,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// double temperature = decodedData['main']['temp'];
// int condition = decodedData['weather']['0']['id'];
