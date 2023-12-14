import 'package:CareCompanion/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

class BeatrizChat extends StatefulWidget {
  const BeatrizChat({super.key});

  @override
  State<BeatrizChat> createState() => _BeatrizChatState();
}

class _BeatrizChatState extends State<BeatrizChat> {
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
                                  backgroundColor: Colors.blue,
                                  child: CircleAvatar(
                                    foregroundImage: AssetImage(
                                        'assets/images/beatrizHeadshot.png'),
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
                        child: Text('Beatriz',
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
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                          child: const Text('Alzheimer\'s'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            elevation: 0,
                          ),
                          child: const Text('Dementia'),
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
                          height: 275,
                          width: 318,
                          //width: MediaQuery.of(context).size.width * 0.8,
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 20, 0),
                                child: Text(
                                  'Meet Beatriz, a middle-aged Latina woman as progressive Alzheimer’s Disease causes changes in her brain. \n\nFrom the onset of symptoms to late stage disease and the transition to residential care, the learner understands the profound effect Alzheimer’s has on daily life, from processing and cognition to relationships and emotional wellbeing.',
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 33),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      try {
                        dynamic conversationObject = {
                          'appId': '10b908ed84a81f3eceb849464c54f0861',
                          'isSingleConversation': false,
                        };
                        dynamic result =
                            await KommunicateFlutterPlugin.buildConversation(
                                conversationObject);
                        print('Conversation builder success :$result');
                      } on Exception catch (e) {
                        print('Conversation builder error occurred :$e');
                      }
                    },
                    tooltip: 'Increment',
                    label: const Text('New conversation'),
                    icon: const Icon(Icons.add),
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
