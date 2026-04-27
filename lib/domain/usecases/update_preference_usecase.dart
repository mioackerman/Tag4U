import 'package:dartz/dartz.dart';
import 'package:tag4u/core/utils/typedef.dart';
import 'package:tag4u/domain/entities/preference_tag.dart';
import 'package:tag4u/domain/repositories/i_person_repository.dart';
import 'package:tag4u/domain/usecases/base_usecase.dart';

class UpdatePreferenceParams {
  final PreferenceTag tag;

  /// If provided, adjusts existing tag weight instead of replacing the tag.
  final double? weightDelta;

  const UpdatePreferenceParams({required this.tag, this.weightDelta});
}

/// Adds or updates a preference tag, optionally adjusting its weight.
/// Called both from explicit user input and from the feedback loop.
class UpdatePreferenceUseCase extends UseCase<PreferenceTag, UpdatePreferenceParams> {
  final IPersonRepository _personRepo;

  const UpdatePreferenceUseCase({required IPersonRepository personRepo})
      : _personRepo = personRepo;

  @override
  ResultFuture<PreferenceTag> call(UpdatePreferenceParams params) async {
    if (params.weightDelta != null) {
      // Feedback-loop path: adjust weight of existing tag
      final adjustResult = await _personRepo.adjustTagWeight(
        params.tag.id,
        params.weightDelta!,
      );
      if (adjustResult.isLeft()) {
        return adjustResult.fold(
          (f) => Left(f),
          (_) => throw StateError('unreachable'),
        );
      }
      // Return updated tag
      return _personRepo.upsertTag(params.tag);
    }
    return _personRepo.upsertTag(params.tag);
  }
}
