import 'package:flutter/material.dart';
import 'package:hw5_noteapp/pages/weather_page.dart'; // WeatherPage import
import 'package:hw5_noteapp/pages/notes_page.dart'; // NotesPage import

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default to light mode

  // Function to toggle theme
  void _toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather & Notes App',
      themeMode: _themeMode, // Apply theme mode here
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(
          toggleThemeMode:
              _toggleThemeMode), // HomePage that can navigate between Weather and Notes pages
    );
  }
}

class HomePage extends StatelessWidget {
  final void Function() toggleThemeMode;

  const HomePage({super.key, required this.toggleThemeMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather & Notes App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleThemeMode,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Weather App"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage(toggleThemeMode: () {  },)),
                );
              },
            ),
            ListTile(
              title: const Text("Notes"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotesPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Select Weather or Notes from the Drawer'),
      ),
    );
  }
}
