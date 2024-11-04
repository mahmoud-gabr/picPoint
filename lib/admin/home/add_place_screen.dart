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
    final selectedLocation = 'جامعة الكويت';
    setState(() {
      _location = selectedLocation;
    });
  }

  void _savePlace() {
    print('اسم المكان: ${_nameController.text}');
    print('التفاصيل: ${_detailsController.text}');
    print('مسار الصورة: $_imagePath');
    print('الموقع: $_location');

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة مكان'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const Spacer(flex: 1),
              DeafaultTextFormField(
                controller: _nameController,
                label: 'اسم المكان',
              ),
              const SizedBox(height: 16),
              DeafaultTextFormField(
                controller: _detailsController,
                label: 'التفاصيل',
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
                      ? const Text('اضغط لاختيار صورة')
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
                    _location ?? 'اضغط لاختيار موقع',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 140,
                child: DeafaultElevetedBotton(
                  onPressed: _savePlace,
                  label: 'حفظ المكان',
                ),
              ),
              const Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}
