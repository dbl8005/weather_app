import 'package:weather_app/features/search/domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel({
    required String name,
    required String country,
    required double latitude,
    required double longitude,
  }) : super(
          name: name,
          country: country,
          latitude: latitude,
          longitude: longitude,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      country: json['country'],
      latitude: json['lat'],
      longitude: json['lon'],
    );
  }
}
