import 'package:equatable/equatable.dart';

/// A person node in the preference graph.
///
/// Can represent the authenticated user themselves or a friend/companion
/// added for group-planning purposes.
class PersonNode extends Equatable {
  final String id;

  /// Non-null if this node belongs to an authenticated user account.
  final String? userId;

  final String name;

  /// Optional: male / female / non-binary / etc.
  final String? gender;

  /// MBTI type string (e.g. "INFP"). Treated as a soft hint, not a hard filter.
  final String? mbti;

  final bool hasVehicle;

  /// Number of seats available if [hasVehicle] is true.
  final int? vehicleSeats;

  /// Free-form tags: anything the user wants to express about this person.
  /// These are passed verbatim to the LLM for semantic reasoning.
  /// Examples: "hates loud music", "first date vibe", "vegetarian since 2020"
  final List<String> freeformTags;

  /// Whether this person's preference data is encrypted / private.
  final bool isPrivate;

  /// ISO-3166-1 alpha-2 country code for regional filtering.
  final String? countryCode;

  final DateTime createdAt;
  final DateTime updatedAt;

  const PersonNode({
    required this.id,
    this.userId,
    required this.name,
    this.gender,
    this.mbti,
    this.hasVehicle = false,
    this.vehicleSeats,
    this.freeformTags = const [],
    this.isPrivate = true,
    this.countryCode,
    required this.createdAt,
    required this.updatedAt,
  });

  PersonNode copyWith({
    String? id,
    String? userId,
    String? name,
    String? gender,
    String? mbti,
    bool? hasVehicle,
    int? vehicleSeats,
    List<String>? freeformTags,
    bool? isPrivate,
    String? countryCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PersonNode(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      mbti: mbti ?? this.mbti,
      hasVehicle: hasVehicle ?? this.hasVehicle,
      vehicleSeats: vehicleSeats ?? this.vehicleSeats,
      freeformTags: freeformTags ?? this.freeformTags,
      isPrivate: isPrivate ?? this.isPrivate,
      countryCode: countryCode ?? this.countryCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        gender,
        mbti,
        hasVehicle,
        vehicleSeats,
        freeformTags,
        isPrivate,
        countryCode,
        createdAt,
        updatedAt,
      ];
}
