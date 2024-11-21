import 'package:flutter/material.dart';
import 'package:hw5_noteapp/components/drawer_tile.dart';
import 'package:hw5_noteapp/pages/setting_page.dart';
import 'package:hw5_noteapp/pages/weather_page.dart'; // ใช้ path ที่เหมาะสม

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        children: [
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Note App",
                style: Theme.of(context).textTheme.displayLarge!,
              ),
            ),
          ),
          DrawerTile(
            title: "Notes",
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: "Weather App",
            leading: const Icon(Icons.cloud),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeatherPage(toggleThemeMode: () {  },),
                ),
              );
            },
          ),
          DrawerTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
