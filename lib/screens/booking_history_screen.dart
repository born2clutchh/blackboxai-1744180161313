import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/models/turf.dart';
import 'package:turftime/providers/booking_provider.dart';
import 'package:intl/intl.dart';

class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, this would come from a database/API
    final List<Map<String, dynamic>> bookings = [
      {
        'turf': Turf(
          id: '1',
          name: 'Green Field',
          location: 'Downtown',
          imageUrl: 'https://example.com/turf1.jpg',
          pricePerHour: 25.0,
          sports: ['Football', 'Cricket'],
          amenities: ['Showers', 'Parking'],
        ),
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'status': 'Completed'
      },
      {
        'turf': Turf(
          id: '2',
          name: 'Sports Arena',
          location: 'Westside',
          imageUrl: 'https://example.com/turf2.jpg',
          pricePerHour: 30.0,
          sports: ['Football', 'Basketball'],
          amenities: ['Cafeteria', 'Lockers'],
        ),
        'date': DateTime.now().add(const Duration(days: 3)),
        'status': 'Upcoming'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          final turf = booking['turf'] as Turf;
          final date = booking['date'] as DateTime;
          final status = booking['status'] as String;
          final dateFormat = DateFormat('MMM dd, yyyy - hh:mm a');

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(turf.imageUrl),
                onBackgroundImageError: (_, __) => const Icon(Icons.sports_soccer),
              ),
              title: Text(turf.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateFormat.format(date)),
                  Text(
                    status,
                    style: TextStyle(
                      color: status == 'Completed' ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
              trailing: Text('\$${turf.pricePerHour}/hour'),
            ),
          );
        },
      ),
    );
  }
}
