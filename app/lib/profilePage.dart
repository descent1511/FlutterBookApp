import 'package:app/components/downloadedEpub.dart';
import 'package:app/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/loginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Sign out from Firebase
              FirebaseAuth.instance.signOut();
              // Navigate back to login page
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/profile_image.png"), // Add your profile image
            ),
          ),
          const SizedBox(height: 12),
          Text(
            user?.displayName ?? 'No name', // Replace with user's name
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            user?.email ?? 'No email', // Replace with user's email
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Add functionality to edit profile
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // Button color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
            ),
            child: const Text('Edit Profile', style: TextStyle(fontSize: 12, color: white)),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal[50], // Set container background color
                borderRadius: BorderRadius.circular(20), // Set border radius
              ),
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              child: DownloadedEpub(),
            ),
          ),
        ],
      ),
    );
  }
}
