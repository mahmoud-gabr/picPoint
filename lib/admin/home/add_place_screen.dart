import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_point/widgets/deafult_elevated_botton.dart';
import 'package:pic_point/widgets/deafult_text_form_field.dart';

class AddPlaceScreen extends StatefulWidget {
  static String id = '/AddPlaceScreen';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  String? _imagePath;
  String? _location;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  Future<void> _pickLocation() async {
    final selectedLocation = 'Kuwait University';
    setState(() {
      _location = selectedLocation;
    });
  }

  void _savePlace() {
    // Implement the logic to save the place, for example:
    // - Upload the image to a server or storage
    // - Save the place details to your database (Firebase Realtime Database)
    print('Name: ${_nameController.text}');
    print('Details: ${_detailsController.text}');
    print('Image Path: $_imagePath');
    print('Location: $_location');

    // After saving, you can navigate back or show a success message
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            DeafaultTextFormField(
              controller: _nameController,
              label: 'Place Name',
            ),
            const SizedBox(
              height: 16,
            ),
            DeafaultTextFormField(
              controller: _detailsController,
              label: 'details',
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 150,
                width: double.infinity,
                alignment: Alignment.center,
                child: _imagePath == null
                    ? const Text('Tap to select an image')
                    : Image.file(
                        File(_imagePath!),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickLocation,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _location ?? 'Tap to select a location',
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 140,
              child: DeafaultElevetedBotton(
                onPressed: _savePlace,
                label: 'Save Place',
              ),
            ),
            const Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
