import 'package:dartz/dartz.dart';
import 'package:tag4u/core/errors/failures.dart';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/data/local/drift/daos/graph_dao.dart';
import 'package:tag4u/data/local/drift/daos/person_dao.dart';
import 'package:tag4u/data/local/drift/mappers/graph_mapper.dart';
import 'package:tag4u/data/local/drift/mappers/person_mapper.dart';
import 'package:tag4u/domain/entities/group_memory.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/domain/entities/relationship_edge.dart';
import 'package:tag4u/domain/repositories/i_graph_repository.dart';

class GraphRepositoryImpl implements IGraphRepository {
  final GraphDao _graphDao;
  final PersonDao _personDao;

  const GraphRepositoryImpl({
    required GraphDao graphDao,
    required PersonDao personDao,
  })  : _graphDao = graphDao,
        _personDao = personDao;

  @override
  ResultFuture<List<RelationshipEdge>> getEdgesFrom(
    String fromNodeId, {
    NodeType? toNodeType,
    String? label,
  }) async {
    try {
      final rows = await _graphDao.getEdgesFrom(
        fromNodeId,
        toNodeType: toNodeType?.name,
        label: label,
      );
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<RelationshipEdge>> getEdgesTo(
    String toNodeId, {
    NodeType? fromNodeType,
    String? label,
  }) async {
    try {
      final rows = await _graphDao.getEdgesTo(
        toNodeId,
        fromNodeType: fromNodeType?.name,
        label: label,
      );
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<RelationshipEdge> upsertEdge(RelationshipEdge edge) async {
    try {
      await _graphDao.upsertEdge(edge.toCompanion());
      return Right(edge);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteEdge(String edgeId) async {
    try {
      await _graphDao.deleteEdge(edgeId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> adjustEdgeWeight(String edgeId, double delta) async {
    try {
      await _graphDao.adjustEdgeWeight(edgeId, delta);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<GroupMemory>> getGroupMemories() async {
    try {
      final rows = await _graphDao.getAllGroupMemories();
      final memories = <GroupMemory>[];
      for (final row in rows) {
        final memberRows = await _graphDao.getMembersOfGroup(row.id);
        final memberIds = memberRows.map((m) => m.personNodeId).toList();
        memories.add(row.toDomain(memberIds));
      }
      return Right(memories);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<GroupMemory?> getGroupMemoryById(String id) async {
    try {
      final row = await _graphDao.getGroupMemoryById(id);
      if (row == null) return const Right(null);
      final memberRows = await _graphDao.getMembersOfGroup(id);
      final memberIds = memberRows.map((m) => m.personNodeId).toList();
      return Right(row.toDomain(memberIds));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<GroupMemory> upsertGroupMemory(GroupMemory group) async {
    try {
      await _graphDao.upsertGroupMemory(group.toCompanion());
      // Sync member rows
      for (final memberId in group.memberIds) {
        await _graphDao.addGroupMember(group.id, memberId);
      }
      return Right(group);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteGroupMemory(String id) async {
    try {
      await _graphDao.deleteGroupMemory(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<Map<String, double>> computeGroupPreferenceVector(
    List<String> memberIds,
    String? groupMemoryId,
  ) async {
    try {
      final vector = <String, double>{};

      // Aggregate individual preference tags
      for (final memberId in memberIds) {
        final tagRows = await _personDao.getTagsForPerson(memberId);
        final tags = tagRows.map((r) => r.toDomain()).toList();

        for (final tag in tags) {
          final key = tag.label.toLowerCase().trim();
          final signedWeight = tag.sentiment == TagSentiment.negative
              ? -tag.weight
              : tag.weight;
          vector[key] = (vector[key] ?? 0.0) + signedWeight;
        }
      }

      // Normalise by member count
      if (memberIds.isNotEmpty) {
        for (final key in vector.keys.toList()) {
          vector[key] = (vector[key]! / memberIds.length).clamp(-1.0, 1.0);
        }
      }

      // Blend in group-level shared preferences if available
      if (groupMemoryId != null) {
        final groupResult = await getGroupMemoryById(groupMemoryId);
        final group = groupResult.getOrElse(() => null);
        if (group?.sharedPreferencesJson != null) {
          // TODO: Parse and merge group shared preferences JSON
        }
      }

      return Right(vector);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
