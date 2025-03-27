import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import '../../data/repository/mock/mock_ride_preferences_repository.dart';
import 'async.dart';

class RidePrefProvider extends ChangeNotifier {
  RidePrefProvider() {
    fetchRidePreferences();
  }
  MockRidePreferencesRepository ridePreferencesRepository =
  MockRidePreferencesRepository();

  RidePreference? _currentPreference;
  RidePreference? get currentPreference => _currentPreference;
// final List<RidePreference> _pastPreference = [];
  late AsyncValue<List<RidePreference>> pastPreferences;
  // return the list of past pref



    void setCurrentPreference(RidePreference ridePreference) async {
      if (_currentPreference == ridePreference) {

      } else {
        _currentPreference = ridePreference;
        _insertRecentRidePrefToHistory(ridePreference) ;

      }
      _insertRecentRidePrefToHistory(ridePreference)
          ? Logger().d('Past Preference add successfully')
          : Logger().d('Past Preference already exists');
      notifyListeners();
    }



  bool _insertRecentRidePrefToHistory(RidePreference ridePref) {

      if (pastPreferences.data!.contains(ridePref)) {
        pastPreferences.data!.removeWhere((pastPref) => ridePref == pastPref);
        // pastPreferences.data!.add(ridePref);
        pastPreferences.data!.insert(0, ridePref);
        Logger().d('re index successfully');
        return false;
      } else {
        pastPreferences.data!.insert(0, ridePref);
        Logger().d('ride pref added');
        return true;
      }
    }

  void fetchRidePreferences() async {
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
      // 2 Fetch data
      List<RidePreference> pastPrefs =
      await ridePreferencesRepository.getPastPreferences();
      // 3 Handle success
      pastPreferences = AsyncValue.success(pastPrefs.reversed.toList());
      Logger().d('Past preferences fetched successfully');
      Logger().d(pastPrefs.reversed.toList());
      Logger().d(pastPrefs);
      // 4 Handle error
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }
}
