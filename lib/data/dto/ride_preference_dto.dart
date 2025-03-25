import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferenceDto {
  // Static method to convert  model to JSON
  static Map<String, dynamic> toJson(RidePreference model) {
    return {
      'departure': {
        'name': model.departure.name,
        'country': model.departure.country.name,
      },
      'departureDate': model.departureDate.toIso8601String(),
      'arrival': {
        'name': model.arrival.name,
        'country': model.arrival.country.name,
      },
      'requestedSeats': model.requestedSeats,
    };
  }

  // Static method to convert JSON to  model
  static RidePreference fromJson(Map<String, dynamic> json) {
    return RidePreference(
      departure: LocationDto.fromJson(json['departure']),
      departureDate: DateTime.parse(json['departureDate']),
      arrival: LocationDto.fromJson(json['arrival']),
      requestedSeats: json['requestedSeats'],
    );
  }
}