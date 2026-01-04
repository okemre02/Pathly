import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a career path that can have multiple sub-paths
/// Example: "Game Developer" with sub-paths ["Unity", "Unreal"]
class CareerPath {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final List<String> subPathIds; // IDs of available sub-paths

  const CareerPath({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.subPathIds,
  });

  /// Check if this career path has branching options
  bool get hasBranching => subPathIds.length > 1;

  /// Serialize to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'iconName': iconName,
      'subPathIds': subPathIds,
    };
  }

  /// Deserialize from Firestore
  factory CareerPath.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CareerPath(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      iconName: data['iconName'] as String? ?? 'code',
      subPathIds: List<String>.from(data['subPathIds'] ?? []),
    );
  }

  CareerPath copyWith({
    String? id,
    String? title,
    String? description,
    String? iconName,
    List<String>? subPathIds,
  }) {
    return CareerPath(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      subPathIds: subPathIds ?? this.subPathIds,
    );
  }
}
