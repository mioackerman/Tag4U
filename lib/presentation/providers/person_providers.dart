import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';

// ── Person list ───────────────────────────────────────────────────────────────

final personsProvider =
    AsyncNotifierProvider<PersonsNotifier, List<PersonNode>>(PersonsNotifier.new);

class PersonsNotifier extends AsyncNotifier<List<PersonNode>> {
  @override
  Future<List<PersonNode>> build() async {
    final result = await ref.watch(personRepositoryProvider).getPersons();
    return result.fold((f) => throw Exception(f.message), (v) => v);
  }

  Future<void> upsert(PersonNode person) async {
    await ref.read(personRepositoryProvider).upsertPerson(person);
    ref.invalidateSelf();
  }

  Future<void> delete(String id) async {
    await ref.read(personRepositoryProvider).deletePerson(id);
    ref.invalidateSelf();
  }
}

/// Derives a single person by id from the cached list. Null if not found.
final personByIdProvider = Provider.family<PersonNode?, String>((ref, id) {
  return ref.watch(personsProvider).valueOrNull
      ?.firstWhere((p) => p.id == id, orElse: () => throw StateError(''));
});

// ── Tags for a specific person ────────────────────────────────────────────────

final personTagsProvider = AsyncNotifierProviderFamily<PersonTagsNotifier,
    List<PreferenceTag>, String>(PersonTagsNotifier.new);

class PersonTagsNotifier
    extends FamilyAsyncNotifier<List<PreferenceTag>, String> {
  @override
  Future<List<PreferenceTag>> build(String personNodeId) async {
    final result = await ref
        .watch(personRepositoryProvider)
        .getTagsForPerson(personNodeId);
    return result.fold((f) => throw Exception(f.message), (v) => v);
  }

  Future<void> addTag(PreferenceTag tag) async {
    await ref.read(personRepositoryProvider).upsertTag(tag);
    ref.invalidateSelf();
  }

  Future<void> removeTag(String tagId) async {
    await ref.read(personRepositoryProvider).deleteTag(tagId);
    ref.invalidateSelf();
  }
}
