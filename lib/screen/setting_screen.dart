import 'package:flutter/material.dart';
import 'package:kossan/provider/theme_provider.dart';
import 'package:kossan/screen/profile_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isNotificationEnabled = true;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor:
            themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Dark Mode Toggle
          _buildSectionTitle("Appearance"),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark mode for the app'),
            value: themeProvider.isDarkMode,
            onChanged: (bool value) {
              setState(() {
                themeProvider.toggleTheme(value);
              });
            },
            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.blue.withOpacity(0.4),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          const Divider(),

          // Notification Toggle
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive updates and notifications'),
            value: isNotificationEnabled,
            onChanged: (bool value) {
              setState(() {
                isNotificationEnabled = value;
              });
            },
            activeColor: Colors.greenAccent,
            activeTrackColor: Colors.green.withOpacity(0.4),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          const Divider(),

          // Language Selection Dropdown
          _buildSectionTitle("Language Preferences"),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(selectedLanguage),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
              items: <String>['English', 'Bahasa Indonesia', 'Español']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              icon: const Icon(Icons.arrow_drop_down),
              style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.white
                      : Colors.black87),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  // Custom section header to make it more elegant
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}
