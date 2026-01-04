import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'core/theme/app_colors.dart';
import 'core/widgets/pathly_logo.dart';
import 'features/home/presentation/pages/home_page.dart';

/// Splash Screen with animated Pathly logo
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Wait for splash animation
    await Future.delayed(const Duration(milliseconds: 2500));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            const PathlyLogo(size: 140, enableGlow: true, useGradient: true)
                .animate()
                .fade(duration: 800.ms)
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                ),

            const SizedBox(height: 40),

            // App Name
            Text(
                  'Pathly',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    color: Colors.white,
                  ),
                )
                .animate(delay: 400.ms)
                .fade()
                .slideY(begin: 0.3, end: 0, duration: 600.ms),

            const SizedBox(height: 12),

            // Tagline
            Text(
                  'Your Developer Journey',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                )
                .animate(delay: 700.ms)
                .fade()
                .slideY(begin: 0.2, end: 0, duration: 500.ms),

            const SizedBox(height: 60),

            // Loading indicator
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ).animate(delay: 1000.ms).fade(),
          ],
        ),
      ),
    );
  }
}
