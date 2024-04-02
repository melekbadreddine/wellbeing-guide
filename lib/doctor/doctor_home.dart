import 'package:CareCompanion/authentication/login.dart';
import 'package:CareCompanion/doctor/appointment.dart';
import 'package:CareCompanion/doctor/patients_list.dart';
import 'package:CareCompanion/widgets/doctor_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _patientList = [];

  @override
  void initState() {
    super.initState();
    _fetchPatientList();
  }

  Future<void> _fetchPatientList() async {
    String? currentUserId = _auth.currentUser?.uid;
    if (currentUserId != null) {
      DocumentSnapshot<Map<String, dynamic>> doctorDoc =
          await _firestore.collection('doctors').doc(currentUserId).get();
      if (doctorDoc.exists) {
        List<dynamic> patientList = doctorDoc.data()!['patient_list'];
        setState(() {
          _patientList = patientList.cast<String>();
        });
      }
    }
  }

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
        },
      ),
      ListTile(
        leading: Icon(Icons.event),
        title: Text('Appointments'),
        onTap: () {
          // Navigate to Calendar page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Calendar()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.notifications),
        title: Text('Notifications'),
        onTap: () {
          // Navigate to Notifications page
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
          
          GestureDetector( // Wrap ListTile with GestureDetector
            onTap: () {
              // Navigate to PatientsList page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientsList()),
              );
            },
            child: ListTile(
              title: Text('Patient profiles'),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.add),
              ),
              ..._patientList.map((patientId) => FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: _firestore.collection('user_info').doc(patientId).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    String avatarUrl = snapshot.data!.data()!['avatarUrl'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(avatarUrl),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              )).toList(),
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
