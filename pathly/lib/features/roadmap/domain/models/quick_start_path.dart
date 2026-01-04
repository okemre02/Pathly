/// Represents a direct language/technology path for quick start learning
class QuickStartPath {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final String techId; // Links to specific roadmap data

  const QuickStartPath({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.techId,
  });
}
