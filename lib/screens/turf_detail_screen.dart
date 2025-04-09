import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/models/turf.dart';
import 'package:turftime/providers/booking_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TurfDetailScreen extends ConsumerWidget {
  final Turf turf;

  const TurfDetailScreen({super.key, required this.turf});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(turf.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Turf image placeholder
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.image, size: 50)),
            ),
            const SizedBox(height: 16),
            Text(
              turf.location,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${turf.pricePerHour} per hour',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'Available Sports:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: turf.sports
                  .map((sport) => Chip(label: Text(sport)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Amenities:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: turf.amenities
                  .map((amenity) => Chip(label: Text(amenity)))
                  .toList(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Select Date & Time:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 30)),
              focusedDay: DateTime.now(),
              onDaySelected: (selectedDay, focusedDay) {
                ref.read(bookingProvider.notifier).selectDateTime(selectedDay);
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(bookingProvider.notifier).selectTurf(turf);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingConfirmationScreen(),
                    ),
                  );
                },
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
