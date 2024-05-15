// ignore: file_names
import 'package:app/rootApp.dart';
import 'package:app/signUpPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: (value) {
                _username = value;
              },
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person), 
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                _password = value;
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock), 
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                debugPrint("Login");
                debugPrint("Username: $_username");
                debugPrint("Password: $_password");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RootApp()));
              },
              child: const Text('Sign in'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignupPage()));
                    },
                    child: const Text("Sign up"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
