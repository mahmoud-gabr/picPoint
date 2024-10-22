import 'package:flutter/material.dart';
import 'package:pic_point/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pic_point/widgets/deafult_elevated_botton.dart'; // Import your button widget

class PlaceDetailsScreen extends StatefulWidget {
  static const String id = '/PlaceDetailsScreen';

  const PlaceDetailsScreen({super.key});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  final Map<String, String> place = {
    'name': 'Building A',
    'details': 'Main building, floor 1',
    'image': 'https://via.placeholder.com/200', // Replace with actual image URL
    'location': 'Kuwait University, Building A',
  };

  final List<String> comments = [
    'Great place!',
    'Needs more signs for directions.',
    'Very clean and organized.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place['name'] ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image display
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                place['image'] ?? '',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Place name and details
            Text(
              place['name'] ?? '',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              place['details'] ?? '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    color: AppTheme.black,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 16),

            // "View on Maps" button
            TextButton.icon(
              onPressed: () async {
                final Uri url = Uri.parse(
                    'https://www.google.com/maps/search/?api=1&query=${place['location']}');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text('View on Maps'),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.grey.withOpacity(.2),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      comments[index],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppTheme.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Add comment section
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Submit comment button
            DeafaultElevetedBotton(
              label: 'Submit',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
