import 'package:filmku/homescreen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDiagonalImage('assets/poster_top.jpeg',-10, Alignment.topCenter),
            SizedBox(height: 20,),
            _buildDiagonalImage('assets/poster_midle.jpeg',-10, Alignment.center),
            SizedBox(height: 20,),
            _buildDiagonalImage('assets/poster_botom.jpeg', -10, Alignment.bottomCenter),
            SizedBox(height: 30,),
            // Title and subtitle
            Column(
              children: [
                Text(
                  "KLIX",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Best movie in one Klix",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Gradient Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homescreen(),
                    ),
                  );

                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),

                  ),
                  elevation: 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    "Watch Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Diagonal Image Builder
  Widget _buildDiagonalImage(String imagePath, double rotationAngle, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: rotationAngle * (3.14159 / 180),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 146, // Adjust height for each image
        ),
      ),
    );
  }
}
