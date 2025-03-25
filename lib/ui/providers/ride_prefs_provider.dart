import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/ui/providers/async_value.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  //fetchpast preferences
  Future<void> fetchPastPreferences() async {
    //1. Set loading state
    pastPreferences = AsyncValue.loading();
    notifyListeners();

    try {
      //2. Fetch past preferences
      final prefs = await repository.getPastPreferences();
      //3. Set data state
      pastPreferences = AsyncValue.success(prefs);
    } catch (e) {
      //4. Set error state
      pastPreferences = AsyncValue.error(e);
    }
    notifyListeners();
  }

  //set current pref
  void setCurrentPreferrence(RidePreference? pref) {
    if (_currentPreference != pref) {
      _currentPreference = pref;
      notifyListeners();
    }

    if (pref != null) {
      final List<RidePreference> currentPrefs = pastPreferences.data ?? [];
      currentPrefs.removeWhere((e) => e == pref);
      _addPreference(pref);
    }
  }



  void _addPreference(RidePreference preference) async {
    await repository.addPreference(preference);

    // Use a temporary list to check for duplicates
    final List<RidePreference> currentPrefs =
        List<RidePreference>.from(pastPreferences.data ?? []);

    // Check if the preference already exists
    if (!currentPrefs.contains(preference)) {
      // Add to cache only if it doesn't already exist
      pastPreferences.data!.add(preference);
    }
    notifyListeners();
  }



  // History is returned from newest to oldest preference
  List<RidePreference> get preferencesHistory =>
      (pastPreferences.data ?? []).reversed.toList();
}
