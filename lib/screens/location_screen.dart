import 'package:flutter/material.dart';
import 'package:flutter_app_weather/screens/city_screen.dart';
import 'package:flutter_app_weather/services/weather_manager.dart';
import 'package:flutter_app_weather/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final weatherJsonData;
  LocationScreen(this.weatherJsonData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temprature;
  String cityName;
  int condition;
  String weatherIcon;
  String message;

  @override
  void initState() {
    super.initState();
    upDateUI(widget.weatherJsonData);
  }

  upDateUI(dynamic weatherJsonData) {
    setState(() {
      if (weatherJsonData == null) {
        temprature = 0;
        cityName = "Unknown";
        message = "Error";
        weatherIcon = " ";
      } else {
        var temp = weatherJsonData["main"]["temp"];
        temprature = temp.toInt();
        cityName = weatherJsonData["name"];
        condition = weatherJsonData["weather"][0]["id"];

        WeatherDataManager wModel = WeatherDataManager();
        weatherIcon = wModel.getWeatherIcon(condition);
        message = wModel.getMessage(temprature.toInt());
      }
    });
  }

  @override
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
                  FlatButton(
                    //Refresh Current Location
                    onPressed: () async {
                      WeatherDataManager wModel = WeatherDataManager();
                      var weatherJsonData =
                          await wModel.getLocationThenGetWeatherJson();
                      upDateUI(weatherJsonData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    //Search new city
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
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
                      temprature.toString(),
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
                  "$message in $cityName",
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
