import 'package:equatable/equatable.dart';

enum TagSentiment { positive, negative, neutral }

/// A preference tag attached to a [PersonNode].
///
/// Tags are intentionally free-form. They are passed to the LLM/embedding
/// layer for semantic reasoning rather than being reduced to boolean flags.
///
/// Example labels:
///   "hates crowded places"
///   "loves low-lit romantic ambiance"
///   "can't eat shellfish"
///   "prefers outdoor seating"
class PreferenceTag extends Equatable {
  final String id;

  /// The person this tag belongs to.
  final String personNodeId;

  /// Free-form label. May be a word, phrase, or full sentence.
  final String label;

  final TagSentiment sentiment;

  /// Confidence / strength of this preference (0.0 – 1.0).
  /// Updated by the feedback loop over time.
  final double weight;

  /// Optional: context in which this preference applies.
  /// e.g. "on first dates", "when tired after work"
  final String? context;

  /// Source of this tag: 'user_explicit', 'inferred', 'feedback_loop'.
  final String source;

  final DateTime createdAt;
  final DateTime updatedAt;

  const PreferenceTag({
    required this.id,
    required this.personNodeId,
    required this.label,
    this.sentiment = TagSentiment.neutral,
    this.weight = 0.5,
    this.context,
    this.source = 'user_explicit',
    required this.createdAt,
    required this.updatedAt,
  });

  PreferenceTag copyWith({
    String? id,
    String? personNodeId,
    String? label,
    TagSentiment? sentiment,
    double? weight,
    String? context,
    String? source,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PreferenceTag(
      id: id ?? this.id,
      personNodeId: personNodeId ?? this.personNodeId,
      label: label ?? this.label,
      sentiment: sentiment ?? this.sentiment,
      weight: weight ?? this.weight,
      context: context ?? this.context,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, personNodeId, label, sentiment, weight, context, source, createdAt, updatedAt];
}
