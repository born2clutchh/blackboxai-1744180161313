import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:turftime/models/booking.dart';
import 'package:turftime/providers/auth_provider.dart';
import 'package:turftime/providers/booking_provider.dart';

class BookingHistoryScreen extends ConsumerWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final bookings = ref.watch(bookingProvider
        .select((state) => state.getUserBookings(authState.userId!)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        centerTitle: true,
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                'No bookings yet',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.turfName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${DateFormat('MMM d, y').format(booking.date)} '
                          'at ${booking.time.format(context)}',
                        ),
                        Text('Duration: ${booking.duration} minutes'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                ref
                                    .read(bookingProvider.notifier)
                                    .cancelBooking(booking.id);
                              },
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
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
