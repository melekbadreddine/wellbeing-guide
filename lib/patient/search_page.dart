import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _searchResults;

  @override
  void initState() {
    super.initState();
    // Initialize _searchResults to an empty stream when the widget is created
    _searchResults = _searchDoctors('');
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _searchDoctors(String query) {
    CollectionReference<Map<String, dynamic>> doctorsCollection =
        FirebaseFirestore.instance.collection('doctors');

    // Apply the search query if available
    if (query.isNotEmpty) {
      print('Search Query: $query');

      // Use 'orderBy' for case-insensitive search on the 'name' field
      return doctorsCollection.orderBy('name').snapshots();
    }

    // Return all doctors if no search query
    return doctorsCollection.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search doctors...',
          ),
          onChanged: (query) {
            setState(() {
              _searchResults = _searchDoctors(query);
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No results found.'));
          }

          // Filter the data locally based on the search query
          var filteredDoctors = snapshot.data!.docs.where((doctor) {
            var name = doctor['name']?.toString().toLowerCase() ?? '';
            return name.contains(_searchController.text.toLowerCase());
          }).toList();

          return ListView.builder(
            itemCount: filteredDoctors.length,
            itemBuilder: (context, index) {
              var doctor = filteredDoctors[index];
              var name = doctor['name']?.toString() ?? 'No Name';

              return Card(
                elevation: 3, // Adjust the elevation for the shadow effect
                margin: EdgeInsets.all(8), // Add margin for spacing
                child: ListTile(
                  title: Text(name),
                  // Add more details or actions if needed
                ),
              );
            },
          );
        },
      ),
    );
  }
}
