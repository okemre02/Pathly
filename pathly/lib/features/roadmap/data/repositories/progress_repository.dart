import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../domain/models/roadmap_node.dart';
import '../../domain/data/branching_mock_data.dart';

/// Provider for the ProgressRepository
final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository(ref.read(firestoreProvider));
});

/// Repository for managing user progress and calculating completion percentages
class ProgressRepository {
  final FirebaseFirestore _firestore;

  ProgressRepository(this._firestore);

  /// Watch completed nodes for a user (reactive stream)
  Stream<List<String>> watchCompletedNodes(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return <String>[];
      final data = doc.data()!;
      return List<String>.from(data['completedNodes'] ?? []);
    });
  }

  /// Calculate completion percentage for a specific sub-path
  double calculateCompletionPercentage(
    List<String> completedNodes,
    List<RoadmapNode> pathNodes,
  ) {
    if (pathNodes.isEmpty) return 0.0;

    final completedInPath = pathNodes
        .where((node) => completedNodes.contains(node.id))
        .length;

    return completedInPath / pathNodes.length;
  }

  /// Calculate completion percentage for a sub-path by ID
  double calculateSubPathCompletion(
    List<String> completedNodes,
    String subPathId,
  ) {
    final subPath = BranchingMockData.getSubPath(subPathId);
    if (subPath == null) return 0.0;

    return calculateCompletionPercentage(completedNodes, subPath.nodes);
  }

  /// Get overall progress across all selected paths
  Map<String, double> calculateAllPathsProgress(
    List<String> completedNodes,
    Map<String, String> selectedSubPaths,
  ) {
    final progress = <String, double>{};

    for (final entry in selectedSubPaths.entries) {
      final careerPathId = entry.key;
      final subPathId = entry.value;

      progress[careerPathId] = calculateSubPathCompletion(
        completedNodes,
        subPathId,
      );
    }

    return progress;
  }

  /// Mark a node as completed in Firestore
  Future<void> completeNode(String uid, String nodeId) async {
    await _firestore.collection('users').doc(uid).update({
      'completedNodes': FieldValue.arrayUnion([nodeId]),
    });
  }

  /// Unmark a node as completed (for testing/reset)
  Future<void> uncompleteNode(String uid, String nodeId) async {
    await _firestore.collection('users').doc(uid).update({
      'completedNodes': FieldValue.arrayRemove([nodeId]),
    });
  }

  /// Reset all progress for a user
  Future<void> resetProgress(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'completedNodes': [],
    });
  }
}

/// Provider for completion percentage of a specific sub-path (reactive)
final subPathCompletionProvider = StreamProvider.family<double, String>((
  ref,
  subPathId,
) {
  final authState = ref.watch(authProvider);
  final user = authState.user;

  if (user == null) {
    return Stream.value(0.0);
  }

  final progressRepo = ref.read(progressRepositoryProvider);

  return progressRepo.watchCompletedNodes(user.uid).map((completedNodes) {
    return progressRepo.calculateSubPathCompletion(completedNodes, subPathId);
  });
});

/// Provider for overall progress across all paths (reactive)
final overallProgressProvider = StreamProvider<Map<String, double>>((ref) {
  final authState = ref.watch(authProvider);
  final user = authState.user;

  if (user == null) {
    return Stream.value({});
  }

  final progressRepo = ref.read(progressRepositoryProvider);

  return progressRepo.watchCompletedNodes(user.uid).map((completedNodes) {
    return progressRepo.calculateAllPathsProgress(
      completedNodes,
      user.selectedSubPaths,
    );
  });
});

/// Provider to get the count of completed nodes (reactive)
final completedNodesCountProvider = StreamProvider<int>((ref) {
  final authState = ref.watch(authProvider);
  final user = authState.user;

  if (user == null) {
    return Stream.value(0);
  }

  final progressRepo = ref.read(progressRepositoryProvider);

  return progressRepo
      .watchCompletedNodes(user.uid)
      .map((nodes) => nodes.length);
});

/// Provider for SubPath progress details
class SubPathProgress {
  final String subPathId;
  final String title;
  final int completedCount;
  final int totalCount;
  final double percentage;

  SubPathProgress({
    required this.subPathId,
    required this.title,
    required this.completedCount,
    required this.totalCount,
    required this.percentage,
  });
}

final subPathProgressProvider = StreamProvider.family<SubPathProgress?, String>(
  (ref, subPathId) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return Stream.value(null);
    }

    final subPath = BranchingMockData.getSubPath(subPathId);
    if (subPath == null) {
      return Stream.value(null);
    }

    final progressRepo = ref.read(progressRepositoryProvider);

    return progressRepo.watchCompletedNodes(user.uid).map((completedNodes) {
      final completedInPath = subPath.nodes
          .where((node) => completedNodes.contains(node.id))
          .length;

      final percentage = subPath.nodes.isEmpty
          ? 0.0
          : completedInPath / subPath.nodes.length;

      return SubPathProgress(
        subPathId: subPathId,
        title: subPath.title,
        completedCount: completedInPath,
        totalCount: subPath.nodes.length,
        percentage: percentage,
      );
    });
  },
);
