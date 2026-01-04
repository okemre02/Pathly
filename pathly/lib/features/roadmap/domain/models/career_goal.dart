/// Represents a long-term career goal that contains multiple tech paths
class CareerGoal {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final List<String>
  pathIds; // Links to tech roadmaps (e.g., ["dart", "flutter"])

  const CareerGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.pathIds,
  });
}
