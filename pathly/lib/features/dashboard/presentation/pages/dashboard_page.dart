import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../roadmap/domain/models/career_path.dart';
import '../../../roadmap/domain/models/sub_path.dart';
import '../../../roadmap/domain/data/branching_mock_data.dart';
import '../../../roadmap/presentation/pages/path_selection_page.dart';
import '../../../roadmap/presentation/pages/roadmap_page.dart';

/// Dashboard Page - Central hub for choosing Career Paths
/// Now supports branching: Career Path -> Sub-Path Selection -> Roadmap
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final careerPaths = BranchingMockData.careerPaths;
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Choose Your Path'),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message for logged in users
              if (user != null) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.15),
                        AppColors.secondary.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Text(
                          user.displayName.isNotEmpty
                              ? user.displayName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back, ${user.displayName}!',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            if (user.selectedSubPaths.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                '${user.completedNodes.length} modules completed',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // === CAREER PATHS SECTION ===
              const Text(
                'Career Paths',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose a career goal to start your learning journey',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),

              // Career Path Cards
              ...careerPaths.map(
                (careerPath) => _CareerPathCard(
                  careerPath: careerPath,
                  userSelectedSubPath: user?.selectedSubPaths[careerPath.id],
                  onTap: () => _handleCareerPathTap(
                    context,
                    ref,
                    careerPath,
                    user?.selectedSubPaths[careerPath.id],
                  ),
                  onReset: user?.selectedSubPaths[careerPath.id] == null
                      ? null
                      : () => _confirmReset(context, ref, careerPath.id),
                ),
              ),

              const SizedBox(height: 24),

              // Continue Learning Section (if user has active paths)
              if (user != null && user.selectedSubPaths.isNotEmpty) ...[
                const Text(
                  'Continue Learning',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pick up where you left off',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),

                ...user.selectedSubPaths.entries.map((entry) {
                  final subPath = BranchingMockData.getSubPath(entry.value);
                  if (subPath == null) return const SizedBox.shrink();

                  final completedInPath = subPath.nodes
                      .where((n) => user.completedNodes.contains(n.id))
                      .length;
                  final progress = subPath.nodes.isEmpty
                      ? 0.0
                      : completedInPath / subPath.nodes.length;

                  return _ContinueLearningCard(
                    subPath: subPath,
                    progress: progress,
                    completedCount: completedInPath,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RoadmapPage(subPath: subPath),
                        ),
                      );
                    },
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _handleCareerPathTap(
    BuildContext context,
    WidgetRef ref,
    CareerPath careerPath,
    String? existingSelection,
  ) {
    // If user already selected a sub-path for this career, go directly to roadmap
    if (existingSelection != null) {
      final subPath = BranchingMockData.getSubPath(existingSelection);
      if (subPath != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => RoadmapPage(subPath: subPath)),
        );
        return;
      }
    }

    // If career has only one sub-path, go directly to roadmap
    if (!careerPath.hasBranching) {
      final subPath = BranchingMockData.getSubPath(careerPath.subPathIds.first);
      if (subPath != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => RoadmapPage(subPath: subPath)),
        );
        return;
      }
    }

    // Show path selection for branching careers
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PathSelectionPage(careerPath: careerPath),
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref, String careerPathId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Reset Path Selection?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'This will allow you to choose a different specialization. Your progress in completed modules will be saved.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).resetSubPath(careerPathId);
            },
            child: const Text(
              'Reset',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

// ========== INTERNAL WIDGETS ==========

class _CareerPathCard extends StatelessWidget {
  final CareerPath careerPath;
  final String? userSelectedSubPath;
  final VoidCallback onTap;
  final VoidCallback? onReset;

  const _CareerPathCard({
    required this.careerPath,
    required this.userSelectedSubPath,
    required this.onTap,
    this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final subPaths = BranchingMockData.getSubPathsForCareer(careerPath.id);
    final hasSelection = userSelectedSubPath != null;

    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: hasSelection
              ? AppColors.success.withValues(alpha: 0.5)
              : AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: hasSelection
                      ? AppColors.success.withValues(alpha: 0.2)
                      : AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconData(careerPath.iconName),
                  color: hasSelection ? AppColors.success : AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            careerPath.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (careerPath.hasBranching)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${subPaths.length} paths',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      careerPath.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (hasSelection) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 14,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              BranchingMockData.getSubPath(
                                    userSelectedSubPath!,
                                  )?.title ??
                                  '',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.success,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (hasSelection)
                IconButton(
                  onPressed: onReset,
                  icon: const Icon(
                    Icons.refresh,
                    color: AppColors.textSecondary,
                  ),
                  tooltip: 'Reset Selection',
                )
              else
                Icon(
                  careerPath.hasBranching
                      ? Icons.call_split
                      : Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  final SubPath subPath;
  final double progress;
  final int completedCount;
  final VoidCallback onTap;

  const _ContinueLearningCard({
    required this.subPath,
    required this.progress,
    required this.completedCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _getLanguageColor(
                        subPath.language,
                      ).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getLanguageIcon(subPath.language),
                      color: _getLanguageColor(subPath.language),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subPath.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$completedCount / ${subPath.totalNodes} modules',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getProgressColor(progress),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.background,
                  valueColor: AlwaysStoppedAnimation(
                    _getProgressColor(progress),
                  ),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return AppColors.success;
    if (progress >= 0.5) return AppColors.primary;
    return AppColors.secondary;
  }

  Color _getLanguageColor(String language) {
    switch (language) {
      case 'dart':
        return const Color(0xFF0175C2);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'csharp':
        return const Color(0xFF68217A);
      case 'cpp':
        return const Color(0xFF00599C);
      case 'python':
        return const Color(0xFF3776AB);
      default:
        return AppColors.primary;
    }
  }

  IconData _getLanguageIcon(String language) {
    switch (language) {
      case 'dart':
        return Icons.flutter_dash;
      case 'javascript':
        return Icons.javascript;
      case 'csharp':
        return Icons.sports_esports;
      case 'cpp':
        return Icons.memory;
      case 'python':
        return Icons.data_object;
      default:
        return Icons.code;
    }
  }
}

IconData _getIconData(String iconName) {
  switch (iconName) {
    case 'phone_android':
      return Icons.phone_android;
    case 'sports_esports':
      return Icons.sports_esports;
    case 'analytics':
      return Icons.analytics;
    case 'code':
      return Icons.code;
    case 'terminal':
      return Icons.terminal;
    case 'web':
      return Icons.web;
    case 'memory':
      return Icons.memory;
    case 'android':
      return Icons.android;
    default:
      return Icons.school;
  }
}
