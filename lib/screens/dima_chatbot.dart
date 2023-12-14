import 'package:CareCompanion/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';

class DimaChat extends StatefulWidget {
  const DimaChat({super.key});

  @override
  State<DimaChat> createState() => _DimaChatState();
}

class _DimaChatState extends State<DimaChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appBackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: Row(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 3, 0, 0),
                        child: Container(
                            //width: MediaQuery.of(context).size.width * 0.28,
                            child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 15, 0, 0),
                              child: Container(
                                child: const CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.lightGreen,
                                  child: CircleAvatar(
                                    foregroundImage: AssetImage(
                                        'assets/images/dimaHeadshot.png'),
                                    radius: 70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                        child: Container(
                          child: IconButton(
                            icon: const Icon(Icons.settings_outlined),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const SettingsDialog();
                                  });
                              debugPrint('Settings tapped.');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text('Dima',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              wordSpacing: 2,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            elevation: 0,
                          ),
                          child: const Text('Assisted Living'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            elevation: 0,
                          ),
                          child: const Text('Transitional Care'),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 270,
                          width: 318,
                          //width: MediaQuery.of(context).size.width * 0.8,
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 0),
                                child: Text(
                                  'Meet Dima, a Lebanese-American immigrant living with symptoms of both Lewy Body Dementia and Parkinson’s Disease as she transitions from life at home to a residential community. \n\nThrough her experience, the learner will be able to identify the differing symptoms of these two conditions and how to manage care as symptoms evolve.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    letterSpacing: .3,
                                    wordSpacing: 1.5,
                                  ),
                                  textAlign: TextAlign.left,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 40),
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    tooltip: 'Increment',
                    elevation: 0,
                    label: const Text('Coming soon'),
                    icon: const Icon(Icons.calendar_month_outlined),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
