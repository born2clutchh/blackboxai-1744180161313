import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/models/booking.dart';
import 'package:turftime/models/turf.dart';

class SlotSelectionScreen extends ConsumerStatefulWidget {
  final Turf turf;
  
  const SlotSelectionScreen({super.key, required this.turf});

  @override
  ConsumerState<SlotSelectionScreen> createState() => _SlotSelectionScreenState();
}

class _SlotSelectionScreenState extends ConsumerState<SlotSelectionScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _selectedDuration = 60; // minutes

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.turf.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Selection
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Select Date'),
              subtitle: Text(_selectedDate?.toString().split(' ')[0] ?? 'Not selected'),
              onTap: _selectDate,
            ),
            
            // Time Selection
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Select Time'),
              subtitle: Text(_selectedTime?.format(context) ?? 'Not selected'),
              onTap: _selectTime,
            ),
            
            // Duration Selection
            const Text('Duration (minutes):'),
            Slider(
              value: _selectedDuration.toDouble(),
              min: 30,
              max: 180,
              divisions: 5,
              label: '$_selectedDuration mins',
              onChanged: (value) => setState(() => _selectedDuration = value.toInt()),
            ),
            
            const Spacer(),
            
            // Book Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_selectedDate == null || _selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select date and time')),
                    );
                    return;
                  }
                  
                  final authState = ref.read(authProvider);
                  final booking = Booking(
                    turfId: widget.turf.id,
                    turfName: widget.turf.name,
                    userId: authState.userId!,
                    date: _selectedDate!,
                    time: _selectedTime!,
                    duration: _selectedDuration,
                  );
                  
                  ref.read(bookingProvider.notifier).addBooking(booking);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingConfirmationScreen(booking: booking),
                    ),
                  );
                },
                child: const Text(
                  'CONFIRM BOOKING',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
