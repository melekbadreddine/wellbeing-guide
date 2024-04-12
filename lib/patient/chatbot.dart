import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellbeingGuide/patient/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Chatbot());
}

class Chatbot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bot',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

void sendMessage(String text) async {
  if (text.isEmpty) return;

  try {
    setState(() {
      _messages.insert(0, {'content': text, 'isUserMessage': true, 'shouldAnimate': true});
      _messageController.clear();
    });

    // Fetch current user ID
    String? userId = (_auth.currentUser != null) ? _auth.currentUser?.uid : null;
    if (userId != null) {
      DocumentSnapshot userSnapshot = await _firestore.collection('user_info').doc(userId).get();
      if (userSnapshot.exists) {
        // Access user information here
        Map<String, dynamic> userInfo = userSnapshot.data() as Map<String, dynamic>;
        // Send user information along with the message to Flask server
        await sendToFlask(text, userInfo);
      }
    }
  } catch (e) {
    print('Error in sendMessage: $e');
  }
}


  Future<void> sendToFlask(String text, Object userInfo) async {
    try {
      // Combine user input and user information
      Map<String, dynamic> requestData = {
        'user_input': text,
        'user_info': userInfo,
      };

      var response = await http.post(
        Uri.parse('http://20.19.130.48/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      var jsonResponse = jsonDecode(response.body);

      setState(() {
        _messages.insert(0, {'content': jsonResponse['ai_response'], 'isUserMessage': false, 'shouldAnimate': true});
      });
    } catch (e) {
      print('Error in sendToFlask: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index]['content'];
                final isUserMessage = _messages[index]['isUserMessage'];
                final shouldAnimate = _messages[index]['shouldAnimate'];

                return AnimatedAlign(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  duration: Duration(milliseconds: shouldAnimate ? 500 : 0),
                  curve: shouldAnimate ? Curves.easeInOut : Curves.linear,
                  onEnd: () {
                    setState(() {
                      _messages[index]['shouldAnimate'] = false;
                    });
                  },
                  child: AnimatedContainer(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.teal : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    duration: Duration(milliseconds: shouldAnimate ? 500 : 0),
                    curve: shouldAnimate ? Curves.easeInOut : Curves.linear,
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => sendMessage(_messageController.text),
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}