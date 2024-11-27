import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Settings", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingOption(Icons.privacy_tip, "Privacy Policy", () {
              // Handle privacy policy
            }),
            _buildSettingOption(Icons.info, "About Us", () {
              // Handle about us
            }),
            Divider(thickness: 1),
            _buildSettingOption(Icons.logout, "Logout", () {
              // Handle logout
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontSize: 18)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
