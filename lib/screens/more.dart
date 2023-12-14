import 'package:CareCompanion/screens/registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // After signing out, navigate to the registration page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
    } catch (e) {
      print('Error signing out: $e');
      // Handle error if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // Change icon color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to ProfilePage
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('Profile'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to ParametresPage
                Navigator.pushNamed(context, '/parametres');
              },
              child: Text('Paramètres'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform sign out
                _signOut(context);
              },
              child: Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
