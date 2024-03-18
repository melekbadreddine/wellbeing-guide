import 'package:CareCompanion/widgets/custom_app_bar.dart';
import 'package:CareCompanion/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';


class DoctorInterface extends StatefulWidget {
  const DoctorInterface({Key? key}) : super(key: key);

  @override
  State<DoctorInterface> createState() => _HomePageState();
}

class _HomePageState extends State<DoctorInterface> {

  String? username; // Variable to store the username
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchUsername(); // Fetch the username when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        fetchUsername: fetchUsername,
        onSearchPressed: () {
          // Handle search icon tap
        },
        onNotificationPressed: () {
          // Handle notification icon tap
        }, 
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}