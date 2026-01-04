import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

/// Legacy Language Selection Page - Now redirects to Dashboard
/// The new Dashboard handles career path and sub-path selection
class LanguageSelectionPage extends ConsumerWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Redirect to Dashboard which handles all path selection now
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Choose Your Path"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.route,
                size: 80,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              const Text(
                "Welcome to Pathly!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Choose a career path to start your learning journey.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                  );
                },
                child: const Text('View Career Paths'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
