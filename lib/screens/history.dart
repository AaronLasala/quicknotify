import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4B002),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/quicklogo.png',
                  height: 130,
                  width: 100,
                ),
              ),
            ),
            const SizedBox(height: 1), // Reduce the space to move "History Log" upward
            Transform.translate(
              offset: const Offset(0, -50), // Move the text upward by 50 pixels
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'History Log',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Transform.translate(
              offset: const Offset(0, -20), // Move the container upward by 20 pixels
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE9B1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFE9B1), width: 30), // Add border with the specified color
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/recent_image.png',
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Transform.translate(
                offset: const Offset(0, -20),
                  child: const Text(
                    'Recently: 3:45 PM',
                    style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Transform.translate(
                offset: const Offset(0, -30),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  width: MediaQuery.of(context).size.width * 0.8, // Make the container smaller
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9B1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 50, // Make the container smaller
                          height: 50, // Make the container smaller
                          child: Image.asset(
                            'assets/image1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Visitor at 7:30 AM\nJune 01, 2024',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            Transform.translate(
                offset: const Offset(0, -30),
                child: 
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  width: MediaQuery.of(context).size.width * 0.8, // Make the container smaller
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9B1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 50, // Make the container smaller
                          height: 50, // Make the container smaller
                          child: Image.asset(
                            'assets/image2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Visitor at 9:35 PM\nMay 31, 2024',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            Transform.translate(
                offset: const Offset(0, -30),
                child: 
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  width: MediaQuery.of(context).size.width * 0.8, // Make the container smaller
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE9B1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 50, // Make the container smaller
                          height: 50, // Make the container smaller
                          child: Image.asset(
                            'assets/image3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Visitor at 5:00 PM\nMay 30, 2024',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
