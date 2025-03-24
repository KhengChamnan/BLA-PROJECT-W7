import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
 RidePreference? _currentPreference;
 List<RidePreference> _pastPreferences = [];
 final RidePreferencesRepository repository;
 RidesPreferencesProvider({required this.repository}) {
 // For now past preferences are fetched only 1 time
 // Your code
  _pastPreferences = repository.getPastPreferences();
 }


 RidePreference? get currentPreference => _currentPreference;
 

 //set current pref
 void setCurrentPreferrence(RidePreference? pref) {
  if(currentPreference!=pref){
    _currentPreference=pref;
  }
  
 if(pref!= null){
   _pastPreferences.removeWhere((e)=>e==pref);
    _addPreference(pref);
 }

 notifyListeners();
 }

 void _addPreference(RidePreference preference) {
  repository.addPreference(preference);
 }

 // History is returned from newest to oldest preference
 List<RidePreference> get preferencesHistory =>
_pastPreferences.reversed.toList();
}