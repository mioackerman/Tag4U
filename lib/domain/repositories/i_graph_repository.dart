import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/relationship_edge.dart';
import 'package:tag4u/domain/entities/group_memory.dart';

abstract class IGraphRepository {
  // --- Relationship Edges ---

  /// Returns all edges originating from a node.
  ResultFuture<List<RelationshipEdge>> getEdgesFrom(
    String fromNodeId, {
    NodeType? toNodeType,
    String? label,
  });

  /// Returns all edges pointing to a node.
  ResultFuture<List<RelationshipEdge>> getEdgesTo(
    String toNodeId, {
    NodeType? fromNodeType,
    String? label,
  });

  ResultFuture<RelationshipEdge> upsertEdge(RelationshipEdge edge);

  ResultFuture<void> deleteEdge(String edgeId);

  /// Updates edge weight by [delta] (clamps to 0.0–1.0).
  ResultFuture<void> adjustEdgeWeight(String edgeId, double delta);

  // --- Group Memories ---

  ResultFuture<List<GroupMemory>> getGroupMemories();

  ResultFuture<GroupMemory?> getGroupMemoryById(String id);

  ResultFuture<GroupMemory> upsertGroupMemory(GroupMemory group);

  ResultFuture<void> deleteGroupMemory(String id);

  /// Returns the merged preference signal for [memberIds] by aggregating
  /// individual tags and past group memories.
  ResultFuture<Map<String, double>> computeGroupPreferenceVector(
    List<String> memberIds,
    String? groupMemoryId,
  );
}
