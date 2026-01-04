/// User progress model (local cache only - Firestore is source of truth)
/// XP system has been replaced with percentage-based progress
class UserProgress {
  final List<String> completedNodeIds;
  final String? selectedLanguage; // Legacy field for backward compatibility

  const UserProgress({this.completedNodeIds = const [], this.selectedLanguage});

  Map<String, dynamic> toJson() {
    return {
      'completedNodeIds': completedNodeIds,
      'selectedLanguage': selectedLanguage,
    };
  }

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      completedNodeIds:
          (json['completedNodeIds'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      selectedLanguage: json['selectedLanguage'] as String?,
    );
  }

  UserProgress copyWith({
    List<String>? completedNodeIds,
    String? selectedLanguage,
  }) {
    return UserProgress(
      completedNodeIds: completedNodeIds ?? this.completedNodeIds,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  /// Calculate completion percentage for a given total node count
  double getCompletionPercentage(int totalNodes) {
    if (totalNodes == 0) return 0.0;
    return completedNodeIds.length / totalNodes;
  }
}
