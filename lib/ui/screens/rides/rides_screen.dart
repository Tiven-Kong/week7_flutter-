import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/service/ride_prefs_service.dart';
import 'package:week_3_blabla_project/ui/screens/rides/widgets/ride_pref_modal.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import '../../../model/ride/ride_filter.dart';
import '../../provider /ride_pref_provider.dart';
import 'widgets/ride_pref_bar.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/rides_tile.dart';

class RidesScreen extends StatelessWidget {
  RidesScreen({super.key});

  final RideFilter currentFilter = RideFilter();

  // Get list of matching rides after search
  List<Ride> matchingRides(RidePreference currentPreference) =>
      RidesService.instance.getRidesFor(currentPreference, currentFilter);

  void onBackPressed(BuildContext context) {
    // Navigate back to the previous view
    Navigator.of(context).pop();
  }

  void onRidePrefSelected(RidePreference newPreference, BuildContext context) async {
    // Update the current preference
    RidePrefService.instance.setCurrentPreference(newPreference);
    context.read<RidePrefProvider>().setCurrentPreference(newPreference);
  }

  void onPreferencePressed(BuildContext context, RidePreference ridePref) async {
    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(context).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: ridePref),
      ),
    );
    if (newPreference != null) {
      // Update the preference in both service and provider
      RidePrefService.instance.setCurrentPreference(newPreference);
      context.read<RidePrefProvider>().setCurrentPreference(newPreference);
    }
  }

  void onFilterPressed() {
    // TODO: Implement filter logic here
    // This could open a filter modal or update the currentFilter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: BlaSpacings.m,
            right: BlaSpacings.m,
            top: BlaSpacings.s,
          ),
          child: Consumer<RidePrefProvider>(
            builder: (context, ridePref, child) {
              // Ensure currentPreference is not null before proceeding
              if (ridePref.currentPreference == null) {
                return const Center(child: Text("No ride preference selected"));
              }

              return Column(
                children: [
                  // Top search bar
                  RidePrefBar(
                    ridePreference: ridePref.currentPreference!,
                    onBackPressed: () => onBackPressed(context),
                    onPreferencePressed: () =>
                        onPreferencePressed(context, ridePref.currentPreference!),
                    onFilterPressed: onFilterPressed,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: matchingRides(ridePref.currentPreference!).length,
                      itemBuilder: (ctx, index) => RideTile(
                        ride: matchingRides(ridePref.currentPreference!)[index],
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}