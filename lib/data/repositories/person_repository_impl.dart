import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:tag4u/core/errors/failures.dart';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/data/local/drift/daos/person_dao.dart';
import 'package:tag4u/data/local/drift/mappers/person_mapper.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/domain/repositories/i_person_repository.dart';
import 'package:uuid/uuid.dart';

class PersonRepositoryImpl implements IPersonRepository {
  final PersonDao _dao;
  final Uuid _uuid;

  const PersonRepositoryImpl({required PersonDao dao, required Uuid uuid})
      : _dao = dao,
        _uuid = uuid;

  @override
  ResultFuture<List<PersonNode>> getPersons({String? userId}) async {
    try {
      final rows = userId != null
          ? await _dao.getPersonsByUserId(userId)
          : await _dao.getAllPersons();
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PersonNode?> getPersonById(String id) async {
    try {
      final row = await _dao.getPersonById(id);
      return Right(row?.toDomain());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PersonNode> upsertPerson(PersonNode person) async {
    try {
      await _dao.upsertPerson(person.toCompanion());
      return Right(person);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> deletePerson(String id) async {
    try {
      await _dao.deletePerson(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<PreferenceTag>> getTagsForPerson(String personNodeId) async {
    try {
      final rows = await _dao.getTagsForPerson(personNodeId);
      return Right(rows.map((r) => r.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PreferenceTag> upsertTag(PreferenceTag tag) async {
    try {
      await _dao.upsertTag(tag.toCompanion());
      return Right(tag);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteTag(String tagId) async {
    try {
      await _dao.deleteTag(tagId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<void> adjustTagWeight(String tagId, double delta) async {
    try {
      await _dao.adjustTagWeight(tagId, delta);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<String> exportPreferenceCard(
    String personNodeId, {
    bool encrypt = true,
  }) async {
    try {
      final personResult = await getPersonById(personNodeId);
      final person = personResult.getOrElse(() => throw Exception('Person not found'));
      if (person == null) {
        return const Left(DatabaseFailure(message: 'Person not found'));
      }

      final tagsResult = await getTagsForPerson(personNodeId);
      final tags = tagsResult.getOrElse(() => []);

      final card = {
        'version': 1,
        'person': {
          'name': person.name,
          'gender': person.gender,
          'mbti': person.mbti,
          'freeformTags': person.freeformTags,
        },
        'tags': tags.map((t) => {
              'label': t.label,
              'sentiment': t.sentiment.name,
              'weight': t.weight,
              'context': t.context,
            }).toList(),
      };

      final cardJson = jsonEncode(card);

      // TODO: Implement AES encryption for encrypt=true using flutter_secure_storage
      // For now, base64 encode as a placeholder.
      if (encrypt) {
        return Right(base64Encode(utf8.encode(cardJson)));
      }
      return Right(cardJson);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<PersonNode> importPreferenceCard(String encryptedCard) async {
    try {
      // TODO: Decrypt if encrypted.
      String cardJson;
      try {
        cardJson = utf8.decode(base64Decode(encryptedCard));
      } catch (_) {
        cardJson = encryptedCard; // assume plain JSON
      }

      final card = jsonDecode(cardJson) as Map<String, dynamic>;
      final personMap = card['person'] as Map<String, dynamic>;

      final now = DateTime.now();
      final person = PersonNode(
        id: _uuid.v4(),
        name: personMap['name'] as String,
        gender: personMap['gender'] as String?,
        mbti: personMap['mbti'] as String?,
        freeformTags: (personMap['freeformTags'] as List).cast<String>(),
        createdAt: now,
        updatedAt: now,
      );

      final upsertResult = await upsertPerson(person);
      if (upsertResult.isLeft()) return upsertResult;

      // Import tags
      final rawTags = card['tags'] as List;
      for (final raw in rawTags) {
        final map = raw as Map<String, dynamic>;
        final tag = PreferenceTag(
          id: _uuid.v4(),
          personNodeId: person.id,
          label: map['label'] as String,
          sentiment: TagSentiment.values.firstWhere(
            (e) => e.name == map['sentiment'],
            orElse: () => TagSentiment.neutral,
          ),
          weight: (map['weight'] as num).toDouble(),
          context: map['context'] as String?,
          source: 'imported',
          createdAt: now,
          updatedAt: now,
        );
        await upsertTag(tag);
      }

      return Right(person);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
