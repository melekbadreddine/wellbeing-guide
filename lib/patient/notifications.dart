import 'package:CareCompanion/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user_info')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('notifications')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No notifications.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var notificationData = snapshot.data!.docs[index].data() as Map<String, dynamic>; // Explicitly cast to Map<String, dynamic>
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(notificationData['avatarUrl']),
                ),
                title: FutureBuilder<String?>(
                  future: fetchUsername(), // Call fetchUsername from CustomAppBar
                  builder: (context, usernameSnapshot) {
                    return Text(
                      usernameSnapshot.data ?? 'Loading...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                subtitle: notificationData['type'] == 'friend_request'
                    ? Text('Sent you a friend request')
                    : Text('Scheduled an appointment'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle accept action
                      },
                      icon: Icon(Icons.check),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle decline action
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}