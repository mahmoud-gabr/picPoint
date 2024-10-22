import 'package:flutter/material.dart';
import 'package:pic_point/admin/home/add_place_screen.dart';
import 'package:pic_point/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomeScreen extends StatefulWidget {
  static String id = '/AdminHomeScreen';
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
          return SizedBox(
            height: 160,
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        places[index]['image'] ?? '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            places[index]['name'] ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            places[index]['details'] ?? '',
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppTheme.grey,
                                ),
                          ),
                          TextButton(
                            onPressed: () async {
                              final url = Uri.parse(
                                  'https://www.google.com/maps/search/?api=1&query=${places[index]['location']}');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Text(
                              'View on Maps',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: AppTheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete, color: AppTheme.red),
                          onPressed: () {},
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AddPlaceScreen.id);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: AppTheme.primary,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPlaceScreen.id);
        },
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
