import 'package:cloud_firestore/cloud_firestore.dart';
import 'roadmap_node.dart';

/// Represents a sub-path within a career path
/// Example: "Unity (C#)" under "Game Developer"
class SubPath {
  final String id;
  final String parentPathId; // e.g., 'game_dev'
  final String title;
  final String description;
  final String language; // e.g., 'csharp', 'cpp'
  final String iconName;
  final List<RoadmapNode> nodes;

  const SubPath({
    required this.id,
    required this.parentPathId,
    required this.title,
    required this.description,
    required this.language,
    this.iconName = 'code',
    this.nodes = const [],
  });

  /// Serialize to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'parentPathId': parentPathId,
      'title': title,
      'description': description,
      'language': language,
      'iconName': iconName,
      // nodes are stored as subcollection, not inline
    };
  }

  /// Deserialize from Firestore
  factory SubPath.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    List<RoadmapNode> nodes = const [],
  }) {
    final data = doc.data()!;
    return SubPath(
      id: doc.id,
      parentPathId: data['parentPathId'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      language: data['language'] as String? ?? '',
      iconName: data['iconName'] as String? ?? 'code',
      nodes: nodes,
    );
  }

  SubPath copyWith({
    String? id,
    String? parentPathId,
    String? title,
    String? description,
    String? language,
    String? iconName,
    List<RoadmapNode>? nodes,
  }) {
    return SubPath(
      id: id ?? this.id,
      parentPathId: parentPathId ?? this.parentPathId,
      title: title ?? this.title,
      description: description ?? this.description,
      language: language ?? this.language,
      iconName: iconName ?? this.iconName,
      nodes: nodes ?? this.nodes,
    );
  }

  /// Get total node count
  int get totalNodes => nodes.length;
}
