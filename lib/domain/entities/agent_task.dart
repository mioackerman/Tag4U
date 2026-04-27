import 'package:equatable/equatable.dart';

enum AgentTaskStatus { pending, running, completed, failed, cancelled }

/// Represents a single planning task dispatched to an agent.
///
/// Tasks are persisted so they can be resumed, retried, or inspected
/// after the fact (traceability).
class AgentTask extends Equatable {
  final String id;

  /// Identifies which agent type should handle this task.
  /// e.g. "group_planning", "solo_recommendation", "itinerary_synthesis"
  final String agentType;

  final AgentTaskStatus status;

  /// Serialised context blob passed to the agent (JSON string).
  /// Includes member IDs, constraints, location, etc.
  final String contextJson;

  /// Serialised result blob produced by the agent (JSON string).
  final String? resultJson;

  final String? errorMessage;

  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;

  const AgentTask({
    required this.id,
    required this.agentType,
    this.status = AgentTaskStatus.pending,
    required this.contextJson,
    this.resultJson,
    this.errorMessage,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
  });

  AgentTask copyWith({
    String? id,
    String? agentType,
    AgentTaskStatus? status,
    String? contextJson,
    String? resultJson,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) {
    return AgentTask(
      id: id ?? this.id,
      agentType: agentType ?? this.agentType,
      status: status ?? this.status,
      contextJson: contextJson ?? this.contextJson,
      resultJson: resultJson ?? this.resultJson,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, agentType, status, contextJson, resultJson,
        errorMessage, createdAt, startedAt, completedAt,
      ];
}
