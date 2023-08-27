import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthorRegistrationScreen extends StatefulWidget {
  const AuthorRegistrationScreen({super.key});

  @override
  State<AuthorRegistrationScreen> createState() =>
      _AuthorRegistrationScreenState();
}

class _AuthorRegistrationScreenState extends State<AuthorRegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bookNameController = TextEditingController();
  XFile? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Auto"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _pickedImage == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: 100,
                      )
                    : Image.file(
                        File(_pickedImage!.path),
                        height: 200,
                      ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Author Name',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _bookNameController,
                decoration: InputDecoration(labelText: 'Book Name'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _registerAuthor();
                },
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerAuthor() async {
    String name = _nameController.text;
    String bookName = _bookNameController.text;
    if (name.isNotEmpty && bookName.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('authors')
          .add({'name': name, 'bookName': bookName});
      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = pickedImage;
    });
  }
}
