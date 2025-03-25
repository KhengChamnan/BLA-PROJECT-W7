import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/dto/ride_preference_dto.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";
  @override
  Future<List<RidePreference>> getPastPreferences() async {
    //get past preference from local storage
    final prefs = await SharedPreferences.getInstance();
    // Get the string list form the key
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    // Convert the string list to a list of RidePreferences – Using map()
    return prefsList
        .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<void> addPreference(RidePreference pref) async {
    
    //1.Get current preferences
    final List<RidePreference> preferences = await getPastPreferences();
    //2.Add the new preference
    preferences.add(pref);
    //3.Save the new list as a string list
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _preferencesKey,
      preferences // Changed from 'preferences' to 'prefs'
          .map((p) => jsonEncode(RidePreferenceDto.toJson(p)))
          .toList(),
    );
  }
}
