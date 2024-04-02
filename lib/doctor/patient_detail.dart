import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientProfileScreen extends StatefulWidget {
  final String patientId;

  const PatientProfileScreen({Key? key, required this.patientId})
      : super(key: key);

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  Map<String, dynamic> patientInfo = {};
  Map<String, dynamic> formData = {};

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }

  Future<void> fetchPatientData() async {
    final patientInfoDoc = await FirebaseFirestore.instance
        .collection('user_info')
        .doc(widget.patientId)
        .get();

    final formDataDoc = await FirebaseFirestore.instance
        .collection('user_form')
        .doc(widget.patientId)
        .get();

    if (patientInfoDoc.exists && formDataDoc.exists) {
      setState(() {
        patientInfo = patientInfoDoc.data()!;
        formData = formDataDoc.data()!;
      });
    }
  }

  String getGenderString(String gender) {
    switch (gender) {
      case 'male':
        return 'Male';
      case 'female':
        return 'Female';
      default:
        return 'Other';
    }
  }

  String getHasChromaticDiseaseString(bool hasChromaticDisease) {
    return hasChromaticDisease ? 'Yes' : 'No';
  }

  String getIsTakingMedicineString(bool isTakingMedicine) {
    return isTakingMedicine ? 'Yes' : 'No';
  }

  String getSuicidalThoughtsString(String suicidalThoughts) {
    switch (suicidalThoughts) {
      case 'نعم':
        return 'Patient has expressed suicidal thoughts';
      case 'لا':
        return 'Patient has not expressed suicidal thoughts';
      default:
        return 'N/A';
    }
  }

  void navigateToFormHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormHistoryScreen(patientId: widget.patientId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: const Text('Patient Profile'),
      ),
      body: patientInfo.isNotEmpty && formData.isNotEmpty
          ? SingleChildScrollView(
              child: Container(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      ListTile(
                        title: Text(
                          '${patientInfo['name']} ${patientInfo['family_name']}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[800],
                          ),
                        ),
                        subtitle: Text(
                          'Patient ID: ${widget.patientId}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(patientInfo['avatarUrl']),
                        ),
                      ),
                      SizedBox(height: 24),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo[800],
                                ),
                              ),
                              Divider(height: 20, thickness: 1),
                              ListTile(
                                title: Text('Age: ${patientInfo['age']}'),
                                subtitle: Text('Gender: ${getGenderString(patientInfo['gender'])}'),
                              ),
                              ListTile(
                                title: Text('Has Chromatic Disease: ${getHasChromaticDiseaseString(patientInfo['has_chromatic_disease'])}'),
                                subtitle: Text('Taking Medicine: ${getIsTakingMedicineString(patientInfo['is_taking_medicine'])}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'HAD Form Interpretation',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo[800],
                                ),
                              ),
                              Divider(height: 20, thickness: 1),
                              ListTile(
                                title: Text('Anxiety Interpretation: ${formData['anxietyInterpretation']}'),
                                subtitle: Text('Depression Interpretation: ${formData['depressionInterpretation']}'),
                              ),
                              ListTile(
                                title: Text(getSuicidalThoughtsString(formData['suicidalThoughts'])),
                                subtitle: Text('Last Form Submission: ${formData['timestamp'].toDate().toString().split(' ').first}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          onPressed: navigateToFormHistory,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[800],
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'View Form History',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class FormHistoryScreen extends StatelessWidget {
  final String patientId;

  const FormHistoryScreen({Key? key, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement logic to fetch and display form history for the patient
    return Scaffold(
      appBar: AppBar(
        title: Text('Form History'),
      ),
      body: Center(
        child: Text('Form history for patient $patientId'),
      ),
    );
  }
}
