import 'package:equatable/equatable.dart';

/// Base class for all domain failures.
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Failures from the local database layer.
class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.code});
}

/// Failures from the Supabase remote layer.
class RemoteFailure extends Failure {
  const RemoteFailure({required super.message, super.code});
}

/// Failures from the agent / reasoning layer.
class AgentFailure extends Failure {
  const AgentFailure({required super.message, super.code});
}

/// Failures from the LLM / embedding layer.
class LlmFailure extends Failure {
  const LlmFailure({required super.message, super.code});
}

/// Failures relating to auth.
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

/// Generic unexpected failure.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message, super.code});
}
