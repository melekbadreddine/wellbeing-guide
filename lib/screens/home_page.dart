import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/doctor_item.dart';
import '../widgets/specialist_item.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            icon: Icon(
              Icons.search,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle notification icon tap
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: Colors.black54,
            ),
          ),
        ],
        title: Row(
          children: [
            Text(
              'Salut, ',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              widget.username, // Display the username
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
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
              Icons.notifications_none_outlined,
              color: Colors.black54,
            ),
            label: '',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 223, 200, 228),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/surgeon.png",
                      width: 92,
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "How do you feel?",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          width: 120,
                          child: Text(
                            "Fill out your medical right now",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 35,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: const Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 16),
                height: 64,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(95, 179, 173, 173),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                      size: 32,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "How can we help you?",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SpecialistItem(
                      imagePath: "assets/images/clean.png",
                      imageName: "Dentist",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SpecialistItem(
                      imagePath: "assets/images/knife.png",
                      imageName: "Surgeon",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SpecialistItem(
                      imagePath: "assets/images/lungs.png",
                      imageName: "Therapy",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SpecialistItem(
                      imagePath: "assets/images/hormones.png",
                      imageName: "Physiologist",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Doctor list",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    DoctorItem(
                      image: "assets/images/1.png",
                      name: "Nycta Gina",
                      specialist: "Pediatrician",
                    ),
                    DoctorItem(
                      image: "assets/images/3.png",
                      name: "Reisa Broto Asmoro",
                      specialist: "Surgeon",
                    ),
                    DoctorItem(
                      image: "assets/images/2.png",
                      name: "Indah Kusumaningrum",
                      specialist: "Odontologist",
                    ),
                    DoctorItem(
                      image: "assets/images/4.png",
                      name: "Mesty Ariotedjo",
                      specialist: "Ophtamologist",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
