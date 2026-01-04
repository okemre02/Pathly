import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../domain/models/career_path.dart';
import '../../domain/models/sub_path.dart';
import '../../domain/models/roadmap_node.dart';
import '../../domain/models/roadmap_enums.dart';
import '../../domain/data/branching_mock_data.dart';

/// Provider for all available career paths
final careerPathsProvider = Provider<List<CareerPath>>((ref) {
  return BranchingMockData.careerPaths;
});

/// Provider to get sub-paths for a specific career path
final subPathsForCareerProvider = Provider.family<List<SubPath>, String>((
  ref,
  careerPathId,
) {
  return BranchingMockData.getSubPathsForCareer(careerPathId);
});

/// Provider to get a specific sub-path by ID
final subPathProvider = Provider.family<SubPath?, String>((ref, subPathId) {
  return BranchingMockData.getSubPath(subPathId);
});

/// Provider to check if user has selected a sub-path for a career
final userSelectedSubPathProvider = Provider.family<String?, String>((
  ref,
  careerPathId,
) {
  final authState = ref.watch(authProvider);
  final user = authState.user;

  if (user == null) return null;
  return user.selectedSubPaths[careerPathId];
});

/// Provider for the currently active roadmap nodes based on user selection
final activeRoadmapNodesProvider =
    FutureProvider.family<List<RoadmapNode>, String>((ref, careerPathId) async {
      final authState = ref.watch(authProvider);
      final user = authState.user;

      if (user == null) {
        // Not logged in - return empty or first sub-path as preview
        final subPaths = BranchingMockData.getSubPathsForCareer(careerPathId);
        if (subPaths.isEmpty) return [];
        return subPaths.first.nodes;
      }

      // Check if user has selected a sub-path for this career
      final selectedSubPathId = user.selectedSubPaths[careerPathId];

      if (selectedSubPathId == null) {
        // User hasn't selected a sub-path yet
        return [];
      }

      final subPath = BranchingMockData.getSubPath(selectedSubPathId);
      if (subPath == null) return [];

      // Update node statuses based on completed nodes
      return subPath.nodes.map((node) {
        if (user.completedNodes.contains(node.id)) {
          return node.copyWith(status: NodeStatus.completed);
        }

        // Check prerequisites
        bool allPrereqsCompleted =
            node.prerequisites.isEmpty ||
            node.prerequisites.every(
              (prereqId) => user.completedNodes.contains(prereqId),
            );

        if (allPrereqsCompleted) {
          return node.copyWith(status: NodeStatus.available);
        }

        return node.copyWith(status: NodeStatus.locked);
      }).toList();
    });

/// State for path selection flow
class PathSelectionState {
  final CareerPath? selectedCareer;
  final SubPath? selectedSubPath;
  final bool isLoading;

  const PathSelectionState({
    this.selectedCareer,
    this.selectedSubPath,
    this.isLoading = false,
  });

  PathSelectionState copyWith({
    CareerPath? selectedCareer,
    SubPath? selectedSubPath,
    bool? isLoading,
    bool clearSubPath = false,
  }) {
    return PathSelectionState(
      selectedCareer: selectedCareer ?? this.selectedCareer,
      selectedSubPath: clearSubPath
          ? null
          : (selectedSubPath ?? this.selectedSubPath),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Notifier for managing path selection
final pathSelectionProvider =
    NotifierProvider<PathSelectionNotifier, PathSelectionState>(
      PathSelectionNotifier.new,
    );

class PathSelectionNotifier extends Notifier<PathSelectionState> {
  @override
  PathSelectionState build() {
    return const PathSelectionState();
  }

  void selectCareer(CareerPath career) {
    state = state.copyWith(selectedCareer: career, clearSubPath: true);
  }

  Future<void> selectSubPath(SubPath subPath) async {
    state = state.copyWith(isLoading: true);

    // Save selection to Firestore via auth provider
    await ref
        .read(authProvider.notifier)
        .selectSubPath(subPath.parentPathId, subPath.id);

    state = state.copyWith(selectedSubPath: subPath, isLoading: false);
  }

  void reset() {
    state = const PathSelectionState();
  }
}
