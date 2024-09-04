import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('2575f8fa82c91ebbc0b3f32783816f11');
  Weather? _weather;

  dynamic _fechWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fechWeather();
  }

  String getWeatherAnime(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'dust':
      case 'ash':
      case 'squall':
        return 'assets/wind.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'snow':
        return 'assets/snow.json';
      case 'drizzle':
      case 'rain':
        return 'assets/shower.json';
      case 'thunderstorm':
      case 'tornado':
        return 'assets/thunder.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Icon(Icons.location_on, color: Colors.grey[700]),
                Text(
                  _weather?.cityName.toUpperCase() ?? 'Loading.. Weather',
                  style: TextStyle(
                      fontFamily: 'Freeman',
                      fontSize: 18,
                      color: Colors.grey[700]),
                ),
              ],
            ),
            Lottie.asset(getWeatherAnime(_weather?.mainCondition)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    '${_weather?.temperature.round()}°',
                    style: TextStyle(
                      fontFamily: 'Freeman',
                      fontSize: 60,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Text(
                  _weather?.mainCondition ?? "",
                  style: TextStyle(
                      fontFamily: 'Freeman',
                      fontSize: 18,
                      color: Colors.grey[700]),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}
