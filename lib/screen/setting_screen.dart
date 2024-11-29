import 'package:flutter/material.dart';
import 'package:kossan/provider/theme_provider.dart';
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark mode for the app'),
            value: themeProvider.isDarkMode,
            onChanged: (bool value) {
              setState(() {
                themeProvider.toggleTheme(value);
              });
            },
          ),
          Divider(),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive updates and notifications'),
            value: isNotificationEnabled,
            onChanged: (bool value) {
              setState(() {
                isNotificationEnabled = value;
              });
            },
          ),
          Divider(),
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
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
