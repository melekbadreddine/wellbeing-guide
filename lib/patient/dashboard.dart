import 'package:CareCompanion/patient/home_page.dart';
import 'package:CareCompanion/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:CareCompanion/patient/songboard.dart';
import '../widgets/meditation_card.dart';
import '../utils/utils.dart';
import '../utils/assets.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tableau de bord des exercices',
          style: TextStyle(
            color: Colors.white, // Change text color to cyan
          ),
        ),
        backgroundColor: Colors.teal[300],
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                  children: [
                    MeditationCard(
                      title: kMeditateTitle,
                      description: kMeditateSubtitle,
                      image: kMeditateImageSource,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongBoard(
                              musicName: kMeditateTitle,
                              imageSource: kMeditateImageSource,
                              musicSource: kMeditateMusicSource,
                            ),
                          ),
                        );
                      },
                    ),
                    MeditationCard(
                      title: kRelaxTitle,
                      description: kRelaxSubtitle,
                      image: kRelaxImageSource,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongBoard(
                              musicName: kRelaxTitle,
                              imageSource: kRelaxImageSource,
                              musicSource: kRelaxMusicSource,
                            ),
                          ),
                        );
                      },
                    ),
                    MeditationCard(
                      title: kBrainTitle,
                      description: kBrainSubtitle,
                      image: kBrainImageSource,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongBoard(
                              musicName: kBrainTitle,
                              imageSource: kBrainImageSource,
                              musicSource: kBrainMusicSource,
                            ),
                          ),
                        );
                      },
                    ),
                    MeditationCard(
                      title: kStudyTitle,
                      description: kStudySubtitle,
                      image: kStudyImageSource,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongBoard(
                              musicName: kStudyTitle,
                              imageSource: kStudyImageSource,
                              musicSource: kStudyMusicSource,
                            ),
                          ),
                        );
                      },
                    ),
                    MeditationCard(
                      title: kSleepTitle,
                      description: kSleepSubtitle,
                      image: kSleepImageSource,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongBoard(
                              musicName: kSleepTitle,
                              imageSource: kSleepImageSource,
                              musicSource: kSleepMusicSource,
                            ),
                          ),
                        );
                      },
                    ),
                    MeditationCard(
                      title: kFocusTitle,
                      description: kFocusSubtitle,
                      image: kFocusImageSource,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SongBoard(
                              musicName: kFocusTitle,
                              imageSource: kFocusImageSource,
                              musicSource: kFocusMusicSource,
                            ),
                          ),
                        );
                      },
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
