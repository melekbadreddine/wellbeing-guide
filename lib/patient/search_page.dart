import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _searchResults;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _searchResults = _searchDoctors('');
    _firebaseMessaging.requestPermission();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _searchDoctors(String query) {
    CollectionReference<Map<String, dynamic>> doctorsCollection =
        FirebaseFirestore.instance.collection('doctors');

    if (query.isNotEmpty) {
      return doctorsCollection.orderBy('name').snapshots();
    }

    return doctorsCollection.snapshots();
  }

  Future<void> _requestDoctor(String doctorId) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentReference userInfoRef =
            FirebaseFirestore.instance.collection('user_info').doc(currentUser.uid);
        DocumentReference doctorRef =
            FirebaseFirestore.instance.collection('doctors').doc(doctorId);

        // Update the patient's 'doctor' field
        await userInfoRef.update({'doctor': doctorId});

        // Create a notification in the doctor's 'notifications' collection
        await doctorRef.collection('notifications').doc(currentUser.uid).set({
          'patientId': currentUser.uid,
          'avatarUrl': await _fetchUserAvatarUrl(currentUser.uid),
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Send a notification to the doctor
        String? fcmToken = await _fetchDoctorFCMToken(doctorId);
        if (fcmToken != null) {
          await _firebaseMessaging.sendMessage(
            to: fcmToken,
            data: {
              'title': 'New Doctor Request',
              'body': 'You have a new doctor request from a patient.',
            },
          );
        }

        // Show a success message or navigate to a different screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Doctor request sent successfully.'),
          ),
        );
      }
    } catch (e) {
      print('Error requesting doctor: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending doctor request.'),
        ),
      );
    }
  }

  Future<String?> _fetchUserAvatarUrl(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userInfoDoc =
          await FirebaseFirestore.instance.collection('user_info').doc(userId).get();
      if (userInfoDoc.exists) {
        return userInfoDoc['avatarUrl'] as String?;
      }
    } catch (e) {
      print('Error fetching avatar URL: $e');
    }
    return null;
  }

    Future<String?> _fetchDoctorFCMToken(String doctorId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doctorDoc =
          await FirebaseFirestore.instance.collection('doctors').doc(doctorId).get();
      if (doctorDoc.exists) {
        return doctorDoc['fcmToken'] as String?;
      }
    } catch (e) {
      print('Error fetching FCM token: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Chercher un docteur...',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          onChanged: (query) {
            setState(() {
              _searchResults = _searchDoctors(query);
            });
          },
        ),
        backgroundColor: Colors.teal[300],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No results found.'));
          }

          var filteredDoctors = snapshot.data!.docs.where((doctor) {
            var name = doctor['name']?.toString().toLowerCase() ?? '';
            return name.contains(_searchController.text.toLowerCase());
          }).toList();

          return ListView.builder(
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              var doctor = filteredDoctors[index];
              var name = doctor['name']?.toString() ?? 'No Name';
              var doctorId = doctor.id;

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('../../assets/images/doctor_1.jpg'),
                    radius: 30,
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    'Specialty: ${doctor['specialty'] ?? 'No Specialty'}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _requestDoctor(doctorId);
                    },
                    child: Text('Request'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}