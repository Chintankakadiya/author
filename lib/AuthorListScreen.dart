import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'authorModel.dart';
import 'authorRegistrationScreen.dart';

class AuthorListScreen extends StatelessWidget {
  const AuthorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registered Authors"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('authors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Author> authors = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Author(data['name'], data['bookName']);
          }).toList();
          return ListView.builder(
            itemCount: authors.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(authors[index].name),
                subtitle: Text(authors[index].bookName),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthorRegistrationScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
