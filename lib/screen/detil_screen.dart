import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String imagePath;

  const DetailScreen({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('img/$imagePath'),
            Text('Details for $title'),
          ],
        ),
      ),
    );
  }
}
