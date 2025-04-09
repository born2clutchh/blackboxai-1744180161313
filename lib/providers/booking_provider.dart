import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turftime/models/turf.dart';

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>(
  (ref) => BookingNotifier(),
);

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(BookingState());

  void selectTurf(Turf turf) {
    state = state.copyWith(selectedTurf: turf);
  }

  void selectDateTime(DateTime dateTime) {
    state = state.copyWith(selectedDateTime: dateTime);
  }
}

class BookingState {
  final Turf? selectedTurf;
  final DateTime? selectedDateTime;

  BookingState({
    this.selectedTurf,
    this.selectedDateTime,
  });

  BookingState copyWith({
    Turf? selectedTurf,
    DateTime? selectedDateTime,
  }) {
    return BookingState(
      selectedTurf: selectedTurf ?? this.selectedTurf,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
    );
  }
}
