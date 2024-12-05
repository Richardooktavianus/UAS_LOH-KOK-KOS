import 'package:flutter/material.dart';
import 'package:kossan/provider/favorites_provider.dart';
import 'package:kossan/provider/theme_provider.dart';
import 'package:kossan/screen/detil_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kossan/screen/home_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;
    final aspectRatio =
        screenWidth > 600 ? 0.65 : 0.75; // Adjust based on screen size

    if (userId != null) {
      favoritesProvider.fetchFavorites(userId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: themeProvider.isDarkMode
            ? Colors.grey[900]
            : Colors.teal, // Fixed background color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: favoritesProvider.favoriteRooms.isEmpty
          ? const Center(child: Text('No favorite rooms added.'))
          : Container(
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? Colors.grey[900]
                    : Colors.white, // Solid background color
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: aspectRatio, // Dynamic aspect ratio
                ),
                itemCount: favoritesProvider.favoriteRooms.length,
                itemBuilder: (context, index) {
                  final room = favoritesProvider.favoriteRooms[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(kamar: room),
                        ),
                      );
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double cardWidth = constraints.maxWidth;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6, // Reduced elevation for a softer look
                          shadowColor: themeProvider.isDarkMode
                              ? Colors.grey[800]!.withOpacity(0.2)
                              : Colors.black.withOpacity(0.2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.asset(
                                  'img/${room.imagePath}',
                                  fit: BoxFit.cover,
                                  height: cardWidth * 1,
                                  width: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  room.title,
                                  style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? Colors.white
                                        : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
