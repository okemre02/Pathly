import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/auth/auth_provider.dart';
import '../../../../core/widgets/pathly_logo.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../roadmap/domain/data/branching_mock_data.dart';
import '../../../roadmap/domain/models/quick_start_path.dart';
import '../../../roadmap/presentation/pages/roadmap_page.dart';
import '../widgets/auth_dialog.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final quickStartPaths = BranchingMockData.quickStartPaths;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80), // Space for auth controls
                  // Pathly Stencil Logo
                  const PathlyLogoAnimated(
                    size: 90,
                  ).animate().fade(duration: 600.ms).scale(delay: 200.ms),

                  const SizedBox(height: 24),

                  // Title
                  Text(
                        'Pathly',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.0,
                              color: Colors.white,
                            ),
                      )
                      .animate()
                      .fade(delay: 300.ms)
                      .slideY(begin: 0.2, end: 0, duration: 500.ms),

                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                        'Interactive Developer Roadmaps',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                      )
                      .animate()
                      .fade(delay: 500.ms)
                      .slideY(begin: 0.2, end: 0, duration: 500.ms),

                  const SizedBox(height: 40),

                  // ====== CAREER GOALS SECTION ======
                  _SectionHeader(
                    title: 'Career Goals',
                    subtitle: 'Choose a path based on your dream job',
                    icon: Icons.rocket_launch,
                  ).animate().fade(delay: 600.ms),

                  const SizedBox(height: 16),

                  // Career Goals Button -> Dashboard
                  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const DashboardPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shadowColor: AppColors.primary.withValues(
                              alpha: 0.5,
                            ),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.map_outlined, size: 20),
                              SizedBox(width: 10),
                              Text(
                                'Explore Career Paths',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fade(delay: 700.ms)
                      .scale(begin: const Offset(0.95, 0.95), delay: 700.ms),

                  const SizedBox(height: 40),

                  // ====== QUICK START SECTION ======
                  _SectionHeader(
                    title: 'Quick Start',
                    subtitle: 'Jump into a language right away',
                    icon: Icons.flash_on,
                  ).animate().fade(delay: 800.ms),

                  const SizedBox(height: 16),

                  // Quick Start Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: quickStartPaths.length,
                    itemBuilder: (context, index) {
                      final path = quickStartPaths[index];
                      return _QuickStartCard(
                            path: path,
                            onTap: () => _navigateToQuickStart(context, path),
                          )
                          .animate()
                          .fade(delay: Duration(milliseconds: 850 + index * 80))
                          .slideY(
                            begin: 0.2,
                            delay: Duration(milliseconds: 850 + index * 80),
                          );
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Error Message (if any)
          if (authState.errorMessage != null)
            Positioned(
              bottom: 100,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authState.errorMessage!,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Auth Controls (Top Right)
          Positioned(
            top: 50,
            right: 24,
            child: authState.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : (user != null
                      ? Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: AppColors.primary,
                              child: Text(
                                user.displayName.isNotEmpty
                                    ? user.displayName[0].toUpperCase()
                                    : user.email[0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              user.displayName,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () {
                                ref.read(authProvider.notifier).logout();
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            TextButton(
                              onPressed: () =>
                                  _showAuthDialog(context, ref, isLogin: true),
                              child: const Text('Login'),
                            ),
                            const SizedBox(width: 8),
                            FilledButton.tonal(
                              onPressed: () =>
                                  _showAuthDialog(context, ref, isLogin: false),
                              child: const Text('Sign Up'),
                            ),
                          ],
                        )),
          ),
        ],
      ),
    );
  }

  void _showAuthDialog(
    BuildContext context,
    WidgetRef ref, {
    required bool isLogin,
  }) {
    showDialog(
      context: context,
      builder: (context) => AuthDialog(isLogin: isLogin),
    );
  }

  void _navigateToQuickStart(BuildContext context, QuickStartPath path) {
    // Map techId to a subPath for quick learning
    final subPath = BranchingMockData.subPaths.values.firstWhere(
      (sp) => sp.language == path.techId,
      orElse: () => BranchingMockData.subPaths['flutter']!,
    );

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => RoadmapPage(subPath: subPath)));
  }
}

// ========== INTERNAL WIDGETS ==========

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickStartCard extends StatelessWidget {
  final QuickStartPath path;
  final VoidCallback onTap;

  const _QuickStartCard({required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getLanguageColor(path.techId).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getIconData(path.iconName),
                  color: _getLanguageColor(path.techId),
                  size: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                path.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  path.description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    height: 1.2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLanguageColor(String techId) {
    switch (techId) {
      case 'dart':
        return const Color(0xFF0175C2);
      case 'python':
        return const Color(0xFF3776AB);
      case 'javascript':
        return const Color(0xFFF7DF1E);
      case 'csharp':
        return const Color(0xFF68217A);
      case 'cpp':
        return const Color(0xFF00599C);
      default:
        return AppColors.primary;
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'flutter_dash':
        return Icons.flutter_dash;
      case 'data_object':
        return Icons.data_object;
      case 'javascript':
        return Icons.javascript;
      case 'sports_esports':
        return Icons.sports_esports;
      case 'memory':
        return Icons.memory;
      default:
        return Icons.code;
    }
  }
}
