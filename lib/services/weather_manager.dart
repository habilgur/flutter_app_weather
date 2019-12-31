import 'location_manager.dart';
import 'http_helper.dart';

const apiKey = "73ae449c0cf83260db5329638c109ceb";
const openWeatherApiUrl = "https://api.openweathermap.org/data/2.5/weather";

class WeatherDataManager {
  Future<dynamic> getLocationThenGetWeatherJson() async {
    GeoLocationManager geoLocationManager = GeoLocationManager();
    await geoLocationManager.getLocation();
    var url =
        "$openWeatherApiUrl?lat=${geoLocationManager.latitude}&lon=${geoLocationManager.longitude}&appid=$apiKey&units=metric";
    var weatherData = await HttpHelper(url).getJsonData();
    print(weatherData);
    return weatherData; // As a json Object
  }

  Future<dynamic> getLocationByName(String cityName) async {
    cityName = cityName.toLowerCase();
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";
    var weatherData = await HttpHelper(url).getJsonData();
    return weatherData;
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
      return '🌞️';
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
