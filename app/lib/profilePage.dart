import 'package:app/components/downloadedEpub.dart';
import 'package:flutter/material.dart';
import 'package:app/loginPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate back to login page
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/images/profile_image.png"), // Add your profile image
          ),
          const SizedBox(height: 20),
          const Text(
            'Hoang Truong', // Replace with user's name
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'truong@example.com', // Replace with user's email
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add functionality to edit profile
            },
            child: const Text('Edit Profile'),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: DownloadedEpub(),
            ),
          ),
        ],
      ),
    );
  }
}