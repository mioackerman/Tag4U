import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tag4u/domain/entities/person_node.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/presentation/providers/app_providers.dart';

// ── Self person identity ──────────────────────────────────────────────────────

/// Fixed ID for the local "me" profile. Never changes.
const selfPersonId = '00000000-0000-0000-0000-000000000001';

// ── Person list (all persons including self) ──────────────────────────────────

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

// ── Self profile ──────────────────────────────────────────────────────────────

/// Returns (and auto-creates on first launch) the local user's own profile.
final selfPersonProvider =
    AsyncNotifierProvider<SelfPersonNotifier, PersonNode>(SelfPersonNotifier.new);

class SelfPersonNotifier extends AsyncNotifier<PersonNode> {
  @override
  Future<PersonNode> build() async {
    final result =
        await ref.read(personRepositoryProvider).getPersonById(selfPersonId);
    final existing = result.fold((f) => null, (p) => p);
    if (existing != null) return existing;
    return _createSelf();
  }

  Future<PersonNode> _createSelf() async {
    final now = DateTime.now();
    final self = PersonNode(
      id: selfPersonId,
      userId: 'local_user',
      name: '我',
      createdAt: now,
      updatedAt: now,
    );
    await ref.read(personRepositoryProvider).upsertPerson(self);
    ref.invalidate(personsProvider);
    return self;
  }

  Future<void> updateName(String name) async {
    final current = state.valueOrNull;
    if (current == null) return;
    final updated = current.copyWith(name: name, updatedAt: DateTime.now());
    await ref.read(personRepositoryProvider).upsertPerson(updated);
    ref.invalidate(personsProvider);
    ref.invalidateSelf();
  }
}

// ── Friends list (excludes self) ──────────────────────────────────────────────

/// All persons except the local user's own profile node.
final friendsProvider = Provider<AsyncValue<List<PersonNode>>>((ref) {
  return ref.watch(personsProvider).whenData(
    (persons) =>
        persons.where((p) => p.id != selfPersonId).toList(),
  );
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
