import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/provider/favorites_provider.dart';
import 'package:kossan/provider/theme_provider.dart';
import 'package:kossan/screen/booking_screen.dart';
import 'package:kossan/screen/home_screen.dart';

import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Product kamar;

  const DetailScreen({required this.kamar});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final favoriteProvider = Provider.of<FavoritesProvider>(context);

    bool isFavorited = favoriteProvider.favoriteRooms.contains(kamar);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkMode ? Colors.grey[900] : Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black87,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              favoriteProvider.toggleFavorite(kamar);
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited
                  ? (themeProvider.isDarkMode ? Colors.red : Colors.redAccent)
                  : (themeProvider.isDarkMode ? Colors.white : Colors.grey),
              size: 30,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildImage(kamar.imagePath),
          const SizedBox(height: 20),
          _buildTitle(kamar.title, themeProvider),
          const SizedBox(height: 10),
          _buildPrice(kamar.price, themeProvider),
          const SizedBox(height: 20),
          _buildDescription(kamar.description, themeProvider),
          const SizedBox(height: 20),
          _buildFacilities(themeProvider),
          const SizedBox(height: 40),
          _buildBookButton(context, kamar),
        ],
      ),
    );
  }

  // Method to build the image
  Widget _buildImage(String? imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        'img/${imagePath ?? 'default_image.png'}',
        fit: BoxFit.cover,
        height: 250,
        width: double.infinity,
      ),
    );
  }

  // Method to build the title
  Widget _buildTitle(String title, ThemeProvider themeProvider) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black87,
      ),
    );
  }

  // Method to format and display the price
  Widget _buildPrice(double price, ThemeProvider themeProvider) {
    return Text(
      'Rp ${NumberFormat('#,##0', 'id_ID').format(price)}',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black87,
      ),
    );
  }

  // Method to display the description
  Widget _buildDescription(String description, ThemeProvider themeProvider) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 18,
        color: themeProvider.isDarkMode ? Colors.white70 : Colors.black87,
        height: 1.5,
      ),
    );
  }

  // Method to display the facilities
  Widget _buildFacilities(ThemeProvider themeProvider) {
    return Text(
      'Facilities: \n- AC \n- 2 single bed \n- TV \n- Kamar mandi dalam',
      style: themeProvider.isDarkMode
          ? const TextStyle(
              fontSize: 16,
              color: Colors.white,
            )
          : const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
    );
  }

  // Method to build the booking button
  Widget _buildBookButton(BuildContext context, Product kamar) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookingScreen(kamar: kamar),
          ),
        );
      },
      child: const Text('Book now'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
