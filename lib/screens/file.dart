import 'package:CareCompanion/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  _FilePageState createState() => _FilePageState();
}

enum Gender { male, female }

class _FilePageState extends State<FilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController familyNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController diseasesController = TextEditingController();
  final TextEditingController medicinesController = TextEditingController();

  Gender? selectedGender;
  bool hasChromaticDisease = false;
  bool isTakingMedicine = false;
  DateTime? selectedDate; // Added a DateTime variable to store selected date
  String? selectedState; // Added a variable to store selected state
  List<String> tunisiaStates = [
    'Ariana',
    'Béja',
    'Ben Arous',
    'Bizerte',
    'Gabès',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kébili',
    'Le Kef',
    'Mahdia',
    'La Manouba',
    'Médenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ];



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Set the selected date
        if (selectedDate != null) {
          final DateTime now = DateTime.now();
          final int age = now.year - selectedDate!.year;
          ageController.text = age.toString(); // Display the calculated age
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations utilisateur'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/appBackground.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: familyNameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nom de famille',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre nom de famille';
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                controller: ageController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                ),
                validator: (value) {
                  if (selectedDate == null) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
              ),

              // 'Adresse' TextFormField with location icon on the right side
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: InputDecoration(
                  labelText: 'Adresse',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: Icon(Icons.location_on, color: Colors.white),
                ),
                items: tunisiaStates.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedState = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your state';
                  }
                  return null;
                },
              ),

              const ListTile(
                title: Text('Genre', style: TextStyle(color: Colors.white)),
                dense: true,
              ),
              RadioListTile<Gender>(
                title: const Text('Masculin', style: TextStyle(color: Colors.white)),
                value: Gender.male,
                groupValue: selectedGender,
                onChanged: (Gender? value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              RadioListTile<Gender>(
                title: const Text('Féminin', style: TextStyle(color: Colors.white)),
                value: Gender.female,
                groupValue: selectedGender,
                onChanged: (Gender? value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text(
                  'Avez-vous des maladies chroniques ?',
                  style: TextStyle(color: Colors.white),
                ),
                value: hasChromaticDisease,
                onChanged: (bool? value) {
                  setState(() {
                    hasChromaticDisease = value!;
                  });
                },
              ),
              if (hasChromaticDisease)
                TextFormField(
                  controller: diseasesController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Maladies chromatiques',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              CheckboxListTile(
                title: const Text(
                  'Prenez-vous des médicaments ?',
                  style: TextStyle(color: Colors.white),
                ),
                value: isTakingMedicine,
                onChanged: (bool? value) {
                  setState(() {
                    isTakingMedicine = value!;
                  });
                },
              ),
              if (isTakingMedicine)
                TextFormField(
                  controller: medicinesController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Médicaments',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('user_info').add({
          'name': nameController.text,
          'family_name': familyNameController.text,
          'age': int.tryParse(ageController.text) ?? 0,
          'gender': selectedGender.toString().split('.').last,
          'has_chromatic_disease': hasChromaticDisease,
          'chromatic_diseases': hasChromaticDisease ? diseasesController.text : null,
          'is_taking_medicine': isTakingMedicine,
          'medicines': isTakingMedicine ? medicinesController.text : null,
        });

        // Clear the text fields after submission
        nameController.clear();
        familyNameController.clear();
        ageController.clear();
        diseasesController.clear();
        medicinesController.clear();

        setState(() {
          selectedGender = null;
          hasChromaticDisease = false;
          isTakingMedicine = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage(username: '',)), // Replace with your HomePage widget
        );
        
      } catch (e) {
        print('Error submitting form: $e');
      }
    }
  }
}
