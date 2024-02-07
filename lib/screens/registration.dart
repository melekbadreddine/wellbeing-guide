import 'package:CareCompanion/screens/reset_password.dart';
import 'package:CareCompanion/screens/home_page.dart';
import 'package:CareCompanion/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:CareCompanion/services/authentication.dart';
import 'file.dart'; // Import the file.dart containing FilePage
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool rememberMe = false; // New boolean to store the checkbox value
  bool _obscureText = true;
  bool isPasswordNotEmpty = false;

  @override
  void initState() {
    super.initState();
      // Load rememberMe value when the page initializes
    loadRememberMe();
  }

  
  Future<void> loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        // If 'rememberMe' is true, load saved email and password
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> saveRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      // If 'rememberMe' is true, save email and password
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    } else {
      // If 'rememberMe' is false, clear saved email and password
      prefs.remove('email');
      prefs.remove('password');
    }
    // Save 'rememberMe' value
    prefs.setBool('rememberMe', rememberMe);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerAndSendVerificationEmail() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Vérification de l\'e-mail'),
          content: const Text(
              'Veuillez vérifier votre e-mail et valider votre compte pour continuer.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkIfUserFilledForm(String userId) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('user_info');

      DocumentSnapshot userDoc =
          await userCollection.doc(userId).get();

      return userDoc.exists; // Return true if the document exists (form filled)
    } catch (e) {
      print('Error checking user form: $e');
      return false;
    }
  }

  Future<void> _signInAfterVerification() async {
  try {
    UserCredential signInCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (signInCredential.user != null && signInCredential.user!.emailVerified) {
      bool isFormFilled = await checkIfUserFilledForm(signInCredential.user!.uid);

      await saveRememberMe();

      if (isFormFilled) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ).then((_) {
          emailController.clear();
          passwordController.clear();
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FilePage()), // Replace with your form page
        ).then((_) {
          emailController.clear();
          passwordController.clear();
        });
      }
    } else {
      // Show the email not verified dialog
      if (!signInCredential.user!.emailVerified) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Email Not Verified'),
              content: const Text('Please verify your email to log in.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show an alert for incorrect email or password
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('The email or password you entered is incorrect.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  } on FirebaseAuthException catch (e) {
    // Show an alert for other FirebaseAuthException errors
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Error signing in: $e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print(e);
  }
}







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        color: Colors.teal[300], // Set your desired color here
        ),
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Connexion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.black),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Veuillez entrer un e-mail valide';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white, // Background color of the input field
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: 'Entrez votre e-mail',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    setState(() {
                      isPasswordNotEmpty = value.isNotEmpty;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Le mot de passe doit comporter au moins 6 caractères';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: 'Entrez votre mot de passe',
                    suffixIcon: isPasswordNotEmpty
                        ? IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        : null, // If password is empty, hide the icon
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                          checkColor: Colors.white,
                        ),
                        Text(
                          'Souvenir de moi',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10), // Ajout d'un espace entre les deux éléments
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'Mot de passe oubliée ?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                MaterialButton(
                  height: 40,
                  shape: const StadiumBorder(),
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Se Connecter',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await _signInAfterVerification();
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: const Text(
                    "Créer un compte",
                    style: TextStyle(color: Colors.black),
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