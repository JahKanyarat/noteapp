import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hw5_noteapp/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeatherByCityName(String cityName) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric&lang=th"; 
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("ไม่สามารถโหลดข้อมูลอากาศได้");
    }
  }

  Future<List> getCurrentLocation() async {
    //get permission from user
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    //fetch the current location
    // Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // debugPrint(pos.toString());
    // return [pos.latitude, pos.longitude];

    // Fetch the current location using location settings
    Position pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, // Set the accuracy level
        distanceFilter: 10, // Set the distance filter in meters
      ),
    );
    debugPrint(pos.toString());
    return [pos.latitude, pos.longitude];

  }

  Future<Weather> getWeather(List pos) async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${pos[0]}&lon=${pos[1]}&appid=$apiKey&units=metric";
    // debugPrint("url: $url");
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  getWeatherByZipCode(String input, String s) {}

  // Future<String> getCurrentCity(List pos) async{
  //   //convert the location into a list of placemark objects (Geocoding Plugin)
  //   List<Placemark> placemarks = await placemarkFromCoordinates(pos[0], pos[1]);

  //   // debugPrint("item: $placemarks");
  //   //extract the city name form the first placemarks
  //   String? city = placemarks[0].locality;

  //   return city ?? "";
  // }

  // Future<void> verifyCityName(String cityName) async {
  //   try {
  //     // Load city list JSON from assets
  //     String cityListJson = await rootBundle.loadString('assets/city.list.json');
  //     List<dynamic> cityList = jsonDecode(cityListJson);

  //     // Search for matching city name
  //     bool found = false;
  //     for (var cityInfo in cityList) {
  //       if (cityInfo['name'] == cityName) {
  //         found = true;
  //         break;
  //       }
  //     }

  //     if (found) {
  //       // print('$cityName found in OpenWeatherMap city list.');
  //       // Proceed with weather API call using cityName
  //     } else {
  //       // print('$cityName not found in OpenWeatherMap city list.');
  //       // Handle case where city name is not recognized
  //     }

  //   } catch (e) {
  //     // print('Error loading or parsing city list JSON: $e');
  //     // Handle error loading JSON or searching for city name
  //   }
  // }
}
