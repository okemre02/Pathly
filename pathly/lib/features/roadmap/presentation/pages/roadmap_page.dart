import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/auth/auth_provider.dart';
import '../widgets/roadmap_node_widget.dart';
import '../widgets/roadmap_painter.dart';
import '../../../learning/presentation/pages/learning_page.dart';
import '../../domain/models/roadmap_enums.dart';
import '../../domain/models/roadmap_node.dart';
import '../../domain/models/sub_path.dart';

/// Roadmap visualization page - now works with SubPath
class RoadmapPage extends ConsumerStatefulWidget {
  final SubPath subPath;

  const RoadmapPage({super.key, required this.subPath});

  @override
  ConsumerState<RoadmapPage> createState() => _RoadmapPageState();
}

class _RoadmapPageState extends ConsumerState<RoadmapPage> {
  final TransformationController _transformationController =
      TransformationController();

  bool _isInitialized = false;
  late List<RoadmapNode> _nodes;

  @override
  void initState() {
    super.initState();
    _nodes = widget.subPath.nodes;
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  List<RoadmapNode> _getNodesWithProgress(List<String> completedNodes) {
    return _nodes.map((node) {
      if (completedNodes.contains(node.id)) {
        return node.copyWith(status: NodeStatus.completed);
      }

      // Check prerequisites
      bool allPrereqsCompleted =
          node.prerequisites.isEmpty ||
          node.prerequisites.every(
            (prereqId) => completedNodes.contains(prereqId),
          );

      if (allPrereqsCompleted) {
        return node.copyWith(status: NodeStatus.available);
      }

      return node.copyWith(status: NodeStatus.locked);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final completedNodes = user?.completedNodes ?? [];

    // Apply progress to nodes
    final nodes = _getNodesWithProgress(completedNodes);

    // Calculate completion percentage
    final completedCount = nodes
        .where((n) => n.status == NodeStatus.completed)
        .length;
    final totalCount = nodes.length;
    final completionPercentage = totalCount > 0
        ? completedCount / totalCount
        : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.subPath.title,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            // Progress indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceHighlight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _getProgressColor(
                    completionPercentage,
                  ).withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.pie_chart,
                    color: _getProgressColor(completionPercentage),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${(completionPercentage * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _getProgressColor(completionPercentage),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$completedCount/$totalCount",
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.center_focus_strong, color: Colors.white),
        onPressed: () {
          final viewport = MediaQuery.of(context).size;
          final x = (viewport.width / 2) - 1000.0;
          final y = (viewport.height / 2) - 200.0;

          final matrix = Matrix4.identity();
          matrix.setTranslationRaw(x, y, 0);
          _transformationController.value = matrix;
        },
      ),
      body: nodes.isEmpty
          ? const Center(child: Text("No modules available yet"))
          : LayoutBuilder(
              builder: (context, constraints) {
                if (!_isInitialized) {
                  _isInitialized = true;
                  final x = (constraints.maxWidth / 2) - 1000.0;
                  final y = (constraints.maxHeight / 2) - 200.0;

                  final matrix = Matrix4.identity();
                  matrix.setTranslationRaw(x, y, 0);
                  _transformationController.value = matrix;
                }

                return InteractiveViewer(
                  transformationController: _transformationController,
                  boundaryMargin: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.8,
                    vertical: constraints.maxHeight * 0.8,
                  ),
                  minScale: 0.1,
                  maxScale: 4.0,
                  constrained: false,
                  child: SizedBox(
                    width: 2000,
                    height: 2000,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Line Connections
                        Positioned.fill(
                          child: CustomPaint(painter: RoadmapPainter(nodes)),
                        ),

                        // Nodes
                        ...nodes.map((node) {
                          const canvasCenterX = 1000.0;
                          const canvasCenterY = 200.0;

                          return Positioned(
                            left: canvasCenterX + node.x - 80,
                            top: canvasCenterY + node.y,
                            child: RoadmapNodeWidget(
                              node: node,
                              onTap: () => _handleNodeTap(context, node),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _handleNodeTap(BuildContext context, RoadmapNode node) async {
    if (node.status == NodeStatus.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "This module is locked! Complete the prerequisites first.",
          ),
          duration: Duration(seconds: 2),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final result = await Navigator.of(context).push<bool>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LearningPage(nodeId: node.id, moduleId: node.tutorialRefId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    );

    // If module was completed, mark it
    if (result == true && mounted) {
      await ref.read(authProvider.notifier).completeNode(node.id);
      setState(() {
        // Trigger rebuild to update node statuses
      });
    }
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) return AppColors.success;
    if (progress >= 0.5) return AppColors.primary;
    if (progress >= 0.25) return AppColors.secondary;
    return AppColors.textSecondary;
  }
}
