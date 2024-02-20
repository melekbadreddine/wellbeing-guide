import 'package:CareCompanion/screens/RelaxationExerciseScreen.dart';
import 'package:CareCompanion/screens/chatbot.dart';
import 'package:CareCompanion/widgets/custom_app_bar.dart';
import 'package:CareCompanion/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/doctor_item.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _HomePageState();
}

class MyColors {
  static int header01 = 0xff151a56;
  static int primary = 0xff575de3;
  static int purple01 = 0xff918fa5;
  static int purple02 = 0xff6b6e97;
  static int yellow01 = 0xffeaa63b;
  static int yellow02 = 0xfff29b2b;
  static int bg = 0xfff5f3fe;
  static int bg01 = 0xff6f75e1;
  static int bg02 = 0xffc3c5f8;
  static int bg03 = 0xffe8eafe;
  static int text01 = 0xffbec2fc;
  static int grey01 = 0xffe9ebf0;
  static int grey02 = 0xff9796af;
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan[300],
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Lundi, Juin 29',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.cyan[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/1.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dr.Najla Halouani',
                                style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,)
                                ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Psychiatre',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.cyan[300],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.cyan[300],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

class _HomePageState extends State<DoctorPage> {

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  color: Colors.cyan[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/chatbot.png",
                      width: 92,
                      height: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Comment vous sentez?",
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
                            "parlez avec notre chatbot maintenant",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Chatbot()),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 35,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.cyan[300],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Center(
                              child: Text(
                                "Commencer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Liste des exercices",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Voir tous",
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
                height: 205,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
  ExerciseItem(
    image: "assets/images/breathing.png",
    title: "Respiration",
    description: "Pratiquez des respirations lentes.",
  ),
  ExerciseItem(
    image: "assets/images/lotus-position.png",
    title: "Méditation",
    description: "Focalisez l'esprit, détendez-vous.",
  ),
  ExerciseItem(
    image: "assets/images/exercising.png",
    title: "Étirements",
    description: "Étirements doux pour la détente.",
  ),
  ExerciseItem(
    image: "assets/images/yoga.png",
    title: "Yoga",
    description: "Pratiquez des postures apaisantes.",
  ),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RelaxationExerciseScreen()),
    );
  },
  child: ExerciseItem(
    image: "assets/images/breathing.png",
    title: "Relaxation",
    description: "Détendez-vous avec cet exercice.",
  ),
)
],
  ),
),
              const SizedBox(height: 12),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Rendez-vous",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppointmentCard(onTap: () {  },)
            ],
          ),
        ),
      ),
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