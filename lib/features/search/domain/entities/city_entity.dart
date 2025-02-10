class CityEntity {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  CityEntity({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return '$name, $country';
  }
}
