import 'package:flutter/material.dart';
import 'profile.dart'; // Assuming ProfileScreen is in profile.dart

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4B002),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20), // Add space for visual separation
                  const Text(
                    'EDIT PROFILE',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  // Name
                  SizedBox(
                    width: 300,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE9B1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),                
                  // Phone Number
                  SizedBox(
                    width: 300,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE9B1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Address
                  SizedBox(
                    width: 300,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE9B1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Address',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement save functionality
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE9B1)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Text('SAVE CHANGES'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40, // Position the back button near the top
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ),
          Positioned(
            top: 20, // Position the logo near the top
            right: 7,
            child: Image.asset(
              'assets/quicklogo.png', // Replace with your image path
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
