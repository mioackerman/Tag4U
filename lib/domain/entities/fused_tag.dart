/// A virtual, display-only tag grouping one or more original tags.
///
/// FusedTag is never persisted. It exists only as a UI abstraction on the
/// matching page. The [originalLabels] list is the source of truth used
/// for actual matching — [displayLabel] is always one of the originals.
class FusedTag {
  final String displayLabel;
  final List<String> originalLabels;

  const FusedTag({
    required this.displayLabel,
    required this.originalLabels,
  });

  bool get isMerged => originalLabels.length > 1;

  /// Returns all original labels as a Set for fast containment checks.
  Set<String> get originalSet => originalLabels.toSet();
}
