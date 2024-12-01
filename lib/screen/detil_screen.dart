// screens/detail_screen.dart
import 'package:flutter/material.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/screen/booking_screen.dart';
import 'package:kossan/provider/favorites_provider.dart';
import 'package:provider/provider.dart';

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
    // Check if the room is already in the favorites list
    final favoriteProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    isFavorited = favoriteProvider.favoriteRooms.contains(widget.kamar);
  }

  @override
  Widget build(BuildContext context) {
    final kamar = widget.kamar;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'img/${kamar.imagePath ?? 'default_image.png'}',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              kamar.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: Rp ${kamar.price}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              kamar.description,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              'Facilities',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.wifi, color: Colors.blue),
                Icon(Icons.restaurant, color: Colors.blue),
                Icon(Icons.pool, color: Colors.blue),
                Icon(Icons.tv, color: Colors.blue),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
