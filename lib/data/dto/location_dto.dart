import 'package:week_3_blabla_project/model/location/locations.dart';

class LocationDto {
  // Static method to convert domain model to JSON
  static Map<String, dynamic> toJson(Location model) {
    return {
      'name': model.name,
      'country': model.country.name, // Store enum as string
    };
  }

  // Static method to convert JSON to domain model
  static Location fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      country: countryFromString(json['country']),
    );
  }

  // Helper method to convert string to Country enum
  static Country countryFromString(String value) {
    return Country.values.firstWhere(
      (e) => e.name == value,
      orElse: () => throw ArgumentError('Invalid country: $value'),
    );
  }
}