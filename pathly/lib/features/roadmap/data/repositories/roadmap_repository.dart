import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/data/local_data_source.dart';
import '../../domain/models/roadmap_node.dart';
import '../../domain/models/roadmap_enums.dart';
import '../../domain/models/learning_module.dart';
import '../../domain/models/user_progress.dart';
import '../sources/mock_roadmap_data.dart';

/// Provider for the RoadmapRepository
final roadmapRepositoryProvider = Provider(
  (ref) => RoadmapRepository(LocalDataSource()),
);

/// A dummy repository that simulates fetching data from a backend/CMS
class RoadmapRepository {
  final LocalDataSource _localDataSource;

  RoadmapRepository(this._localDataSource);

  /// Simulates fetching the entire roadmap for a specific tech
  /// If techId is null, uses the user's selectedLanguage from progress
  Future<List<RoadmapNode>> getRoadmap({String? techId}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // 1. Determine which tech to load
    String effectiveTechId = techId ?? 'dart';
    if (techId == null) {
      final progress = await _localDataSource.loadProgress();
      effectiveTechId = progress.selectedLanguage ?? 'dart';
    }

    // 2. Get Base Mock Data for the specific tech
    final baseNodes = MockData.roadmapsByTechId[effectiveTechId] ?? [];

    // If no nodes exist for this tech, return placeholder
    if (baseNodes.isEmpty) {
      return [
        RoadmapNode(
          id: 'placeholder_$effectiveTechId',
          title: 'Coming Soon',
          description: 'This path is under development. Stay tuned!',
          prerequisites: [],
          tutorialRefId: '',
          languageType: LanguageType.dart,
          status: NodeStatus.locked,
          x: 0,
          y: 0,
        ),
      ];
    }

    final nodes = List<RoadmapNode>.from(baseNodes);

    // 3. Load Local Progress
    final progress = await _localDataSource.loadProgress();

    // 4. Merge: Update status dynamically based on progress
    return nodes.map((node) {
      if (progress.completedNodeIds.contains(node.id)) {
        return node.copyWith(status: NodeStatus.completed);
      }

      // Check prerequisites
      bool allPrereqsCompleted = true;
      if (node.prerequisites.isNotEmpty) {
        for (final prereqId in node.prerequisites) {
          if (!progress.completedNodeIds.contains(prereqId)) {
            allPrereqsCompleted = false;
            break;
          }
        }
      }

      if (allPrereqsCompleted) {
        return node.copyWith(status: NodeStatus.available);
      } else {
        return node.copyWith(status: NodeStatus.locked);
      }
    }).toList();
  }

  Future<UserProgress> getUserProgress() async {
    return _localDataSource.loadProgress();
  }

  Future<void> saveUserProgress(UserProgress progress) async {
    await _localDataSource.saveProgress(progress);
  }

  /// Simulates fetching a specific learning module
  Future<LearningModule> getModule(String moduleId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final module = MockData.learningModules.firstWhere(
      (m) => m.id == moduleId,
      orElse: () => throw Exception("Module not found"),
    );
    return module;
  }

  /// Simulates unlocking a node (updating local state)
  /// In a real app, this would sync with the backend.
  Future<void> unlockNode(String nodeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // For now, we can't really "save" to the mock constant list permanently
    // without a robust local state manager (Database), but this method
    // represents the API call.
    debugPrint("Unlocking node: $nodeId");
  }
}
