import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String API;

  WeatherService(this.API);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('${URL}?q=${cityName}&APPID=${API}&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    //get permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    //converting position to long and lat
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //extracting city name
    String? city = placemarks[0].locality;
    return city ?? ""; //if null return blank string
  }
}
