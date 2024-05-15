import 'package:app/loginPage.dart';
import 'package:app/rootApp.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  String _name = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  _name = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  _username = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
             const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  _password = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  _confirmPassword = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Check if passwords match
                  if (_password != _confirmPassword) {
                    // Show an error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Passwords do not match.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RootApp()));
                  }
                },
                child: const Text('Sign up'),
                
              ),
              const SizedBox(height: 20),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    child: const Text("Sign in"))
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}
