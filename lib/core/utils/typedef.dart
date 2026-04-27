import 'package:dartz/dartz.dart';
import 'package:tag4u/core/errors/failures.dart';

/// Standard result type used throughout the domain layer.
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;
