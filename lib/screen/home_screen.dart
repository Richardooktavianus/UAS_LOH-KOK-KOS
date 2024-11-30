import 'package:flutter/material.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/provider/theme_provider.dart';
import 'package:kossan/screen/detil_screen.dart';
import 'package:kossan/screen/history_screen.dart';
import 'package:kossan/screen/profile_screen.dart';
import 'package:kossan/screen/setting_screen.dart';
import 'package:kossan/data/data_kamar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Loh Kok Kos!'),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            _buildDrawerItem(Icons.home, 'Home', const HomeScreen()),
            _buildDrawerItem(Icons.history, 'History', HistoryScreen()),
            _buildDrawerItem(Icons.person, 'Profile', const ProfileScreen()),
            _buildDrawerItem(Icons.favorite, 'Favorites', const HomeScreen()),
            _buildDrawerItem(Icons.settings, 'Settings', SettingsScreen()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildGridView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, Widget? screen) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (screen != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => screen));
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onSubmitted: (value) {
              searchProduct(value);
            },
          ),
        ),
      ],
    );
  }

  void searchProduct(String keyword) {
    final List<Product> kamarList = DataKamar.dataKamar
        .where((element) =>
            element.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    if (kamarList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product not found')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(kamar: kamarList.first),
        ),
      );
    }
  }

  Widget _buildGridView() {
    final List<Product> kamarList = DataKamar.dataKamar;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: kamarList.length,
      itemBuilder: (context, index) {
        final kamar = kamarList[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(kamar: kamar),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    'img/${kamar.imagePath}',
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kamar.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp ${kamar.price}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
