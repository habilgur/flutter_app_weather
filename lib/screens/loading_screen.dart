import 'package:flutter/material.dart';
import 'package:flutter_app_weather/screens/location_screen.dart';
import 'package:flutter_app_weather/services/weather_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherDataManager weatherDataManager = WeatherDataManager();
  @override
  void initState() {
    super.initState();
    getInitialLocationAndNavigateToLocScreen();
  }

  getInitialLocationAndNavigateToLocScreen() async {
    var weatherJsonData =
        await weatherDataManager.getLocationThenGetWeatherJson();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(weatherJsonData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.pink,
        ),
      ),
    );
  }
}
