import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../core/theme/app_colors.dart';

class InstructionViewer extends StatelessWidget {
  final String markdownContent;

  const InstructionViewer({super.key, required this.markdownContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Markdown(
        data: markdownContent,
        styleSheet: MarkdownStyleSheet(
          h1: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          h2: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          p: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
          code: const TextStyle(
            backgroundColor: AppColors.background,
            color: AppColors.alienGreen,
            fontFamily: 'monospace',
          ),
          codeblockDecoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
