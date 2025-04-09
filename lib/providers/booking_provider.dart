import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/models/booking.dart';
import 'package:turftime/models/turf.dart';

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>(
  (ref) => BookingNotifier(),
);

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(BookingState.initial());

  void selectTurf(Turf turf) {
    state = state.copyWith(selectedTurf: turf);
  }

  void selectDateTime(DateTime dateTime) {
    state = state.copyWith(selectedDateTime: dateTime);
  }

  void addBooking(Booking booking) {
    state = state.copyWith(
      bookings: [...state.bookings, booking],
      selectedTurf: null,
      selectedDateTime: null,
    );
  }

  void cancelBooking(String bookingId) {
    state = state.copyWith(
      bookings: state.bookings.where((b) => b.id != bookingId).toList(),
    );
  }

  List<Booking> getUserBookings(String userId) {
    return state.bookings.where((b) => b.userId == userId).toList();
  }
}

class BookingState {
  final Turf? selectedTurf;
  final DateTime? selectedDateTime;
  final List<Booking> bookings;

  BookingState({
    this.selectedTurf,
    this.selectedDateTime,
    required this.bookings,
  });

  factory BookingState.initial() => BookingState(bookings: []);

  BookingState copyWith({
    Turf? selectedTurf,
    DateTime? selectedDateTime,
    List<Booking>? bookings,
  }) {
    return BookingState(
      selectedTurf: selectedTurf ?? this.selectedTurf,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
      bookings: bookings ?? this.bookings,
    );
  }
}
