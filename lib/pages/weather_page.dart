import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hw5_noteapp/model/weather_model.dart';
import 'package:hw5_noteapp/services/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.toggleThemeMode});

  final VoidCallback toggleThemeMode;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("6511891c834f40515efdc695ade11c5c");
  Weather? _weather;
  final TextEditingController _cityController = TextEditingController();
  static TextStyle textStyle = GoogleFonts.prompt(
      fontSize: 26,
      color: const Color.fromARGB(255, 134, 101, 234),
      fontWeight: FontWeight.w700,
      );

  // Variable for temperature unit (Celsius or Fahrenheit)
  String _unit = 'C'; // 'C' for Celsius, 'F' for Fahrenheit

  // Function to fetch weather data based on city or current location
  _fetchWeather() async {
    try {
      if (_cityController.text.isEmpty) {
        // Get current location if city name is not provided
        final location = await _weatherService.getCurrentLocation();
        final weather = await _weatherService.getWeather(location);
        setState(() {
          _weather = weather;
        });
      } else {
        // Fetch weather by city name
        final weather =
            await _weatherService.getWeatherByCityName(_cityController.text);
        setState(() {
          _weather = weather;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/animation/loading.json";
    switch (mainCondition.toLowerCase()) {
      case "clouds":
        return "assets/animation/cloudy.json";
      case "fog":
        return "assets/animation/fog.json";
      case "mist":
      case "smoke":
      case "dust":
      case "haze":
        return "assets/animation/cloudy.json";
      case "rain":
        return "assets/animation/rain.json";
      case "drizzle":
        return "assets/animation/rain.json";
      case "shower rain":
        return "assets/animation/rain.json";
      case "thunderstorm":
        return "assets/animation/thunderstorm.json";
      default:
        return "assets/animation/sunny.json";
    }
  }

  String convertTemperature(double tempCelsius) {
    if (_unit == 'C') {
      return "${tempCelsius.round()} °C";
    } else {
      double tempFahrenheit = (tempCelsius * 9 / 5) + 32;
      return "${tempFahrenheit.round()} °F";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(); // Fetch weather based on current location or default city
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleThemeMode, // Call the toggle function
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _weather?.cityName ?? "Loading city...",
                  style: textStyle,
                ),
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition),
                    height: 250),
                Text(
                  _weather != null
                      ? convertTemperature(_weather!.temperature)
                      : "Loading temperature...",
                  style: textStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  _weather?.mainCondition ?? "",
                  style: textStyle,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'Enter city',
                    hintText: 'e.g., Bangkok',
                  ),
                  onSubmitted: (_) => _fetchWeather(),
                ),
                // const SizedBox(height: 30),
                // ElevatedButton(
                //   onPressed: _fetchWeather,
                //   child: const Text('Check Weather'),
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Temperature Unit: "),
                    Switch(
                      value: _unit == 'F',
                      onChanged: (value) {
                        setState(() {
                          _unit = value ? 'F' : 'C';
                        });
                      },
                    ),
                    Text(_unit == 'F' ? "Fahrenheit" : "Celsius"),
                  ],
                ),
                ElevatedButton(
                  onPressed: _fetchWeather,
                  child: const Text('Check Weather'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
