import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';

abstract class IPersonRepository {
  /// Returns all person nodes owned by [userId].
  ResultFuture<List<PersonNode>> getPersons({String? userId});

  ResultFuture<PersonNode?> getPersonById(String id);

  ResultFuture<PersonNode> upsertPerson(PersonNode person);

  ResultFuture<void> deletePerson(String id);

  // --- Preference Tags ---

  ResultFuture<List<PreferenceTag>> getTagsForPerson(String personNodeId);

  ResultFuture<PreferenceTag> upsertTag(PreferenceTag tag);

  ResultFuture<void> deleteTag(String tagId);

  /// Updates [tag.weight] after a feedback event.
  ResultFuture<void> adjustTagWeight(String tagId, double delta);

  // --- Preference Card (shareable encrypted snapshot) ---

  /// Exports a person's preference data as an encrypted JSON blob.
  ResultFuture<String> exportPreferenceCard(String personNodeId, {bool encrypt = true});

  /// Imports a preference card into the local graph.
  ResultFuture<PersonNode> importPreferenceCard(String encryptedCard);
}
