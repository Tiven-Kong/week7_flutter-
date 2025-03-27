import '../model/ride/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';
// import 'package:week_3_blabla_project/provider/async_value.dart';

////
///   This service handles:
///   - The past ride preferences
///   - The currennt ride preferences
///
class RidePrefService {
  // Static private instance
  static RidePrefService? _instance;

  // import '../model/ride/ride_pref.dart';
  // import '../repository/ride_preferences_repository.dart';

  // Access to past preferences
  final RidePreferencesRepository repository;

  // ////
  // ///   This service handles:
  // ///   - The past ride preferences
  // ///   - The currennt ride preferences
  // ///
  // class RidePrefService {
  //   // Static private instance
  //   static RidePrefService? _instance;

  // The current preference
  RidePreference? _currentPreference;

  //   // Access to past preferences
  //   final RidePreferencesRepository repository;

  ///
  /// Private constructor
  ///
  RidePrefService._internal(this.repository);

  //   // The current preference
  //   RidePreference? _currentPreference;

  ///
  /// Initialize
  ///

  //   ///
  //   /// Private constructor
  //   ///
  //   RidePrefService._internal(this.repository);

  ///
  /// Singleton accessor
  ///
  static RidePrefService get instance {
    if (_instance == null) {
      throw Exception(
          "RidePreferencesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  //   ///
  //   /// Initialize
  //   ///
  //   static void initialize(RidePreferencesRepository repository) {
  //     if (_instance == null) {
  //       _instance = RidePrefService._internal(repository);
  //     } else {
  //       throw Exception("RidePreferencesService is already initialized.");
  //     }
  //   }

  // Current preference
  RidePreference? get currentPreference {
    print('Get  current  pref : $_currentPreference');
    return _currentPreference;
  }


  void setCurrentPreference(RidePreference preference) {
    _currentPreference = preference;
    print('Set current pref to $_currentPreference');
  }
}

