import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/roadmap_node.dart';

/// State class used by RoadmapController
class RoadmapState {
  final AsyncValue<List<RoadmapNode>> nodes;

  const RoadmapState({
    required this.nodes,
  });

  factory RoadmapState.initial() {
    return const RoadmapState(
      nodes: AsyncValue.loading(),
    );
  }

  RoadmapState copyWith({
    AsyncValue<List<RoadmapNode>>? nodes,
  }) {
    return RoadmapState(
      nodes: nodes ?? this.nodes,
    );
  }
}
