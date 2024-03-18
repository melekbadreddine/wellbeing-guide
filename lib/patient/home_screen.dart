import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(width: 8.0),
            Text('Welcome back, Jessica'),
            Spacer(),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Upcoming consultations'),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Text('08:45pm\nAug 14'),
            title: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/patient1.jpg'),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Micahael Simpson',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Join the call'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/patient2.jpg'),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Patient profiles'),
            trailing: Icon(Icons.arrow_forward),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.add),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient3.jpg'),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient4.jpg'),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient5.jpg'),
              ),
              SizedBox(width: 8.0),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/patient6.jpg'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Last enquiries'),
              ElevatedButton(
                onPressed: () {},
                child: Text('Reports'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}