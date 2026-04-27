import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/domain/entities/group_memory.dart';
import 'package:tag4u/domain/entities/relationship_edge.dart';

extension RelationshipEdgeMapper on RelationshipEdgesTableData {
  RelationshipEdge toDomain() {
    return RelationshipEdge(
      id: id,
      fromNodeId: fromNodeId,
      fromNodeType: NodeType.values.firstWhere(
        (e) => e.name == fromNodeType,
        orElse: () => NodeType.person,
      ),
      toNodeId: toNodeId,
      toNodeType: NodeType.values.firstWhere(
        (e) => e.name == toNodeType,
        orElse: () => NodeType.place,
      ),
      label: label,
      weight: weight,
      metadataJson: metadataJson,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension RelationshipEdgeEntityMapper on RelationshipEdge {
  RelationshipEdgesTableCompanion toCompanion() {
    return RelationshipEdgesTableCompanion(
      id: Value(id),
      fromNodeId: Value(fromNodeId),
      fromNodeType: Value(fromNodeType.name),
      toNodeId: Value(toNodeId),
      toNodeType: Value(toNodeType.name),
      label: Value(label),
      weight: Value(weight),
      metadataJson: Value(metadataJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension GroupMemoryMapper on GroupMemoriesTableData {
  GroupMemory toDomain(List<String> memberIds) {
    return GroupMemory(
      id: id,
      name: name,
      memberIds: memberIds,
      pastPlanIds: (jsonDecode(pastPlanIdsJson) as List).cast<String>(),
      visitedPlaceIds: (jsonDecode(visitedPlaceIdsJson) as List).cast<String>(),
      sharedPreferencesJson: sharedPreferencesJson,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension GroupMemoryEntityMapper on GroupMemory {
  GroupMemoriesTableCompanion toCompanion() {
    return GroupMemoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      pastPlanIdsJson: Value(jsonEncode(pastPlanIds)),
      visitedPlaceIdsJson: Value(jsonEncode(visitedPlaceIds)),
      sharedPreferencesJson: Value(sharedPreferencesJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
