import 'dart:convert';
import 'package:tag4u/data/local/drift/app_database.dart';
import 'package:tag4u/domain/entities/agent_task.dart';
import 'package:tag4u/domain/entities/recommendation_plan.dart';

extension AgentTaskMapper on AgentTasksTableData {
  AgentTask toDomain() {
    return AgentTask(
      id: id,
      agentType: agentType,
      status: AgentTaskStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => AgentTaskStatus.pending,
      ),
      contextJson: contextJson,
      resultJson: resultJson,
      errorMessage: errorMessage,
      createdAt: createdAt,
      startedAt: startedAt,
      completedAt: completedAt,
    );
  }
}

extension AgentTaskEntityMapper on AgentTask {
  AgentTasksTableCompanion toCompanion() {
    return AgentTasksTableCompanion(
      id: Value(id),
      agentType: Value(agentType),
      status: Value(status.name),
      contextJson: Value(contextJson),
      resultJson: Value(resultJson),
      errorMessage: Value(errorMessage),
      createdAt: Value(createdAt),
      startedAt: Value(startedAt),
      completedAt: Value(completedAt),
    );
  }
}

extension RecommendationPlanMapper on RecommendationPlansTableData {
  RecommendationPlan toDomain() {
    final rawItems = jsonDecode(itemsJson) as List;
    final items = rawItems.map((e) {
      final map = e as Map<String, dynamic>;
      return RecommendationItem(
        placeNodeId: map['placeNodeId'] as String,
        placeName: map['placeName'] as String,
        score: (map['score'] as num).toDouble(),
        rationale: map['rationale'] as String?,
        rank: map['rank'] as int,
      );
    }).toList();

    return RecommendationPlan(
      id: id,
      agentTaskId: agentTaskId,
      groupMemoryId: groupMemoryId,
      title: title,
      items: items,
      itineraryNarrative: itineraryNarrative,
      overallScore: overallScore,
      createdAt: createdAt,
    );
  }
}

extension RecommendationPlanEntityMapper on RecommendationPlan {
  RecommendationPlansTableCompanion toCompanion() {
    final itemsJson = jsonEncode(items.map((i) => {
          'placeNodeId': i.placeNodeId,
          'placeName': i.placeName,
          'score': i.score,
          'rationale': i.rationale,
          'rank': i.rank,
        }).toList());

    return RecommendationPlansTableCompanion(
      id: Value(id),
      agentTaskId: Value(agentTaskId),
      groupMemoryId: Value(groupMemoryId),
      title: Value(title),
      itemsJson: Value(itemsJson),
      itineraryNarrative: Value(itineraryNarrative),
      overallScore: Value(overallScore),
      createdAt: Value(createdAt),
    );
  }
}
