import 'package:flutter/material.dart';
import 'package:pic_point/user/home/place_details_screen.dart';
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
      'name': 'مبنى A',
      'details': 'المبنى الرئيسي، الطابق الأول',
      'location': 'جامعة الكويت، مبنى A',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV6y5vF1OvsPHX0d1nuVo0bi8IT8Yf_20PKw&s' 
    },
    {
      'name': 'غرفة 101',
      'details': 'تقع في مبنى B، الطابق الأرضي',
      'location': 'جامعة الكويت، مبنى B',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV6y5vF1OvsPHX0d1nuVo0bi8IT8Yf_20PKw&s' // Replace with actual image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
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
                          throw Exception('تعذر فتح الرابط $url');
                        }
                      },
                      child: const Text('عرض على الخريطة'),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'أضف تعليقًا...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        DeafaultElevetedBotton(label: 'إرسال', onPressed: () {}),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PlaceDetailsScreen.id,
                          arguments: places[index]['image'],
                          );
                        },
                        child: const Text('عرض التعليقات'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
