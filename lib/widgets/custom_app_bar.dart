import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<String?> fetchUsername() async {
    // Get the current user ID
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      // Retrieve the user's data from Firestore using the userId
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('user_info').doc(userId).get();

      // Return the retrieved username
      return userData['name'] ?? 'Loading...';
    }

    // Return 'Loading...' if user ID is null
    return 'Loading...';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: fetchUsername(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage("assets/images/pm.png"),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Handle search icon tap
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle notification icon tap
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black54,
                ),
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Salut,",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const SizedBox(
                      height: 4,
                      child: Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                // Add other widgets if needed in the Row
              ],
            ),
          );
        } else {
          return AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage("assets/images/pm.png"),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Handle search icon tap
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle notification icon tap
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black54,
                ),
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Salut,",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 4,
                      child: Text(
                        snapshot.data ?? 'Loading...',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                // Add other widgets if needed in the Row
              ],
            ),
          );
        }
      },
    );
  }
}
