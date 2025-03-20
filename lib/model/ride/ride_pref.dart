import '../location/locations.dart';

///
/// This model describes a ride preference.
/// A ride preference consists of the selection of a departure + arrival + a date and a number of passenger
///
class RidePreference {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  const RidePreference(
      {required this.departure,
      required this.departureDate,
      required this.arrival,
      required this.requestedSeats});



  @override
  String toString() {
    return 'RidePref(departure: ${departure.name}, '
        'departureDate: ${departureDate.toIso8601String()}, '
        'arrival: ${arrival.name}, '
        'requestedSeats: $requestedSeats)';

  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RidePreference &&
        other.departure == departure &&
        other.departureDate == departureDate &&
        other.arrival ==arrival &&
        other.requestedSeats==requestedSeats;
  }

  @override
  int get hashCode =>
      departure.hashCode ^
      departureDate.hashCode  ^
      arrival.hashCode^
      requestedSeats.hashCode;

  void main() {
    Location loc1 = Location(name: "City A", country:Country.cambodia);
    Location loc2 = Location(name: "City A" , country: Country.cambodia);

    RidePreference ride1 = RidePreference(
      departure: loc1,
      departureDate: DateTime(2025, 3, 20),
      arrival: loc2,
      requestedSeats: 2,
    );

    RidePreference ride2 = RidePreference(
      departure: loc1,
      departureDate: DateTime(2025, 3, 20),
      arrival: loc2,
      requestedSeats: 2,
    );

    print(ride1);
    print(ride1 == ride2);
  }

}
