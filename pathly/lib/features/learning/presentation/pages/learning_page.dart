import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/learning_controller.dart';
import '../widgets/instruction_viewer.dart';
import '../widgets/monaco_editor_widget.dart';

class LearningPage extends ConsumerStatefulWidget {
  final String nodeId;
  final String moduleId;

  const LearningPage({super.key, required this.nodeId, required this.moduleId});

  @override
  ConsumerState<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends ConsumerState<LearningPage> {
  double _splitRatio = 0.5; // Default 50/50 split

  @override
  void initState() {
    super.initState();
    // Load the module data
    Future.microtask(
      () => ref
          .read(learningControllerProvider.notifier)
          .loadModule(widget.moduleId, nodeId: widget.nodeId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(learningControllerProvider);

    // Listen for success state to trigger celebration
    ref.listen(learningControllerProvider, (previous, next) {
      if (!previous!.isSuccess && next.isSuccess) {
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.success.withValues(alpha: 0.5)),
            ),
            margin: const EdgeInsets.all(16),
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.success),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Module Completed!",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "+50 XP",
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          state.module.value?.title ?? "Loading...",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
      ),
      body: state.module.when(
        data: (module) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final totalHeight = constraints.maxHeight;
              // Handle height fixed to 30px
              const handleHeight = 30.0;
              final availableHeight = totalHeight - handleHeight;

              return Column(
                children: [
                  // 1. Instruction Panel (Resizable)
                  SizedBox(
                    height: availableHeight * _splitRatio,
                    child: InstructionViewer(
                      markdownContent: module.instructionText,
                    ),
                  ),

                  // 2. Resize Handle
                  GestureDetector(
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        // Calculate new ratio based on drag delta
                        double newRatio =
                            _splitRatio + (details.delta.dy / availableHeight);
                        // Clamp between 20% and 80%
                        _splitRatio = newRatio.clamp(0.2, 0.8);
                      });
                    },
                    child: Container(
                      height: handleHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceHighlight,
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                          bottom: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.unfold_more,
                          color: AppColors.textSecondary,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  // 3. Editor Header (Merged into top of editor area visually or separate)
                  // We decided to keep the header separate in previous step, let's keep it here
                  // But wait, the previous layout had divider + header.
                  // Now we have Handle. Let's put the header INSIDE the remaining space?
                  // Or put the header below the handle.
                  // Let's put the Editor Header directly below the handle.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: AppColors.surface, // Background for header
                    child: Row(
                      children: [
                        const Icon(
                          Icons.code,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Code Editor",
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 0,
                            ),
                            visualDensity: VisualDensity.compact,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: state.isExecuting
                              ? null
                              : () => ref
                                    .read(learningControllerProvider.notifier)
                                    .runCode(),
                          icon: state.isExecuting
                              ? const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.play_arrow, size: 16),
                          label: Text(
                            state.isExecuting ? "Running..." : "Run",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 4. Editor Panel (Fills remaining space)
                  Expanded(
                    child: Stack(
                      children: [
                        MonacoEditorWidget(
                          initialCode: module.initialCodeSnippet,
                          onCodeChanged: (code) {
                            ref
                                .read(learningControllerProvider.notifier)
                                .updateCode(code);
                          },
                        ),

                        // Console / Output Overlay
                        if (state.consoleOutput.isNotEmpty || state.isExecuting)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child:
                                Container(
                                  height: 150,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: AppColors.surface,
                                    border: Border(
                                      top: BorderSide(
                                        color: AppColors.surfaceHighlight,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 10,
                                        offset: Offset(0, -2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Console",
                                            style: TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          if (state.isExecuting)
                                            const SizedBox(
                                              width: 12,
                                              height: 12,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            state.consoleOutput,
                                            style: TextStyle(
                                              fontFamily: 'monospace',
                                              color: state.isSuccess
                                                  ? AppColors.success
                                                  : (state.consoleOutput
                                                            .contains('Error')
                                                        ? AppColors.error
                                                        : AppColors
                                                              .textPrimary),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().slide(
                                  begin: const Offset(0, 1),
                                  end: const Offset(0, 0),
                                  duration: 300.ms,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, stack) => Center(
          child: Text(
            "Error: $err",
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      ),
    );
  }
}
