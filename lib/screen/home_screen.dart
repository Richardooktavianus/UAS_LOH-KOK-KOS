import 'package:flutter/material.dart';
import 'package:kossan/screen/login_screen.dart';
import 'package:kossan/screen/profile_screen.dart';
import 'package:kossan/screen/setting_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 50),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text("Home", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text("Profile", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.bookmark, color: Colors.white),
                title: Text("Bookmark", style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BookmarkPage(),
                  //   )
                  // );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text("Settings", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text("Logout", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            // Search bar and filter button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari kamarmu disini",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle filter button tap
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                    backgroundColor: Colors.blue,
                  ),
                  child: Icon(Icons.filter_alt, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton("Kategori", selected: true),
                  _buildCategoryButton("Kamar"),
                  _buildCategoryButton("Fasilitas"),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Rekomendasi untukmu"),
            SizedBox(height: 10),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPropertyCard(
                      "Dreamsville House", "Jl Sultan Iskandar Muda", "1.8 km"),
                  _buildPropertyCard(
                      "Ascot House", "Jl Cilandak Tengah", "2.0 km"),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Best for you"),
            SizedBox(height: 10),
            _buildPropertyListTile(
                "Orchard House", "Rp. 2.500.000.000 / Year", 6, 4),
            _buildPropertyListTile(
                "The Hollies House", "Rp. 2.000.000.000 / Year", 5, 2),
            _buildPropertyListTile(
                "Sea Breezes House", "Rp. 900.000.000 / Year", 2, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title,
      {bool isSelected = false, bool showDot = false}) {
    return ListTile(
      leading: Stack(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          if (showDot)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        // Handle navigation
      },
      selected: isSelected,
      selectedTileColor: Colors.blue[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildCategoryButton(String label, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? Colors.blue : Colors.grey[200],
          foregroundColor: selected ? Colors.white : Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            // Handle "See more" tap
          },
          child: Text("See more"),
        ),
      ],
    );
  }

  Widget _buildPropertyCard(String title, String location, String distance) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage("assets/house.jpg"), // Placeholder image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(location),
                Text(distance, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyListTile(
      String title, String price, int bedrooms, int bathrooms) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
          image: DecorationImage(
            image: AssetImage("assets/house.jpg"), // Placeholder image
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(price),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bed, size: 16, color: Colors.grey),
          SizedBox(width: 4),
          Text("$bedrooms Bedroom"),
          SizedBox(width: 8),
          Icon(Icons.bathtub, size: 16, color: Colors.grey),
          SizedBox(width: 4),
          Text("$bathrooms Bathroom"),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
