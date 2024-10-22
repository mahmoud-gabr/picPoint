import 'package:flutter/material.dart';
import 'package:pic_point/admin/home/place_details_screen.dart';
import 'package:pic_point/app_theme.dart';
import 'package:pic_point/widgets/deafult_elevated_botton.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> places = [
    {
      'name': 'Building A',
      'details': 'Main building, floor 1',
      'location': 'Kuwait University, Building A',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV6y5vF1OvsPHX0d1nuVo0bi8IT8Yf_20PKw&s' // Replace with actual image URL
    },
    {
      'name': 'Room 101',
      'details': 'Located in Building B, ground floor',
      'location': 'Kuwait University, Building B',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV6y5vF1OvsPHX0d1nuVo0bi8IT8Yf_20PKw&s' // Replace with actual image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      places[index]['image'] ?? '',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    places[index]['name'] ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    places[index]['details'] ?? '',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppTheme.black,
                        ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      final location = places[index]['location'] ?? '';
                      final Uri url = Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=$location');
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: const Text('View on Maps'),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Add comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DeafaultElevetedBotton(label: 'Submit', onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PlaceDetailsScreen.id);
                      },
                      child: const Text('View Comments'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
