import 'package:flutter/material.dart';
import 'package:kossan/provider/theme_provider.dart';
import 'package:kossan/screen/detil_screen.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/screen/detil_screen.dart';
import 'package:kossan/screen/setting_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Loh Kok Kos!'),
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.black
            : Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search address, or near you',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Near from you',
                      style: Theme.of(context).textTheme.titleLarge),
                  TextButton(onPressed: () {}, child: const Text('See more')),
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPropertyCard(
                        'Dreamsville House', '1.8 km', 'rumah2.jpg'),
                    _buildPropertyCard('Ascot House', '2.0 km', 'rumah.jpg'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Best for you',
                      style: Theme.of(context).textTheme.titleLarge),
                  TextButton(onPressed: () {}, child: const Text('See more')),
                ],
              ),
              Column(
                children: [
                  _buildPropertyListTile(
                      'Orchard House',
                      'Rp. 2.500.000.000/Year',
                      '6 Bedroom | 4 Bathroom',
                      'kamar1.jpg'),
                  _buildPropertyListTile(
                      'The Hollies House',
                      'Rp. 2.000.000.000/Year',
                      '5 Bedroom | 2 Bathroom',
                      'kamar2.jpg'),
                  _buildPropertyListTile(
                      'Sea Breezes House',
                      'Rp. 900.000.000/Year',
                      '2 Bedroom | 2 Bathroom',
                      'kamar3.jpg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildPropertyCard(String title, String distance, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, imagePath: imagePath),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: imagePath.isNotEmpty
                  ? Image.asset(
                      'img/$imagePath',
                      fit: BoxFit.cover,
                      height: 120,
                      width: 160,
                    )
                  : Container(
                      height: 120,
                      width: 160,
                      color: Colors.grey[300],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(distance, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyListTile(
      String title, String price, String specs, String imagePath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, imagePath: imagePath),
          ),
        );
      },
      child: ListTile(
        leading: Image.asset('img/$imagePath',
            width: 70, height: 70, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$price\n$specs'),
        isThreeLine: true,
      ),
    );
  }
}
