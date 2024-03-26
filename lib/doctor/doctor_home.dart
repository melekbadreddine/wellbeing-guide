import 'package:CareCompanion/authentication/login.dart';
import 'package:CareCompanion/patient/notifications.dart';
import 'package:CareCompanion/patient/search_page.dart';
import 'package:CareCompanion/widgets/doctor_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

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

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DoctorAppBar(
        fetchUsername: fetchUsername,
        onSearchPressed: () {
          // Handle search icon tap
        },
        onNotificationPressed: () {
          // Handle notification icon tap
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                // Navigate to Profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Recherche'),
              onTap: () {
                // Navigate to Search page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {
                // Navigate to Notifications page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifications()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Déconnecter'),
              onTap: () {
                    // Perform sign out
                    _signOut(context);
                  },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Upcoming consultations'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Text('08:45pm\nAug 14'),
            title: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/patient1.jpg'),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Micahael Simpson',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Join the call'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
              ],
            ),
          ),
          ListTile(
            title: Text('Patient profiles'),
            trailing: Icon(Icons.arrow_forward),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.add),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient3.jpg'),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient4.jpg'),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient5.jpg'),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient6.jpg'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Last enquiries'),
              ElevatedButton(
                onPressed: () {},
                child: Text('Reports'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
