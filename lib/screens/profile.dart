import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'login.dart';
import 'editprofile.dart';
import 'helpcenter.dart';
import 'report.dart';
import 'twofactor.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String userId = user?.uid ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFF4B002),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.collection('users').doc(userId).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No user data found.'));
                    }

                    var userData = snapshot.data!;
                    var userMap = userData.data() as Map<String, dynamic>?;

                    String profileImageUrl = userMap?.containsKey('profileImageUrl') ?? false
                        ? userMap!['profileImageUrl']
                        : 'assets/avatar.png';
                    String name = userMap?.containsKey('name') ?? false
                        ? userMap!['name']
                        : 'No name';
                    String email = userMap?.containsKey('email') ?? false
                        ? userMap!['email']
                        : 'No email';
                    String phoneNumber = userMap?.containsKey('phoneNumber') ?? false
                        ? userMap!['phoneNumber']
                        : 'No phone number';
                    String address = userMap?.containsKey('address') ?? false
                        ? userMap!['address']
                        : 'No address';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () => _pickImage(userId),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: profileImageUrl.startsWith('http')
                                  ? NetworkImage(profileImageUrl) as ImageProvider
                                  : AssetImage(profileImageUrl),
                              child: profileImageUrl == 'assets/avatar.png'
                                  ? const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                      size: 70,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        if (profileImageUrl == 'assets/avatar.png')
                          const Center(
                            child: Text(
                              'Click to upload your photo',
                              style: TextStyle(
                                  height: 2,
                                  fontSize: 12,
                                  color: Color.fromARGB(137, 39, 38, 38)),
                            ),
                          ),
                        const SizedBox(height: 10),
                        // Centered Name Display
                        Center(
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Button to view full profile
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _showFullProfileDialog(context, name, email,
                                  address, phoneNumber);
                            },
                            child: const Text('View Full Profile'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, 
                              backgroundColor: Colors.black,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        Transform.translate(
                        offset: const Offset(0, -20), // Move it up by 10 pixels
                          child: const SectionTitle(
                            title: 'Account Settings'), // Left-aligned title
                          ),
                        Transform.translate(
                        offset: const Offset(0, -20), // Move it up by 10 pixels
                          child: ProfileOption(
                          title: 'Edit Profile',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen()),
                            );
                          },
                        ),
                        ),
                        
                        Transform.translate(
                        offset: const Offset(0, -20), // Move it up by 10 pixels
                          child: ProfileOption(
                          title: 'Two-Factor Authentication',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TwoFactorAuthScreen()),
                            );
                          },
                        ),
                        ),
                        const SizedBox(height: 20),
                        
                        Transform.translate(
                        offset: const Offset(0, -40), // Move it up by 10 pixels
                          child: const SectionTitle(
                            title: 'Support Feedback'), // Left-aligned title
                        ),
                        Transform.translate(
                        offset: const Offset(0, -40), // Move it up by 10 pixels
                          child: ProfileOption(
                          title: 'Help Center',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HelpCenterScreen()),
                            );
                          },
                        ),
                        ),

                        Transform.translate(
                        offset: const Offset(0, -40), // Move it up by 10 pixels
                          child: ProfileOption(
                          title: 'Report a Problem',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ReportProblemScreen()),
                            );
                          },
                        ),
                        ),
                        const SizedBox(height: 20),
                        Transform.translate(
                        offset: const Offset(0, -60), // Move it up by 10 pixels
                          child: const SectionTitle(
                            title: 'Log Out'), // Left-aligned title
                        ),
                        Transform.translate(
                        offset: const Offset(0, -60), // Move it up by 10 pixels
                          child: ProfileOption(
                          title: 'Log Out Account',
                          onTap: () {
                            _showLogoutDialog(context);
                          },
                        ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Image.asset(
                  'assets/quicklogo.png',
                  height: 70,
                  width: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(String userId) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        try {
          UploadTask uploadTask =
              _storage.ref('profileImages/$userId').putFile(imageFile);
          TaskSnapshot snapshot = await uploadTask;

          String downloadUrl = await snapshot.ref.getDownloadURL();

          await _firestore.collection('users').doc(userId).update({
            'profileImageUrl': downloadUrl,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile image updated successfully!')),
          );

          setState(() {});
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error uploading image: $e')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _showFullProfileDialog(BuildContext context, String name, String email,
      String address, String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Full Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $name'),
              const SizedBox(height: 10),
              Text('Email: $email'),
              const SizedBox(height: 10),
              Text('Address: $address'),
              const SizedBox(height: 10),
              Text('Phone: $phoneNumber'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Log Out'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
