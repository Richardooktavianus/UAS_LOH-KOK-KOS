import 'package:flutter/material.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/screen/booking_screen.dart';
import 'package:kossan/provider/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'package:kossan/provider/theme_provider.dart';

class DetailScreen extends StatefulWidget {
  final Product kamar;

  const DetailScreen({required this.kamar});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorited = false;

  void toggleFavorite() {
    final favoriteProvider =
        Provider.of<FavoritesProvider>(context, listen: false);

    setState(() {
      if (isFavorited) {
        favoriteProvider.removeFavorite(widget.kamar);
      } else {
        favoriteProvider.addFavorite(widget.kamar);
      }
      isFavorited = !isFavorited;
    });
  }

  @override
  void initState() {
    super.initState();
    final favoriteProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    isFavorited = favoriteProvider.favoriteRooms.contains(widget.kamar);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final kamar = widget.kamar;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeProvider.isDarkMode ? Colors.white : Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: toggleFavorite,
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'img/${kamar.imagePath ?? 'default_image.png'}',
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            kamar.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Price: Rp ${kamar.price}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            kamar.description,
            style: TextStyle(
              fontSize: 18,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Facilities',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color:themeProvider.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          GridView(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children: const [
              _FacilityIcon(icon: Icons.wifi, label: 'Wi-Fi'),
              _FacilityIcon(icon: Icons.restaurant, label: 'Food'),
              _FacilityIcon(icon: Icons.pool, label: 'Pool'),
              _FacilityIcon(icon: Icons.tv, label: 'TV'),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                    horizontal: 60, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(kamar: kamar),
                  ),
                );
              },
              child: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FacilityIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FacilityIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 30, color: Colors.greenAccent),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black87, fontSize: 14),
        ),
      ],
    );
  }
}

