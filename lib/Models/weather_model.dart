class Weather {
  final String cityName;
  final double temp;
  final String mainCond;

  Weather({required this.cityName, required this.temp, required this.mainCond});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temp: json['main']['temp'].toDouble,
        mainCond: json['weather'][0]['main']);
  }
}
