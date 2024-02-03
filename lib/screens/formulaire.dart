import 'package:CareCompanion/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  Map<String, String?> formData = {};
  int anxietyScore = 0;
  int depressionScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استبيان HAD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Text(
                'الرجاء الإجابة على الأسئلة التالية استنادًا إلى كيف كنت تشعر في الأسبوع الماضي.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بتوتر أو إجهاد خلال الأسبوع الماضي؟', 'anxiety',
                  examples: ['ضغوط العمل', 'القلق بشأن الأحداث القادمة']),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت ببطء في التصرفات أو الحركات؟', 'depression',
                  examples: ['الشعور بالإرهاق', 'التفكير البطيء']),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بقلق أو هموم خلال الأسبوع الماضي؟', 'worry_anxiety',
                  examples: ['القلق بشأن الصحة', 'القلق بشأن المستقبل']),
              const SizedBox(height: 20),
              buildDropdown('هل شعرت بقلق زائد أو هلع خلال الأسبوع الماضي؟',
                  'panic_anxiety',
                  examples: ['الهلع الشديد', 'الشعور بفقدان السيطرة']),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت برغبة في البكاء خلال الأسبوع الماضي؟', 'cry',
                  examples: [
                    'الشعور بالضعف العاطفي',
                    'الرغبة في التخلص من الضغوط'
                  ]),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بتوتر عصبي خلال الأسبوع الماضي؟', 'nervous_tension',
                  examples: ['التوتر الشديد', 'الشعور بالتجاعيد العصبية']),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بالهم والتوتر خلال الأسبوع الماضي؟', 'panic',
                  examples: ['الشعور بالتوتر العصبي', 'الهم والقلق']),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بالكآبة خلال الأسبوع الماضي؟', 'mood_depressed',
                  examples: ['الشعور بالحزن', 'التشاؤم بشكل عام']),
              const SizedBox(height: 20),
              buildDropdown('هل شعرت بالإرهاق البدني خلال الأسبوع الماضي؟',
                  'physical_fatigue',
                  examples: ['الإرهاق العضلي', 'الشعور بالتعب الشديد']),
              const SizedBox(height: 20),
              buildDropdown('هل شعرت بالإرهاق النفسي خلال الأسبوع الماضي؟',
                  'mental_fatigue',
                  examples: ['التعب العقلي', 'صعوبة التركيز']),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بصعوبة في الاستمتاع بالأشياء خلال الأسبوع الماضي؟',
                  'enjoyment_difficulty',
                  examples: [
                    'فقدان الاهتمام بالهوايات',
                    'عدم القدرة على الاستمتاع بالأنشطة'
                  ]),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بالتوجس خلال الأسبوع الماضي؟', 'apprehension',
                  examples: ['الشعور بالتوتر المستمر', 'القلق بشكل مفرط']),
              const SizedBox(height: 20),
              buildDropdown(
                  'هل شعرت بالهلع خلال الأسبوع الماضي؟', 'panic_attack',
                  examples: ['الهلع الشديد', 'الشعور بالخوف الشديد']),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  print('Form Data: $formData');
                  calculateScores();
                  print('Anxiety Score: $anxietyScore');
                  print('Depression Score: $depressionScore');
                  setState(() {});
                  await saveFormDataToFirestore();
                },
                child: const Text('إرسال'),
              ),
              const SizedBox(height: 20),
              Text(
                'تفسير النتائج:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'نقاط التوتر: $anxietyScore',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'نقاط الاكتئاب: $depressionScore',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'تفسير نقاط التوتر:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                getInterpretation(anxietyScore),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'تفسير نقاط الاكتئاب:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                getInterpretation(depressionScore),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String question, String fieldName,
      {List<String> examples = const []}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        if (examples.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'أمثلة: ${examples.join(", ")}',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        DropdownButton<String>(
          value: formData[fieldName],
          onChanged: (String? value) {
            setState(() {
              formData[fieldName] = value;
            });
          },
          items: [
            DropdownMenuItem(
              value: 'على الإطلاق لا',
              child: Text('على الإطلاق لا'),
            ),
            DropdownMenuItem(
              value: 'أحياناً',
              child: Text('أحياناً'),
            ),
            DropdownMenuItem(
              value: 'غالباً',
              child: Text('غالباً'),
            ),
            DropdownMenuItem(
              value: 'معظم الوقت',
              child: Text('معظم الوقت'),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void calculateScores() {
    int anxiety = 0;
    int depression = 0;

    formData.forEach((key, value) {
      if (key == 'anxiety' ||
          key == 'worry_anxiety' ||
          key == 'panic_anxiety' ||
          key == 'nervous_tension' ||
          key == 'panic' ||
          key == 'apprehension' ||
          key == 'panic_attack') {
        anxiety += getScore(value);
      } else if (key == 'depression' ||
          key == 'cry' ||
          key == 'mood_depressed' ||
          key == 'physical_fatigue' ||
          key == 'mental_fatigue' ||
          key == 'enjoyment_difficulty') {
        depression += getScore(value);
      }
    });

    anxietyScore = anxiety;
    depressionScore = depression;
  }

  int getScore(String? value) {
    if (value == 'على الإطلاق لا') {
      return 0;
    } else if (value == 'أحياناً') {
      return 1;
    } else if (value == 'غالباً') {
      return 2;
    } else if (value == 'معظم الوقت') {
      return 3;
    } else {
      return 0; // Default to 0 if the value is not recognized
    }
  }

  String getInterpretation(int score) {
    if (score <= 7) {
      return 'مستوى منخفض من الاضطراب';
    } else if (score >= 8 && score <= 10) {
      return 'مستوى متوسط من الاضطراب';
    } else {
      return 'مستوى عالٍ من الاضطراب';
    }
  }
      Future<void> saveFormDataToFirestore() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Retrieve user information from the "user_info" collection
        DocumentSnapshot userInfoDoc = await FirebaseFirestore.instance
            .collection('user_info')
            .doc(currentUser.uid)
            .get();

        if (userInfoDoc.exists) {
          String userName = userInfoDoc.get('name');
          String familyName = userInfoDoc.get('family_name');

          // Save interpretation data to Firestore
          CollectionReference userCollection =
              FirebaseFirestore.instance.collection('user_form');

          DocumentReference userDoc = userCollection.doc(currentUser.uid);

          await userDoc.set({
            'userId': currentUser.uid,
            'userName': userName,
            'familyName': familyName,
            'anxietyInterpretation': getInterpretation(anxietyScore),
            'depressionInterpretation': getInterpretation(depressionScore),
            'timestamp': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          print('Interpretation data saved to Firestore for user: ${currentUser.uid}');
          // Navigate to the HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          print('Error: User information not found for user ID: ${currentUser.uid}');
        }
      } else {
        print('Error: Current user is null');
      }
    } catch (e) {
      print('Error saving interpretation data to Firestore: $e');
    }
  }
}
