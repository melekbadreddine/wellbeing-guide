import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:CareCompanion/patient/search_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart' as ImageSource;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Future<String?> Function() fetchUsername;
  final Function()? onSearchPressed;
  final Function()? onNotificationPressed;

  const CustomAppBar({
    Key? key,
    required this.fetchUsername,
    this.onSearchPressed,
    this.onNotificationPressed,
  }) : super(key: key);

  void _onSearchPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  Future<File?> pickImage(ImageSource.ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadImageToFirebaseStorage(
      File imageFile, String userId) async {
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('patient_avatar/$userId');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> deleteOldImageFromFirebaseStorage(String userId) async {
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('patient_avatar/$userId');
      await storageRef.delete();
    } catch (e) {
      print('Error deleting old image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            ImageSource.ImageSource source = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Select Image Source'),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.ImageSource.camera),
                    child: Text('Camera'),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(context, ImageSource.ImageSource.gallery),
                    child: Text('Gallery'),
                  ),
                ],
              ),
            );

            if (source != null) {
              File? imageFile = await pickImage(source);
              if (imageFile != null) {
                User? currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser != null) {
                  String? userId = currentUser.uid;
                  await deleteOldImageFromFirebaseStorage(userId);
                  String? downloadUrl =
                      await uploadImageToFirebaseStorage(imageFile, userId);
                  if (downloadUrl != null) {
                    // Update the user's avatar URL in Firestore
                    await FirebaseFirestore.instance
                        .collection('user_info')
                        .doc(userId)
                        .update({'avatarUrl': downloadUrl});
                  }
                }
              }
            }
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _onSearchPressed(context),
          icon: const Icon(
            Icons.search,
            color: Colors.black54,
          ),
        ),
        IconButton(
          onPressed: onNotificationPressed,
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
              FutureBuilder<String?>(
                future: fetchUsername(),
                builder: (context, usernameSnapshot) {
                  return Text(
                    usernameSnapshot.data ?? 'Loading...',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ],
          ),
          // Add other widgets if needed in the Row
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Future<String?> fetchUsername() async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userInfoDoc =
          await FirebaseFirestore.instance
              .collection('user_info')
              .doc(currentUser.uid)
              .get();
      if (userInfoDoc.exists) {
        // Check if the document exists
        var username = userInfoDoc['name'] ?? '';
        var familyName = userInfoDoc['family_name'] ?? '';

        if (username.isNotEmpty && familyName.isNotEmpty) {
          return '$username $familyName';
        }
      }
    }

    return 'Loading...';
  } catch (e) {
    print('Error fetching username: $e');
    return 'Error';
  }
}