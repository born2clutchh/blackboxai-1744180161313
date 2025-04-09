class Turf {
  final String id;
  final String name;
  final String location;
  final String imageUrl; // Can be network URL or asset path
  final double pricePerHour;
  final List<String> sports;
  final List<String> amenities;

  Turf({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.pricePerHour,
    required this.sports,
    required this.amenities,
  });
}
