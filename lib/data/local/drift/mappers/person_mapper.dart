import 'dart:convert';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/data/local/drift/tables/persons_table.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';

extension PersonMapper on PersonsTableData {
  PersonNode toDomain() {
    return PersonNode(
      id: id,
      userId: userId,
      name: name,
      gender: gender,
      mbti: mbti,
      hasVehicle: hasVehicle,
      vehicleSeats: vehicleSeats,
      freeformTags: (jsonDecode(freeformTagsJson) as List).cast<String>(),
      isPrivate: isPrivate,
      countryCode: countryCode,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension PersonNodeMapper on PersonNode {
  PersonsTableCompanion toCompanion() {
    return PersonsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      gender: Value(gender),
      mbti: Value(mbti),
      hasVehicle: Value(hasVehicle),
      vehicleSeats: Value(vehicleSeats),
      freeformTagsJson: Value(jsonEncode(freeformTags)),
      isPrivate: Value(isPrivate),
      countryCode: Value(countryCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension PreferenceTagMapper on PreferenceTagsTableData {
  PreferenceTag toDomain() {
    return PreferenceTag(
      id: id,
      personNodeId: personNodeId,
      label: label,
      sentiment: TagSentiment.values.firstWhere(
        (e) => e.name == sentiment,
        orElse: () => TagSentiment.neutral,
      ),
      weight: weight,
      context: context,
      source: source,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension PreferenceTagEntityMapper on PreferenceTag {
  PreferenceTagsTableCompanion toCompanion() {
    return PreferenceTagsTableCompanion(
      id: Value(id),
      personNodeId: Value(personNodeId),
      label: Value(label),
      sentiment: Value(sentiment.name),
      weight: Value(weight),
      context: Value(context),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
