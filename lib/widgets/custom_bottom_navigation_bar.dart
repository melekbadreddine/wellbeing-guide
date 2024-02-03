import 'package:CareCompanion/screens/home_page.dart';
import 'package:CareCompanion/screens/settings.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 24,
      currentIndex: currentIndex,
      onTap: (int index) {
        // Redirect to HomePage() when clicking on the home icon
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
      else if (index == 3) {
          // Navigate to the "More" page when the "More" icon is tapped
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SettingsScreen();
          }));
        } else {
          // Handle navigation for other icons
          onTap(index);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.black54,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month_outlined,
            color: Colors.black54,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble_outline,
            color: Colors.black54,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.more_horiz_outlined,
            color: Colors.black54,
          ),
          label: '',
        ),
      ],
    );
  }
}
