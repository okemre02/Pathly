import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../domain/models/career_path.dart';
import '../../domain/models/sub_path.dart';
import '../providers/path_selection_provider.dart';
import 'roadmap_page.dart';

/// Path Selection Page - Shows when a career path has multiple sub-paths
/// Example: User selects "Game Developer" -> Shows Unity vs Unreal options
class PathSelectionPage extends ConsumerWidget {
  final CareerPath careerPath;

  const PathSelectionPage({super.key, required this.careerPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subPaths = ref.watch(subPathsForCareerProvider(careerPath.id));
    final authState = ref.watch(authProvider);
    final selectionState = ref.watch(pathSelectionProvider);
    final isLoggedIn = authState.user != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Choose Your Path',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Career Header
              _buildCareerHeader(context),

              const SizedBox(height: 32),

              // Sub-path options
              Text(
                'Select a specialization:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              // Sub-path cards
              Expanded(
                child: ListView.builder(
                  itemCount: subPaths.length,
                  itemBuilder: (context, index) {
                    final subPath = subPaths[index];
                    return _SubPathCard(
                          subPath: subPath,
                          isLoading: selectionState.isLoading,
                          onTap: () => _handleSubPathSelection(
                            context,
                            ref,
                            subPath,
                            isLoggedIn,
                          ),
                        )
                        .animate(delay: Duration(milliseconds: 100 * index))
                        .fade()
                        .slideX(begin: 0.1, end: 0);
                  },
                ),
              ),

              // Login prompt if not logged in
              if (!isLoggedIn)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Sign in to save your progress and track completion.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 500.ms).fade(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.2),
            AppColors.secondary.withValues(alpha: 0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconData(careerPath.iconName),
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  careerPath.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  careerPath.description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fade().scale(begin: const Offset(0.95, 0.95));
  }

  void _handleSubPathSelection(
    BuildContext context,
    WidgetRef ref,
    SubPath subPath,
    bool isLoggedIn,
  ) async {
    if (isLoggedIn) {
      // Save selection to Firestore
      await ref.read(pathSelectionProvider.notifier).selectSubPath(subPath);
    }

    // Navigate to roadmap page with selected sub-path
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => RoadmapPage(subPath: subPath)),
      );
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'phone_android':
        return Icons.phone_android;
      case 'sports_esports':
        return Icons.sports_esports;
      case 'web':
        return Icons.web;
      case 'analytics':
        return Icons.analytics;
      case 'flutter_dash':
        return Icons.flutter_dash;
      case 'javascript':
        return Icons.code;
      case 'videogame_asset':
        return Icons.videogame_asset;
      case 'dns':
        return Icons.dns;
      case 'layers':
        return Icons.layers;
      default:
        return Icons.code;
    }
  }
}

class _SubPathCard extends StatelessWidget {
  final SubPath subPath;
  final bool isLoading;
  final VoidCallback onTap;

  const _SubPathCard({
    required this.subPath,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getLanguageColor(
                      subPath.language,
                    ).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getLanguageIcon(subPath.language),
                    color: _getLanguageColor(subPath.language),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subPath.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subPath.description,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildChip(
                            '${subPath.totalNodes} modules',
                            Icons.school,
                          ),
                          const SizedBox(width: 8),
                          _buildChip(
                            subPath.language.toUpperCase(),
                            Icons.code,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getLanguageColor(String language) {
    switch (language) {
      case 'dart':
        return const Color(0xFF0175C2); // Dart blue
      case 'javascript':
        return const Color(0xFFF7DF1E); // JS yellow
      case 'csharp':
        return const Color(0xFF68217A); // C# purple
      case 'cpp':
        return const Color(0xFF00599C); // C++ blue
      case 'python':
        return const Color(0xFF3776AB); // Python blue
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
