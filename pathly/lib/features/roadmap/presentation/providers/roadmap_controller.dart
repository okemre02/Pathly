import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/roadmap_repository.dart';
import 'roadmap_state.dart';

final roadmapControllerProvider =
    NotifierProvider<RoadmapController, RoadmapState>(RoadmapController.new);

class RoadmapController extends Notifier<RoadmapState> {
  @override
  RoadmapState build() {
    // Trigger initial load
    Future.microtask(() => loadRoadmap());
    return RoadmapState.initial();
  }

  Future<void> loadRoadmap({String? techId}) async {
    try {
      state = state.copyWith(nodes: const AsyncValue.loading());
      final repository = ref.read(roadmapRepositoryProvider);
      final nodes = await repository.getRoadmap(techId: techId);
      state = state.copyWith(nodes: AsyncValue.data(nodes));
    } catch (e, st) {
      state = state.copyWith(nodes: AsyncValue.error(e, st));
    }
  }

  Future<void> unlockNode(String nodeId) async {
    final repository = ref.read(roadmapRepositoryProvider);
    await repository.unlockNode(nodeId);
    // In a real app, we would refresh the state.
    debugPrint("Logic to unlock node $nodeId triggered");
  }
}
