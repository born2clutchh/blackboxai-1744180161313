import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/models/turf.dart';

class TurfListScreen extends ConsumerWidget {
  final List<Turf> turfs = [
    Turf(
      id: '1',
      name: 'Green Field',
      location: 'Downtown',
      imageUrl: 'https://example.com/turf1.jpg',
      pricePerHour: 25.0,
      sports: ['Football', 'Cricket'],
      amenities: ['Showers', 'Parking', 'Changing Rooms'],
    ),
    Turf(
      id: '2',
      name: 'Sports Arena',
      location: 'Westside',
      imageUrl: 'https://example.com/turf2.jpg',
      pricePerHour: 30.0,
      sports: ['Football', 'Basketball', 'Volleyball'],
      amenities: ['Cafeteria', 'Lockers', 'First Aid'],
    ),
    Turf(
      id: '3',
      name: 'Elite Sports Complex',
      location: 'North District',
      imageUrl: 'https://example.com/turf3.jpg',
      pricePerHour: 35.0,
      sports: ['Tennis', 'Badminton', 'Squash'],
      amenities: ['Pro Shop', 'Coaching', 'Lounge'],
    ),
    Turf(
      id: '4',
      name: 'Community Playground',
      location: 'Eastside',
      imageUrl: 'https://example.com/turf4.jpg',
      pricePerHour: 20.0,
      sports: ['Football', 'Rugby'],
      amenities: ['Parking', 'Water Station'],
    ),
  ];

  const TurfListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Turfs'),
      ),
      body: ListView.builder(
        itemCount: turfs.length,
        itemBuilder: (context, index) {
          final turf = turfs[index];
          return Card(
            child: ListTile(
              title: Text(turf.name),
              subtitle: Text(turf.location),
              trailing: Text('\$${turf.pricePerHour}/hour'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TurfDetailScreen(turf: turf),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
