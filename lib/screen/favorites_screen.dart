import 'package:flutter/material.dart';
import 'package:kossan/model/kamar.dart';
import 'package:kossan/provider/favorites_provider.dart';
import 'package:kossan/provider/theme_provider.dart';
import 'package:kossan/screen/detil_screen.dart';
import 'package:kossan/screen/home_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final favoriteRooms = Provider.of<FavoritesProvider>(context).favoriteRooms;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor:
            themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal,
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
      body: favoriteRooms.isEmpty
          ? const Center(
              child: Text(
                'No favorite rooms added.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? Colors.grey[900]
                    : Colors.white, // Solid background color
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: favoriteRooms.length,
                itemBuilder: (context, index) {
                  final room = favoriteRooms[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(kamar: room),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 6, // Reduced elevation for a softer look
                      shadowColor: Colors.black.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: AspectRatio(
                              aspectRatio: 3 / 2,
                              child: Image.asset(
                                'img/${room.imagePath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback in case of error
                                  return Image.asset(
                                    'assets/default_image.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              room.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
