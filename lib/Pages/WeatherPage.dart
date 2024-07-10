import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/service/weatherService.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('5746e2e42b556b382f92e088ef4c6063');
  Weather? _weather;
  // fetch weather

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCond) {
    if (mainCond == null) {
      return 'assets/sunny.json';
    }
    switch (mainCond.toLowerCase()) {
      case 'clouds':
      case 'fog':
        {
          return 'assets/clody.json';
          break;
        }
      case 'rain':
      case 'drizzle':
        return 'assets/rainy.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.accessibility_rounded),
          onPressed: () {},
        ),
        backgroundColor: Colors.blueAccent,
        title: Center(
            child: Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        )),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_rounded),
              Text(_weather?.cityName ?? 'Loading city name...'),
              Lottie.asset(getWeatherAnimation(_weather?.mainCond)),
              Text('${_weather?.temp.round()} C'),
              Text(_weather?.mainCond ?? " ")
            ],
          ),
        ),
      ),
    );
  }
}
