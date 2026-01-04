import 'roadmap_enums.dart';

class RoadmapNode {
  final String id;
  final String title;
  final String description; // Added for UI detail
  final List<String> prerequisites;
  final String tutorialRefId;
  final LanguageType languageType;
  final NodeStatus status;

  // Not in spec but essential for UI visualization (simulated position)
  // In a real DAG renderer, this might be calculated automatically.
  final double x; 
  final double y;

  const RoadmapNode({
    required this.id,
    required this.title,
    required this.description,
    required this.prerequisites,
    required this.tutorialRefId,
    required this.languageType,
    required this.status,
    this.x = 0.0,
    this.y = 0.0,
  });

  RoadmapNode copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? prerequisites,
    String? tutorialRefId,
    LanguageType? languageType,
    NodeStatus? status,
    double? x,
    double? y,
  }) {
    return RoadmapNode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      prerequisites: prerequisites ?? this.prerequisites,
      tutorialRefId: tutorialRefId ?? this.tutorialRefId,
      languageType: languageType ?? this.languageType,
      status: status ?? this.status,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}
