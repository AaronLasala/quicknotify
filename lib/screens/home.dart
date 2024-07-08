import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'history.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreenContent(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4B002), // Set background color for the entire screen
      body: Column(
        children: [
          Expanded(
            child: _children[_currentIndex], // Display the selected child widget
          ),
          Container(
            height: 80.0, // Set fixed height for the bottom navigation bar container
            width: 380,
            padding: const EdgeInsets.all(8.0), // Add padding around the Container
            margin: const EdgeInsets.only(bottom: 10.0), // Space below the BottomNavigationBar
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0), // Rounded edges
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, // Reduced width
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent, // Set to transparent to show the container's color
                  elevation: 0, // Remove shadow
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black.withOpacity(0.6),
                  onTap: onTabTapped,
                  currentIndex: _currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.history),
                      label: 'History',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  final TextEditingController _controller = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  void _sendTextToFirebase() {
    final String text = _controller.text;
    if (text.isNotEmpty && user != null) {
      FirebaseFirestore.instance
          .collection('visitor_messages')
          .doc(user!.uid)
          .set({
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/quicklogo.png',
                    height: 130,
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Transform.translate(
                offset: const Offset(0, -50), // Move it up by 10 pixels
                child: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visitor',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          'is at your door...',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Transform.translate(
                offset: const Offset(0, -50), // Move it up by 10 pixels
                child: const CircleAvatar(
                  radius: 160, // Increased radius to make the placeholder larger
                  backgroundImage: AssetImage(
                      'assets/visitor_placeholder.jpg'), // Placeholder image
                ),
              ),
              const SizedBox(height: 20),
              Transform.translate(
                offset: const Offset(0, -50), // Move it up by 10 pixels
                child: const Text(
                  'Visitor at 3:45 PM',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -50), // Move it up by 10 pixels
                child: const Text(
                  '1 minute ago',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Transform.translate(
                offset: const Offset(0, -50), // Move it up by 10 pixels
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _sendTextToFirebase,
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
