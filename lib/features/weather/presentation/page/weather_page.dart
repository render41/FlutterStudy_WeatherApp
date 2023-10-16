import 'package:flutter/material.dart';
import 'package:flutterstudy_weatherapp/features/weather/data/model/weather_model.dart';
import 'package:flutterstudy_weatherapp/features/weather/data/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('6c84c5afab1a995f4fdb0f4c79e74924');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() => _weather = weather);
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }

  Widget get body {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [cityLocation, temperature, mainCondition],
        ),
      ),
    );
  }

  Widget get cityLocation {
    return Column(
      children: [
        const Icon(Icons.location_on, size: 40, color: Colors.white70),
        Text(
          _weather?.cityName ?? 'Loading city...',
          style: const TextStyle(fontSize: 20, color: Colors.white70),
        ),
      ],
    );
  }

  Widget get temperature {
    return Text('${_weather?.temperature}°C',
        style: const TextStyle(fontSize: 50, color: Colors.yellow));
  }

  Widget get mainCondition {
    return Text('Weather Condition: ${_weather?.mainCondition}' ?? '',
        style: const TextStyle(fontSize: 16, color: Colors.white70));
  }
}
