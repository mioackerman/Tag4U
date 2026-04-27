import 'package:tag4u/core/utils/typedef.dart';

/// Base class for all use cases.
abstract class UseCase<Type, Params> {
  const UseCase();
  ResultFuture<Type> call(Params params);
}

/// Use case with no parameters.
abstract class UseCaseNoParams<Type> {
  const UseCaseNoParams();
  ResultFuture<Type> call();
}

/// Use case that returns a stream.
abstract class StreamUseCase<Type, Params> {
  const StreamUseCase();
  ResultStream<Type> call(Params params);
}
