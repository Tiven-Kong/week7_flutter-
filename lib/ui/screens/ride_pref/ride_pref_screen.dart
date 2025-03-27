import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../provider /async.dart';
import '../../../provider /ride_pref_provider.dart';
import '../../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  void onRidePrefSelected(RidePreference newPreference, BuildContext context) async {
    // 1 - Update the current preference in both service and provider
    RidePrefService.instance.setCurrentPreference(newPreference);
    context.read<RidePrefProvider>().setCurrentPreference(newPreference);

    // 2 - Navigate to the rides screen with a bottom-to-top animation
    await Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
  }

  void loader(BuildContext context) =>
      context.read<RidePrefProvider>().fetchRidePreferences();

  @override
  Widget build(BuildContext context) {
    return Consumer<RidePrefProvider>(
      builder: (context, ridePref, child) {
        final pastPref = ridePref.pastPreferences;

        switch (pastPref.state) {
          case AsyncValueState.loading:
            return const Center(child: CircularProgressIndicator.adaptive());

          case AsyncValueState.error:
            return const Center(
              child: Text('Error no internet'),
            );

          case AsyncValueState.success:
            return Stack(
              children: [
                const BlaBackground(),
                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: BlaSpacings.m),
                      Text(
                        "Your pick of rides at low price",
                        style: BlaTextStyles.heading.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 100),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
                        decoration: BoxDecoration(
                          color: Colors.white, // White background
                          borderRadius: BorderRadius.circular(16), // Rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 2.1 Display the Form to input the ride preferences
                            RidePrefForm(
                              initialPreference: ridePref.currentPreference,
                              onSubmit: (preference) =>
                                  onRidePrefSelected(preference, context),
                            ),
                            const SizedBox(height: BlaSpacings.m),
                            // 2.2 Optionally display a list of past preferences
                            SizedBox(
                              height: 200, // Set a fixed height
                              child: ListView.builder(
                                shrinkWrap: true, // Fix ListView height issue
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: pastPref.data!.length,
                                itemBuilder: (ctx, index) => RidePrefHistoryTile(
                                  ridePref: pastPref.data![index],
                                  onPressed: () =>
                                      onRidePrefSelected(pastPref.data![index], context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

          default:
            return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}