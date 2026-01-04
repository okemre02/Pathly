import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/roadmap_enums.dart';
import '../../domain/models/roadmap_node.dart';

class RoadmapNodeWidget extends StatelessWidget {
  final RoadmapNode node;
  final VoidCallback onTap;

  const RoadmapNodeWidget({super.key, required this.node, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine styles based on status
    final isLocked = node.status == NodeStatus.locked;
    final isCompleted = node.status == NodeStatus.completed;
    final isAvailable = node.status == NodeStatus.available; // or inProgress

    Color backgroundColor = AppColors.surface;
    Color borderColor = AppColors.surfaceHighlight;
    Color iconColor = AppColors.textSecondary;

    if (isCompleted) {
      borderColor = AppColors.success;
      iconColor = AppColors.success;
      backgroundColor = AppColors.surface; // Keep dark, just border
    } else if (isAvailable) {
      backgroundColor = AppColors.surface;
      borderColor = AppColors.primary;
      iconColor = AppColors.primary;
    } else if (isLocked) {
      backgroundColor = AppColors.background;
      borderColor = Colors.white.withValues(alpha: 0.05);
      iconColor = Colors.white.withValues(alpha: 0.1);
    }

    // Determine shimmer color based on status
    Color shimmerColor = Colors.white;
    if (isCompleted) {
      shimmerColor = AppColors.success.withValues(alpha: 0.2);
    } else if (isAvailable) {
      // Use Primary (Indigo/Purple-like) but very subtle
      shimmerColor = AppColors.primary.withValues(alpha: 0.3);
    } else {
      // Locked - subtle white/grey
      shimmerColor = Colors.white.withValues(alpha: 0.1);
    }

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          HapticFeedback.lightImpact();
        } else if (isLocked) {
          HapticFeedback.vibrate();
        }
        onTap();
      },
      child:
          Container(
                width: 160,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: borderColor,
                    width: isAvailable ? 2 : 1,
                  ),
                  boxShadow: isAvailable
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isLocked
                          ? Icons.lock
                          : (isCompleted ? Icons.check_circle : Icons.code),
                      color: iconColor,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      node.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isLocked
                            ? AppColors.textSecondary.withValues(alpha: 0.5)
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    if (!isLocked) ...[
                      const SizedBox(height: 4),
                      Text(
                        node.description,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),
              )
              .animate(
                onPlay: (controller) {
                  if (isAvailable) {
                    controller.repeat(reverse: true);
                  }
                },
              )
              .scale(
                duration: 2000.ms,
                begin: const Offset(1.0, 1.0),
                end: isAvailable
                    ? const Offset(1.05, 1.05)
                    : const Offset(1.0, 1.0),
                curve: Curves.easeInOutSine,
              )
              .boxShadow(
                duration: 2000.ms,
                begin: BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
                end: BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
                curve: Curves.easeInOutSine,
              )
              .shimmer(
                duration: 1500.ms,
                color: shimmerColor,
                angle: 45,
                size: 0.5,
              ),
    );
  }
}
